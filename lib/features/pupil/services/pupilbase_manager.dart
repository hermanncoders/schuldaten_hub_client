import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/models/manager_report.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';

import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_base.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';

class PupilBaseManager {
  ValueListenable<List<PupilBase>> get pupilbase => _pupilbase;
  ValueListenable<List<int>> get availablePupilIds => _availablePupilIds;
  ValueListenable<Report> get operationReport => _operationReport;
  ValueListenable<bool> get isRunning => _isRunning;

  final _pupilbase = ValueNotifier<List<PupilBase>>([]);
  final _availablePupilIds = ValueNotifier<List<int>>([]);
  final _operationReport = ValueNotifier<Report>(Report(null, null));
  final _isRunning = ValueNotifier<bool>(false);
  PupilBaseManager();

  Future<PupilBaseManager> init() async {
    await getStoredPupilBase();
    return this;
  }

  //- Reviewed
  Future deleteData() async {
    _isRunning.value = true;
    await secureStorageDelete('pupilBase');
    _pupilbase.value = [];
    locator<PupilManager>().deletePupils();
    locator<PupilFilterManager>().deleteFilteredPupils();
    _availablePupilIds.value = [];
    _isRunning.value = false;
  }

  //- Reviewed
  Future getStoredPupilBase() async {
    debug.warning('GETPUPILBASE Getting the stored pupilbase');
    List<PupilBase> storedPupilBase = [];
    bool pupilBaseExists = await secureStorage.containsKey(key: 'pupilBase');
    if (pupilBaseExists == true) {
      debug.warning('GETPUPILBASE There is a pupilbase');
      List<int> pupilIds = [];
      String? storedString = await secureStorageRead('pupilBase');
      storedPupilBase = (json.decode(storedString!) as List)
          .map((i) => PupilBase.fromJson(i))
          .toList();
      _pupilbase.value = storedPupilBase;
      // let's fill _availablePupilIds too
      for (PupilBase pupil in storedPupilBase) {
        pupilIds.add(pupil.id);
      }
      _availablePupilIds.value = pupilIds;
      //- This would be great place for SIGNAL READY!!!
      debug.info(
          'GETPUPILBASE Pupilbase loaded - Length is ${_pupilbase.value.length} | ${StackTrace.current}');
      return;
    } else {
      debug.info(
          'GETPUPILBASE No pupilBase in storage! | ${StackTrace.current}');
      return;
    }
  }

  scanNewPupilBase(BuildContext context) async {
    final String? scanResult = await scanner(context);
    if (scanResult != null) {
      addNewPupilBase(scanResult);
    } else {
      if (context.mounted) {
        snackbarWarning(context, 'Scanvorgang abgebrochen');
      }
    }
  }

  setNewPupilBase(List<PupilBase> pupilBase) async {
    _pupilbase.value = pupilBase;
    await secureStorageWrite('pupilBase', jsonEncode(pupilBase));
  }

  //- Reviewed
  void addNewPupilBase(String scanResult) async {
    final String? decryptedResult = await customEncrypter.decrypt(scanResult);

    List<PupilBase> oldPupilbase = _pupilbase.value;

    // The pupils in the string are separated by a '\n' - let's split them apart
    List splittedPupilBase = decryptedResult!.split('\n');

    // The properties are separated by commas, let's build the pupilbase objects with them
    List<PupilBase> scannedPupilBase = [];
    for (String data in splittedPupilBase) {
      if (data != '') {
        List splittedData = data.split(',');
        final schoolyear = splittedData[4] == '03'
            ? 'S3'
            : splittedData[4] == '04'
                ? 'S4'
                : splittedData[4];
        scannedPupilBase.add(PupilBase(
          id: int.parse(splittedData[0]),
          name: splittedData[1],
          lastName: splittedData[2],
          group: splittedData[3],
          schoolyear: schoolyear,
          specialNeeds: splittedData[5] == ''
              ? null
              : '${splittedData[5]}${splittedData[6]}',
          gender: splittedData[7],
          language: splittedData[8],
          family: splittedData[9] == '' ? null : splittedData[9],
          birthday: DateTime.tryParse(splittedData[10])!,
          migrationSupportEnds: splittedData[11] == ''
              ? null
              : DateTime.tryParse(splittedData[11])!,
          pupilSince: DateTime.tryParse(splittedData[12])!,
        ));
      }
    }
    // Now we need to combine it with the stored pupilbase -
    // old elements not present in the new pupilbase are added
    List<PupilBase> newPupilBase = List<PupilBase>.from(scannedPupilBase);
    for (PupilBase oldPupil in oldPupilbase) {
      if (newPupilBase.where((element) => element.id == oldPupil.id).isEmpty) {
        newPupilBase.add(oldPupil);
      }
    }
    _pupilbase.value = newPupilBase;
    // we have a new pupilbase - let's update _availablePupilIds too
    List<int> availablePupils = [];
    for (PupilBase pupil in _pupilbase.value) {
      availablePupils.add(pupil.id);
    }
    _availablePupilIds.value = availablePupils;

    await secureStorageWrite('pupilBase', jsonEncode(_pupilbase.value));
    debug.success(
        'Pupilbase extended: ${oldPupilbase.length} pupils before, now ${_pupilbase.value.length} | ${StackTrace.current}');
    await locator<PupilManager>().getAllPupils();

    locator<BottomNavManager>().setBottomNavPage(0);
  }

