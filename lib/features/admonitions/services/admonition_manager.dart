import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/models/manager_report.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';

import '../../../api/services/api_manager.dart';
import '../../../common/services/locator.dart';

class AdmonitionManager {
  final pupilManager = locator<PupilManager>();
  final schooldayManager = locator<SchooldayManager>();
  final client = locator<ApiManager>().dioClient.value;
  final endpoints = Endpoints();
  ValueListenable<Report> get operationReport => _operationReport;
  ValueListenable<bool> get isRunning => _isRunning;

  final _operationReport = ValueNotifier<Report>(Report(null, null));
  final _isRunning = ValueNotifier<bool>(false);

  AdmonitionManager(
      // this.session,
      );

  //- HELPER FUNCTIONS

  resetOperationReport() {
    _operationReport.value = Report(null, null);
  }

  _setIsRunning(bool bool) {
    _isRunning.value = bool;
  }

  //- HANDLE Admonition CARD

  int? _findAdmonitionIndex(Pupil pupil, DateTime date) {
    final int? foundAdmonitionIndex = pupil.pupilAdmonitions
        ?.indexWhere((datematch) => (datematch.admonishedDay.isSameDate(date)));
    if (foundAdmonitionIndex == null) {
      return null;
    }
    return foundAdmonitionIndex;
  }

  Pupil? _findPupilById(int pupilId) {
    final pupils = pupilManager.readPupils();
    final Pupil pupil =
        pupils.singleWhere((element) => element.internalId == pupilId);
    return pupil;
  }

  //-POST ADMONITION
  Future<void> postAdmonition(
      int pupilId, DateTime date, String type, String reason) async {
    resetOperationReport();
    _setIsRunning(true);
    final Pupil? pupil = _findPupilById(pupilId);
    final int? admonition = _findAdmonitionIndex(pupil!, date);
    if (admonition == null || admonition == -1) {
      return;
    }
    final data = jsonEncode({
      "admonished_day": date.formatForJson(),
      "admonished_pupil": pupilId,
      "admonition_reason": reason,
      "admonition_type": type,
      "file_url": null,
      "processed": false,
      "processed_at": null,
      "processed_by": null
    });
    final Response response =
        await client.post(Endpoints.postAdmonition, data: data);
    final Map<String, dynamic> pupilResponse = response.data;
    if (response.statusCode == 200) {
      _operationReport.value = Report('success', 'Eintrag erfolgreich!');
      pupilManager.patchPupilFromResponse(pupilResponse);
    }
  }

  fetchAdmonitionFile(File imageFile, Pupil pupil) async {
    final client = locator.get<ApiManager>().dioClient.value;
    // We use the server file name, which is anonymous.
    String fileName = imageFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });
    // send request
    final Response response = await client.patch(
      Endpoints().patchPupilhWithAvatar(pupil.internalId),
      data: formData,
      // Not really sure if this headers is necessary, but it helped at some point.
      // It works like this :-)
      // options: Options(headers: {
      //   'x-access-token': locator<SessionManager>().credentials.value.jwt
      // }),
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
  }
}
