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
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';

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

  Future deleteData() async {
    _isRunning.value = true;
    await secureStorageDelete('pupilBase');
    _pupilbase.value = [];
    locator<PupilManager>().deletePupils();
    locator<PupilFilterManager>().deleteFilteredPupils();
    _availablePupilIds.value = [];
    _isRunning.value = false;
  }

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
    final String? scanResult = await scanner(context, 'Kinder-Code scannen');
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

  void addNewPupilBase(String scanResult) async {
    String? decryptedResult;
    if (!Platform.isWindows) {
      decryptedResult = await customEncrypter.decrypt(scanResult);
    } else {
      decryptedResult = scanResult;
    }
    List<PupilBase> oldPupilbase = _pupilbase.value;
    // The pupils in the string are separated by a '\n' - let's split them apart
    List<String> splittedPupilBase = decryptedResult!.split('\n');
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
    debug.info('base verarbeitet');
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
    await locator<PupilManager>().fetchAllPupils();

    locator<BottomNavManager>().setBottomNavPage(0);
  }

  void importPupilsFromTxt(String scanResult) async {
    List<PupilBase> oldPupilbase = _pupilbase.value;
    // The pupils in the string are separated by a line break - let's split them out
    List splittedPupilBase = scanResult.split('\n');
    // The properties are separated by commas, let's build the pupilbase objects with them
    String updatedPupils = '';
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
      EndpointsPupil.exportPupilsTxt,
      data: formData,
    );
    debug.warning('RESPONSE is ${response.data}');
    //locator<PupilManager>().patchPupilFromResponse(pupilResponse: response.data);
    // we got now the updated data, let's substitute the old pupilbase
    textFile.delete();
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
    await locator<PupilManager>().fetchAllPupils();
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

  Future<Map<String, String>> generateAllPupilBaseQrData(int qrsize) async {
    final List<PupilBase> pupilBase = _pupilbase.value;
    // First we group the pupils by their group in a map
    Map<String, List<PupilBase>> groupedPupils = {};

    for (var pupil in pupilBase) {
      if (groupedPupils.containsKey(pupil.group)) {
        groupedPupils[pupil.group]!.add(pupil);
      } else {
        groupedPupils[pupil.group] = [pupil];
      }
    }
    final Map<String, String> finalGroupedList = {};

    // Now we iterate over the groupedPupils and generate maps with smaller lists with no more than 12 items and add to the group name the subgroup number
    for (String groupName in groupedPupils.keys) {
      final List<PupilBase> group = groupedPupils[groupName]!;
      int numSubgroups = (group.length / qrsize).ceil();

      for (int i = 0; i < numSubgroups; i++) {
        List<PupilBase> smallerGroup = [];
        int start = i * qrsize;
        int end = (i + 1) * qrsize;
        if (end > group.length) {
          end = group.length;
        }
        smallerGroup.addAll(group.sublist(start, end));
        String qrString = '';
        for (PupilBase pupilbase in smallerGroup) {
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
        String subgroupName = "$groupName - ${i + 1}/$numSubgroups";
        finalGroupedList[subgroupName] = encryptedString!;
      }
    }
    // Extracting entries from the map and sorting them based on keys
    List<MapEntry<String, String>> sortedEntries = finalGroupedList.entries
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    // Creating a new map with sorted entries
    Map<String, String> sortedQrGroupLists = Map.fromEntries(sortedEntries);
    return sortedQrGroupLists;
  }

  void deletePupilBaseElements(List<PupilBase> toBeDeletedPupilBase) {
    _isRunning.value = true;
    List<PupilBase> modifiedPupilBaseList = List.from(_pupilbase.value);
    modifiedPupilBaseList.removeWhere((pupilBase) =>
        toBeDeletedPupilBase.any((element) => element.id == pupilBase.id));
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
