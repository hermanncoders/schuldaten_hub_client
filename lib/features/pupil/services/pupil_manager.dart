import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/models/manager_report.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_base.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

class PupilManager {
  ValueListenable<List<Pupil>> get pupils => _pupils;
  ValueListenable<Report> get operationReport => _operationReport;
  ValueListenable<bool> get isRunning => _isRunning;

  final _pupils = ValueNotifier<List<Pupil>>([]);
  final _operationReport = ValueNotifier<Report>(Report(null, null));
  final _isRunning = ValueNotifier<bool>(false);
  PupilManager();
  Future init() async {
    await getAllPupils();

    return;
  }

  List<Pupil> readPupils() {
    List<Pupil> readPupils = _pupils.value;
    return readPupils;
  }

  deletePupils() {
    _pupils.value = [];
    return;
  }

  sortPupilsByName(List<Pupil> pupils) {
    pupils.sort((a, b) => a.firstName!.compareTo(b.firstName!));
    _pupils.value = pupils;
    return;
  }

  List<Pupil> siblings(Pupil pupil) {
    if (pupil.family == null) {
      return [];
    }
    List<Pupil> pupilSiblings = [];
    final pupils = _pupils.value;
    pupilSiblings =
        pupils.where((element) => element.family == pupil.family).toList();
    pupilSiblings.remove(pupil);
    return pupilSiblings;
  }

  List<Pupil> pupilsFromPupilIds(List<int> pupilIds) {
    List<Pupil> pupilsfromPupilIds = [];
    final pupils = _pupils.value;
    pupilsfromPupilIds = pupils
        .where((element) => pupilIds.contains(element.internalId))
        .toList();
    return pupilsfromPupilIds;
  }

  bool hasLanguageSupport(DateTime? date) {
    if (date != null) {
      return date.isAfter(DateTime.now());
    }
    return false;
  }

  bool hadLanguageSupport(DateTime? date) {
    if (date != null) {
      return date.isBefore(DateTime.now());
    }
    return false;
  }

  String preschoolRevisionPredicate(int value) {
    switch (value) {
      case 0:
        return 'nicht vorhanden';
      case 1:
        return "unauffällig";
      case 2:
        return "Förderbedarf";
      case 3:
        return "AO-SF prüfen";
      default:
        return "Falscher Wert im Server";
    }
  }

  String pickupTimePredicate(String? value) {
    switch (value) {
      case null:
        return 'nicht vorhanden';
      case '0':
        return 'kein Eintrag';
      case '1':
        return "14:00 Uhr";
      case '2':
        return "15:00 Uhr";
      case '3':
        return "16:00 Uhr";
      default:
        return "Falscher Wert im Server";
    }
  }

  Future getPupils(List<int> pupilIds) async {
    // we make a request for the given list of pupil ids
    final client = locator.get<ApiManager>().dioClient.value;
    _isRunning.value = true;
    // we request the data posting a json with the id list - let's build that
    final data = jsonEncode({"pupils": pupilIds});
    // we'll need the pupilbase to parse the response - let's prepare it
    final pupilbase = locator.get<PupilBaseManager>().pupilbase.value;
    // and a list to manipulate the matched pupils
    // and outdated pupilbase that did not get a response later
    List<Pupil> matchedPupils = [];
    List<PupilBase> outdatedPupilbase = [];
    // request
    try {
      final response = await client.post(Endpoints.getPupils, data: data);
      debug.info('Pupil request sent!');
      // we have the response - let's build unidentified Pupils with it
      final pupilsWithoutId =
          (response.data as List).map((e) => Pupil.fromJson(e)).toList();
      debug.success(
          'PupilManager fetched ${pupilsWithoutId.length} pupils! | ${StackTrace.current}');
      // now we match them with the pupilbase and add the id key values
      // we need to check the length of the pupilbase now for later
      int pupilBaseLength = pupilbase.length;

      for (PupilBase pupilBaseElement in pupilbase) {
        if (pupilsWithoutId
            .where((element) => element.internalId == pupilBaseElement.id)
            .isNotEmpty) {
          var pupilMatch = pupilsWithoutId
              .where((element) => element.internalId == pupilBaseElement.id)
              .single;
          Pupil namedPupil = pupilMatch.copyWith(
              firstName: pupilBaseElement.name,
              lastName: pupilBaseElement.lastName,
              group: pupilBaseElement.group,
              schoolyear: pupilBaseElement.schoolyear,
              specialNeeds: pupilBaseElement.specialNeeds,
              gender: pupilBaseElement.gender,
              language: pupilBaseElement.language,
              family: pupilBaseElement.family,
              birthday: pupilBaseElement.birthday,
              migrationSupportEnds: pupilBaseElement.migrationSupportEnds,
              pupilSince: pupilBaseElement.pupilSince);

          matchedPupils.add(namedPupil);
        } else {
          // if the pupilbase didn't get a response from the server,
          // this means it is outdated -
          // let's remove those
          outdatedPupilbase.add(pupilBaseElement);
        }
        // now check if the pupilbase was modified - if so, store the modified base
        if (outdatedPupilbase.isNotEmpty) {
          locator<PupilBaseManager>()
              .deletePupilBaseElements(outdatedPupilbase);
        }
      }

      // sort the list alphabetically before writing to the manager
      sortPupilsByName(matchedPupils);
      _pupils.value = matchedPupils;
      // let's update the filtered pupils too
      // handle errors...
      if (matchedPupils.isEmpty) {
        debug.info('PUPILS FETCHED: No matches! | ${StackTrace.current}');
      } else {
        debug.success(
            'PUPILS FETCHED: There are ${matchedPupils.length} matches! | ${StackTrace.current}');
      }
      _isRunning.value = false;

      // //! This one gives an error
      // final pupilFilterManager = locator<PupilFilterManager>();
      // pupilFilterManager.refreshFilteredPupils();
    } on DioException catch (e) {
      // handle errors...
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
      rethrow;
    }
  }

