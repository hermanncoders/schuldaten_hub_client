import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
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
  final client = locator.get<ApiManager>().dioClient.value;
  AuthorizationManager() {
    debug.warning('AuthorizationManager initialized');
  }
  Future<AuthorizationManager> init() async {
    await fetchAuthorizations();
    return this;
  }

  Future fetchAuthorizations() async {
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
    String data = '';
    if (value == null) {
      data = jsonEncode({"comment": comment});
    } else if (comment == null) {
      data = jsonEncode({"status": value});
    } else {
      data = jsonEncode({"comment": comment, "status": value});
    }

    final response = await client.patch(
        Endpoints().patchPupilAuthorization(pupilId, listId),
        data: data);
    if (response.statusCode == 200) {
      locator<PupilManager>().patchPupilFromResponse(response.data);
      debug.success('list entry successful');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
  }

  Future postAuthorizationFile(
    File file,
    int pupilId,
    String authId,
  ) async {
    _isRunning.value = true;
    final encryptedFile = await customEncrypter.encryptFile(file);
    String fileName = encryptedFile.path.split('/').last;
    final Response response = await client.patch(
      Endpoints().patchPupilAuthorizationWithFile(pupilId, authId),
      data: FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(encryptedFile.path,
              filename: fileName),
        },
      ),
    );
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
  }

  Future deleteAuthorizationFile(
      int pupilId, String authId, String cacheKey) async {
    _isRunning.value = true;
    final Response response = await client
        .delete(Endpoints().deletePupilAuthorization(pupilId, authId));
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response
    final Map<String, dynamic> pupilResponse = response.data;
    // First we delete the cached image
    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cacheKey);
    // Then we patch the pupil with the data
    await locator<PupilManager>().patchPupilFromResponse(pupilResponse);
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

  List<Pupil> getPupilsinAuthorization(
      String authorizationId, List<Pupil> filteredPupils) {
    final List<Pupil> listedPupils = filteredPupils
        .where((pupil) => pupil.authorizations!.any((authorization) =>
            authorization.originAuthorization == authorizationId))
        .toList();
    return listedPupils;
  }
}