  void importPupilsFromTxt(String scanResult) async {
    List<PupilBase> oldPupilbase = _pupilbase.value;

    // The pupils in the string are separated by a line break - let's split them out
    List splittedPupilBase = scanResult.split('\n');
    // prepare a string for updating pupils in the server later
    String updatedPupils = '';
    // The properties are separated by commas, let's build the pupilbase objects with them
    List<PupilBase> scannedPupilBase = [];
    for (String data in splittedPupilBase) {
      if (data != '') {
        List splittedData = data.split(',');
        final schoolyear = splittedData[4] == '03'
            ? 'S3'
            : splittedData[4] == '04'
                ? 'S4'
                : splittedData[4];
        scannedPupilBase.add(PupilBase(
          id: int.parse(splittedData[0]),
          name: splittedData[1],
          lastName: splittedData[2],
          group: splittedData[3],
          schoolyear: schoolyear,
          specialNeeds: splittedData[5] == ''
              ? null
              : '${splittedData[5]}${splittedData[6]}',
          gender: splittedData[7],
          language: splittedData[8],
          family: splittedData[9] == '' ? null : splittedData[9],
          birthday: DateTime.tryParse(splittedData[10])!,
          migrationSupportEnds: splittedData[11] == ''
              ? null
              : DateTime.tryParse(splittedData[11])!,
          pupilSince: DateTime.tryParse(splittedData[12])!,
        ));
        final bool ogsStatus = splittedData[13] == 'OFFGANZ' ? true : false;
        final pupilString = '${int.parse(splittedData[0])},$ogsStatus';
        updatedPupils += '$pupilString\n';
      }
    }
    // let's update the pupils in the server with a txt file
    // First we generate a txt file with updatedPupils
    final textFile = File('temp.txt')..writeAsStringSync(updatedPupils);
    final client = locator.get<ApiManager>().dioClient.value;
    String fileName = textFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        textFile.path,
        filename: fileName,
      ),
    });
    final response = await client.post(
      Endpoints.exportPupilsTxt,
      data: formData,
      // Not really sure if these headers are necessary, but it helped at some point.
      // It works like this :-)
      options: Options(headers: {
        'x-access-token': locator<SessionManager>().credentials.value.jwt
      }),
    );
    debug.warning('RESPONSE is ${response.data}');
    //locator<PupilManager>().patchPupilFromResponse(pupilResponse: response.data);
    // we got now the updated data, let's substitute the old pupilbase
    //textFile.delete();
    _pupilbase.value = scannedPupilBase;
    // old elements not present in the new pupilbase are added
    List<PupilBase> newPupilBase = List<PupilBase>.from(scannedPupilBase);
    for (PupilBase oldPupil in oldPupilbase) {
      if (newPupilBase.where((element) => element.id == oldPupil.id).isEmpty) {
        newPupilBase.add(oldPupil);
      }
    }
    _pupilbase.value = newPupilBase;
    // we have a new pupilbase - let's update _availablePupilIds too
    List<int> availablePupils = [];
    for (PupilBase pupil in _pupilbase.value) {
      availablePupils.add(pupil.id);
    }
    _availablePupilIds.value = availablePupils;

    await secureStorageWrite('pupilBase', jsonEncode(_pupilbase.value));
    debug.info(
        'GETPUPILBASE Pupilbase extended: ${oldPupilbase.length} pupils before, now ${_pupilbase.value.length} | ${StackTrace.current}');
    await locator<PupilManager>().getAllPupils();
    locator<PupilFilterManager>().refreshFilteredPupils();
    locator<BottomNavManager>().setBottomNavPage(0);
  }

  Future<String> generatePupilBaseQrData(List<int> pupilIds) async {
    String qrString = '';
    for (int pupilId in pupilIds) {
      PupilBase pupilbase =
          _pupilbase.value.where((element) => element.id == pupilId).single;
      final migrationSupportEnds = pupilbase.migrationSupportEnds != null
          ? pupilbase.migrationSupportEnds!.formatForJson()
          : '';
      final specialNeeds = pupilbase.specialNeeds ?? '';
      final family = pupilbase.family ?? '';
      final String pupilbaseString =
          '${pupilbase.id},${pupilbase.name},${pupilbase.lastName},${pupilbase.group},${pupilbase.schoolyear},$specialNeeds,,${pupilbase.gender},${pupilbase.language},$family,${pupilbase.birthday.formatForJson()},$migrationSupportEnds,${pupilbase.pupilSince.formatForJson()},\n';
      qrString = qrString + pupilbaseString;
    }
    final encryptedString = await customEncrypter.encrypt(qrString);
    return encryptedString!;
  }

  //- This is not used anywhere yet
  void deletePupilBaseElements(List<PupilBase> toBeDeletedPupilBase) {
    _isRunning.value = true;
    List<PupilBase> modifiedPupilBaseList = List.from(_pupilbase.value);

    for (PupilBase pupilBase in modifiedPupilBaseList) {
      if (toBeDeletedPupilBase
          .where((element) => element.id == pupilBase.id)
          .isNotEmpty) {
        modifiedPupilBaseList.remove(pupilBase);
      }
    }
    _pupilbase.value = modifiedPupilBaseList;
    secureStorageWrite('pupilBase', jsonEncode(_pupilbase.value));
    _isRunning.value = false;
    debug.info(
        'Pupilbase reduced: deleted ${toBeDeletedPupilBase.length} pupils not present in the database, now ${_pupilbase.value.length} | ${StackTrace.current}');
  }

  importPupilBaseWithWindows() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      addNewPupilBase(rawTextResult);
    } else {
      // User canceled the picker
    }
  }
}