  Future getAllPupils() async {
    // Get **all** available pupils in the pupilbase
    final pupilsToFetch =
        locator.get<PupilBaseManager>().availablePupilIds.value;
    if (pupilsToFetch.isEmpty) {
      return;
    }
    debug.warning('availablePupils im PupilManager $pupilsToFetch');
    await getPupils(pupilsToFetch);
  }

  Future getThesePupils(List<Pupil> pupils) async {
    List<int> pupilIds = [];
    for (Pupil pupil in pupils) {
      pupilIds.add(pupil.internalId);
      await getPupils(pupilIds);
    }
  }

  patchPupilFromResponse(Map<String, dynamic> pupilResponse) {
    // the response comes as a json - let's make a pupil
    final Pupil responsePupil = Pupil.fromJson(pupilResponse);
    // we need to patch the values from the pupilbase - let's find a match
    final List<PupilBase> pupilBaseList =
        locator<PupilBaseManager>().pupilbase.value;
    final PupilBase pupilbase = pupilBaseList
        .where((element) => element.id == responsePupil.internalId)
        .first;
    // now let's patch
    Pupil namedPupil = responsePupil.copyWith(
        firstName: pupilbase.name,
        lastName: pupilbase.lastName,
        group: pupilbase.group,
        schoolyear: pupilbase.schoolyear,
        specialNeeds: pupilbase.specialNeeds,
        gender: pupilbase.gender,
        language: pupilbase.language,
        family: pupilbase.family,
        birthday: pupilbase.birthday,
        migrationSupportEnds: pupilbase.migrationSupportEnds,
        pupilSince: pupilbase.pupilSince);

    // we create a list to manipulate it
    List<Pupil> pupils = List.from(_pupils.value);
    // let's find the pupil by index from the response
    int index = pupils.indexWhere(
        (element) => element.internalId == responsePupil.internalId);
    pupils[index] = namedPupil;

    // as the pupil from the response is up to date, we just
    // substitute the old one with it

    // write the new value in the manager
    _pupils.value = pupils;
    // Because we use the filtered pupils in the presentation layer,
    // we need to update the filtered list too, ideally without
    // altering the filter state
    locator<PupilFilterManager>().cloneToFilteredPupil(namedPupil);
  }

  fetchAvatarImage(File imageFile, Pupil pupil) async {
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
      options: Options(headers: {
        'x-access-token': locator<SessionManager>().credentials.value.jwt
      }),
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await patchPupilFromResponse(pupilResponse);
  }

  void changePupilCredit(int pupilId, int amountToChange) async {
    debug.info('Updating credit');
    // update the credit of a pupil
    final client = locator.get<ApiManager>().dioClient.value;
    // prepare the data for thr request
    final data = jsonEncode({"credit": amountToChange});
    final Response response =
        await client.patch(Endpoints().patchPupil(pupilId), data: data);
    // we have a response
    final Map<String, dynamic> pupilResponse = response.data;
    // handle errors
    if (response.statusCode != 200) {
      _operationReport.value = Report('warning', response.data);
      return;
    }
    // let's patch the pupil with the response
    await patchPupilFromResponse(pupilResponse);
    return;
  }

  void patchPreschoolRevisionValue(int pupilId, int value) async {
    final client = locator.get<ApiManager>().dioClient.value;
    // prepare the data for thr request
    final data = jsonEncode({"preschool_revision": value});
    final Response response =
        await client.patch(Endpoints().patchPupil(pupilId), data: data);
    // we have a response
    final Map<String, dynamic> pupilResponse = response.data;
    // handle errors
    if (response.statusCode != 200) {
      _operationReport.value = Report('warning', response.data);
      return;
    }
    // let's patch the pupil with the response
    await patchPupilFromResponse(pupilResponse);
    return;
  }

  void patchPickUpTimeValue(int pupilId, String value) async {
    final client = locator.get<ApiManager>().dioClient.value;
    // prepare the data for thr request
    final data = jsonEncode({"pick_up_time": value});
    final Response response =
        await client.patch(Endpoints().patchPupil(pupilId), data: data);
    // we have a response
    final Map<String, dynamic> pupilResponse = response.data;
    // handle errors
    if (response.statusCode != 200) {
      _operationReport.value = Report('warning', response.data);
      return;
    }
    // let's patch the pupil with the response
    await patchPupilFromResponse(pupilResponse);
    return;
  }

  void patchIndividualDevelopmentPlanValue(int pupilId, int value) async {
    final client = locator.get<ApiManager>().dioClient.value;
    // prepare the data for thr request
    final data = jsonEncode({"individual_development_plan": value});
    final Response response =
        await client.patch(Endpoints().patchPupil(pupilId), data: data);
    // we have a response
    final Map<String, dynamic> pupilResponse = response.data;
    // handle errors
    if (response.statusCode != 200) {
      _operationReport.value = Report('warning', response.data);
      return;
    }
    // let's patch the pupil with the response
    await patchPupilFromResponse(pupilResponse);
    return;
  }
}
