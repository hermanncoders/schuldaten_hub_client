import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/models/manager_report.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';

class SessionManager {
  ValueListenable<Session> get credentials => _credentials;
  ValueListenable<bool> get isAuthenticated => _isAuthenticated;
  ValueListenable<bool> get isAdmin => _isAdmin;
  //ValueListenable<int> get credit => _credit;
  ValueListenable<Report> get operationReport => _operationReport;
  ValueListenable<bool> get isRunning => _isRunning;

  final _credentials = ValueNotifier<Session>(Session());
  final _isAuthenticated = ValueNotifier<bool>(false);
  final _isAdmin = ValueNotifier<bool>(false);
  //final _credit = ValueNotifier<int>(0);
  final _operationReport = ValueNotifier<Report>(Report(null, null));
  final _isRunning = ValueNotifier<bool>(false);

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: locator<EnvManager>().env.value.serverUrl!,
      connectTimeout: Endpoints.connectionTimeout,
      receiveTimeout: Endpoints.receiveTimeout,
      responseType: ResponseType.json,
    ),
  );

  SessionManager();
  Future<SessionManager> init() async {
    await checkStoredCredentials();
    debug.warning('SessionManager initialized!');
    return this;
  }

  authenticate(Session session) {
    _credentials.value = session;

    _isAuthenticated.value = true;
    _isAdmin.value = _credentials.value.isAdmin!;
  }

  changeSessionCredit(int value) async {
    int oldCreditValue = _credentials.value.credit!;
    Session newSession =
        _credentials.value.copyWith(credit: oldCreditValue + value);
    _credentials.value = newSession;
    await saveSession(newSession);
  }

  Future<void> checkStoredCredentials() async {
    _isRunning.value = true;
    if (await secureStorageContains('session') == true) {
      final String? storedSession = await secureStorageRead('session');
      debug.success('Session found!');
      try {
        final Session session = Session.fromJson(
          json.decode(storedSession!) as Map<String, dynamic>,
        );
        if (JwtDecoder.isExpired(session.jwt!)) {
          await secureStorageDelete('session');
          debug.warning(
              'Session was not valid - deleted! | ${StackTrace.current}');
          _isRunning.value = false;
          return;
        }
        debug.info('Stored session is valid! | ${StackTrace.current}');
        authenticate(session);
        debug.warning(
            'SessionManager: isAuthenticated is ${_isAuthenticated.value.toString()}');
        debug.warning('Calling ApiManager instance');
        registerDependentManagers(_credentials.value.jwt!);
        _isRunning.value = false;
        return;
      } catch (e) {
        debug.error(
          'Error reading session from secureStorage: $e | ${StackTrace.current}',
        );
        await secureStorageDelete('session');
        _isRunning.value = false;
        return;
      }
    } else {
      debug.info('No session found');
      _isRunning.value = false;
      return;
    }
  }

  String tokenLifetimeLeft(String token) {
    Duration remainingTime = JwtDecoder.getRemainingTime(token);
    String days = remainingTime.inDays == 1 ? 'Tag' : 'Tage';
    String hours = remainingTime.inHours == 1 ? 'Stunde' : 'Stunden';
    String minutes = remainingTime.inMinutes == 1 ? 'Minute' : 'Minuten';
    String timeLeft =
        '${remainingTime.inDays} $days, ${remainingTime.inHours % 24} $hours, ${remainingTime.inMinutes % 60} $minutes';
    return timeLeft;
  }

  Future<int> refreshToken(String password) async {
    final String username = _credentials.value.username!;
    String auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await _dio.get(Endpoints.login,
        options: Options(headers: <String, String>{'Authorization': auth}));
    if (response.statusCode == 200) {
      final Session session =
          Session.fromJson(response.data).copyWith(username: username);
      authenticate(session);
      await saveSession(_credentials.value);
      locator<ApiManager>().setApi(_credentials.value.jwt!);
      return response.statusCode!;
    }
    return response.statusCode!;
  }

  Future<bool> attemptLogin(String? username, String? password) async {
    String auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    _operationReport.value = Report(null, null);
    _isRunning.value = true;
    final response = await _dio.get(Endpoints.login,
        options: Options(headers: <String, String>{'Authorization': auth}));
    if (response.statusCode == 200) {
      final Session session =
          Session.fromJson(response.data).copyWith(username: username);
      authenticate(session);
      await saveSession(_credentials.value);
      registerDependentManagers(_credentials.value.jwt!);
      await locator.allReady();
      _isRunning.value = false;
      return true;
    }
    if (response.statusCode == 401) {
      _operationReport.value =
          Report('error', 'Login fehlgeschlagen - falsches Passwort!');
      return false;
    }
    _isRunning.value = false;
    return false;
  }

  Future<void> saveSession(Session session) async {
    final jsonSession = json.encode(session.toJson());
    await secureStorageWrite('session', jsonSession);
    debug.success('Session stored');
    debug.success(jsonSession);
    return;
  }

  logout() async {
    _operationReport.value = Report(null, null);
    _isRunning.value = true;
    await secureStorageDelete('session');
    //await secureStorageDelete('pupilBase');
    locator.get<BottomNavManager>().setBottomNavPage(0);
    _isAuthenticated.value = false;
    _operationReport.value =
        Report('success', 'Zugangsdaten und QR-IDs gelöscht');
    _isRunning.value = false;
    locator.unregister<ApiManager>();
    locator.unregister<SchooldayManager>();
    locator.unregister<GoalManager>();
    locator.unregister<PupilManager>();
    locator.unregister<PupilFilterManager>();
    locator.unregister<CompetenceFilterManager>();
    locator.unregister<CompetenceManager>();
    locator.unregister<SchoolListManager>();
    locator.unregister<AuthorizationManager>();
    locator.unregister<AttendanceManager>();
    locator.unregister<AdmonitionManager>();
    return;
  }
}
