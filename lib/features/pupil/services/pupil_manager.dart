import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/models/manager_report.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';

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
  final client = locator.get<ApiManager>().dioClient.value;
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

  updatePupilInRepository(Pupil pupil) {
    List<Pupil> pupils = List.from(_pupils.value);
    int index =
        pupils.indexWhere((element) => element.internalId == pupil.internalId);
    pupils[index] = pupil;

    _pupils.value = pupils;
    locator<PupilFilterManager>().cloneToFilteredPupil(pupil);
  }

  sortPupilsByName(List<Pupil> pupils) {
    pupils.sort((a, b) => a.firstName!.compareTo(b.firstName!));
    _pupils.value = pupils;
    return;
  }

  Pupil findPupilById(int pupilId) {
    final pupils = _pupils.value;
    final Pupil pupil =
        pupils.singleWhere((element) => element.internalId == pupilId);
    return pupil;
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

  List<int> pupilIdsFromPupils(List<Pupil> pupils) {
    List<int> pupilIds = [];
    for (Pupil pupil in pupils) {
      pupilIds.add(pupil.internalId);
    }
    return pupilIds;
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
        return 'k.A.';
      case '0':
        return '14:00';
      case '1':
        return "14:00";
      case '2':
        return "15:00";
      case '3':
        return "16:00";
      default:
        return "Falscher Wert im Server";
    }
  }

  String communicationPredicate(String? value) {
    switch (value) {
      case null:
        return 'keine Angabe';
      case '0':
        return 'nicht';
      case '1':
        return "einfache Anliegen";
      case '2':
        return "komplexere Informationen";
      case '3':
        return "ohne Probleme";
      case '4':
        return "unbekannt";
      default:
        return "Falscher Wert im Server";
    }
  }

  patchPupilsWithMissedClasses(List<MissedClass> missedClasses) {
    final List<Pupil> pupils = List.from(_pupils.value);
    final DateTime schoolday = missedClasses[0].missedDay;
    for (MissedClass missedClass in missedClasses) {
      int missedPupil = pupils.indexWhere(
          (element) => element.internalId == missedClass.missedPupilId);
      if (missedPupil == -1) {
        debug.error('${missedClass.missedPupilId} not found');
        continue;
      }
      int missedClassIndex = pupils[missedPupil]
          .pupilMissedClasses!
          .indexWhere((element) => element.missedDay == missedClass.missedDay);
      //debugger();
      if (missedClassIndex == -1) {
        pupils[missedPupil] = pupils[missedPupil].copyWith(
          pupilMissedClasses: [
            ...pupils[missedPupil].pupilMissedClasses!,
            missedClass,
          ],
        );
      } else {
        List<MissedClass> updatedMissedClasses =
            List.from(pupils[missedPupil].pupilMissedClasses!);
        updatedMissedClasses[missedClassIndex] = missedClass;
        pupils[missedPupil] = pupils[missedPupil].copyWith(
          pupilMissedClasses: updatedMissedClasses,
        );
      }
    }
    for (Pupil pupil in pupils) {
      if (pupil.pupilMissedClasses != null) {
        int missedClassIndex = pupil.pupilMissedClasses!
            .indexWhere((element) => element.missedDay == schoolday);
        if (missedClassIndex != -1 &&
            !missedClasses.any((element) =>
                element.missedDay == schoolday &&
                element.missedPupilId == pupil.internalId)) {
          List<MissedClass> updatedMissedClasses =
              List.from(pupil.pupilMissedClasses!);
          updatedMissedClasses.removeAt(missedClassIndex);
          pupils[pupils.indexOf(pupil)] = pupils[pupils.indexOf(pupil)]
              .copyWith(pupilMissedClasses: updatedMissedClasses);
        }
      }
    }
    _pupils.value = pupils;

    locator<PupilFilterManager>().updateFilteredPupils();
  }

  Future fetchPupilsById(List<int> pupilIds) async {
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
      final pupilsWithoutBase =
          (response.data as List).map((e) => Pupil.fromJson(e)).toList();
      debug.success(
          'PupilManager fetched ${pupilsWithoutBase.length} pupils! | ${StackTrace.current}');
      // now we match them with the pupilbase and add the id key values

      for (PupilBase pupilBaseElement in pupilbase) {
        if (pupilsWithoutBase
            .where((element) => element.internalId == pupilBaseElement.id)
            .isNotEmpty) {
          Pupil pupilMatch = pupilsWithoutBase
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
          // print the internal_id of every element of the outdated pupilbase in one string
          String deletedPupils = '';
          for (PupilBase element in outdatedPupilbase) {
            deletedPupils += '${element.id}, ';
          }
          debug.warning(
              '$deletedPupils had no match and have been deleted from the pupilbase! | ${StackTrace.current}');
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
      if (locator.isReadySync<PupilFilterManager>()) {
        locator<PupilFilterManager>().updateFilteredPupils();
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

  Future fetchShownPupils() async {
    if (locator.isReadySync<PupilFilterManager>()) {
      final List<Pupil> shownPupils =
          locator<PupilFilterManager>().filteredPupils.value;
      final List<int> shownPupilIds = pupilIdsFromPupils(shownPupils);
      await fetchPupilsById(shownPupilIds);
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
    await fetchPupilsById(pupilsToFetch);
  }

  Future fetchThesePupils(List<Pupil> pupils) async {
    List<int> pupilIds = [];
    for (Pupil pupil in pupils) {
      pupilIds.add(pupil.internalId);
      await fetchPupilsById(pupilIds);
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

    // write the new value in the manager
    _pupils.value = pupils;
    // Because we use the filtered pupils in the presentation layer,
    // we need to update the filtered list too, ideally without
    // altering the filter state
    locator<PupilFilterManager>().cloneToFilteredPupil(namedPupil);
  }

  postAvatarImage(File imageFile, Pupil pupil) async {
    final encryptedFile = await customEncrypter.encryptFile(imageFile);
    // send request
    String fileName = encryptedFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });
    // send request
    final Response response = await client.patch(
      Endpoints().patchPupilhWithAvatar(pupil.internalId),
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    await patchPupilFromResponse(pupilResponse);
  }

  deleteAvatarImage(int pupilId) async {
    // send request
    final Response response = await client.delete(
      Endpoints().deletePupilAvatar(pupilId),
      options: Options(headers: {
        'x-access-token': locator<SessionManager>().credentials.value.jwt
      }),
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong deleting the avatar');
      return;
    }
    final Pupil pupil = (findPupilById(pupilId)).copyWith(avatarUrl: null);
    updatePupilInRepository(pupil);
    // Success! We have a pupil response - let's patch the pupil with the data
  }

  Future<void> patchPupil(int pupilId, String jsonKey, var value) async {
    // prepare the data for the request
    final data = jsonEncode({jsonKey: value});
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
