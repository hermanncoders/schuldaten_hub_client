import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

class AuthorizationManager {
  ValueListenable<List<Authorization>> get authorizations => _authorizations;
  ValueListenable<bool> get isRunning => _isRunning;

  final _authorizations = ValueNotifier<List<Authorization>>([]);
  final _isRunning = ValueNotifier<bool>(false);

  AuthorizationManager() {
    debug.warning('AuthorizationManager initialized');
  }
  Future<AuthorizationManager> init() async {
    await fetchAuthorizations();
    return this;
  }

  Future fetchAuthorizations() async {
    final client = locator.get<ApiManager>().dioClient.value;
    _isRunning.value = true;
    try {
      final response = await client.get(Endpoints.getAuthorizations);
      final authorizationss = (response.data as List)
          .map((e) => Authorization.fromJson(e))
          .toList();
      debug.success(
          'AuthorizationRepository fetched ${authorizationss.length} authorizations! | ${StackTrace.current}');
      _authorizations.value = authorizationss;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future patchPupilAuthorization(
      int pupilId, String listId, bool? value, String? comment) async {
    final client = locator.get<ApiManager>().dioClient.value;
    final data = jsonEncode({"comment": comment, "status": value});
    final response = await client.patch(
        Endpoints().patchPupilAuthorization(pupilId, listId),
        data: data);
    if (response.statusCode == 200) {
      locator<PupilManager>().patchPupilFromResponse(response.data);
      debug.success('list entry successful');
    }
  }

  Authorization getAuthorization(String authId) {
    final Authorization authorizations = _authorizations.value
        .where((element) => element.authorizationId == authId)
        .first;
    return authorizations;
  }

  PupilAuthorization getPupilAuthorization(int pupilId, String authId) {
    final Pupil pupil = locator<PupilManager>()
        .pupils
        .value
        .where((element) => element.internalId == pupilId)
        .first;

    final PupilAuthorization pupilAuthorization = pupil.authorizations!
        .where((element) => element.originAuthorization == authId)
        .first;

    return pupilAuthorization;
  }

  List<Pupil> getPupilsinAuthorization(String authorizationId) {
    final List<Pupil> pupils = locator<PupilManager>().pupils.value;

    final List<Pupil> listedPupils = pupils
        .where((pupil) => pupil.authorizations!.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();
    return listedPupils;
  }
}
