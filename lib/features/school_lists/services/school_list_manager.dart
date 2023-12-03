import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

class SchoolListManager {
  ValueListenable<List<SchoolList>> get schoolLists => _schoolLists;
  ValueListenable<bool> get isRunning => _isRunning;
  ValueListenable<List<PupilList>> get pupilListsInSchoolList =>
      _pupilListsInSchoolList;

  final _pupilListsInSchoolList = ValueNotifier<List<PupilList>>([]);
  final _schoolLists = ValueNotifier<List<SchoolList>>([]);
  final _isRunning = ValueNotifier<bool>(false);

  SchoolListManager() {
    debug.warning('SchoolListManager initialized');
  }
  Future<SchoolListManager> init() async {
    await fetchSchoolLists();
    return this;
  }

  Future fetchSchoolLists() async {
    final client = locator.get<ApiManager>().dioClient.value;
    _isRunning.value = true;
    try {
      final response = await client.get(Endpoints.getSchoolLists);
      final schoolLists =
          (response.data as List).map((e) => SchoolList.fromJson(e)).toList();
      debug.success(
          'SchoolListRepository fetched ${schoolLists.length} schooldays! | ${StackTrace.current}');
      _schoolLists.value = schoolLists;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future patchPupilSchoolList(
      int pupilId, String listId, bool? value, String? comment) async {
    final client = locator.get<ApiManager>().dioClient.value;

    String data;
    if (value != null) {
      data = jsonEncode({"pupil_list_status": value});
    } else {
      data = jsonEncode({"pupil_list_comment": comment});
    }
    //   jsonEncode({"pupil_list_comment": comment, "pupil_list_status": value});
    final response = await client
        .patch(Endpoints().patchPupilSchoolList(pupilId, listId), data: data);
    if (response.statusCode == 200) {
      await locator<PupilManager>().patchPupilFromResponse(response.data);
      debug.success('list entry successful');
    }
  }

  Future postSchoolListWithGroup(String name, String description,
      List<int> pupilIds, String visibility) async {
    final client = locator.get<ApiManager>().dioClient.value;

    String data = jsonEncode({
      "list_name": name,
      "list_description": description,
      "pupils": pupilIds,
      "visibility": visibility
    });

    final response =
        await client.post(Endpoints.postSchoolListWithGroup, data: data);
    if (response.statusCode == 200) {
      final newList = SchoolList.fromJson(response.data);
      List<SchoolList> updatedSchoolLists = List.from(_schoolLists.value);
      updatedSchoolLists.add(newList);
      _schoolLists.value = updatedSchoolLists;
      await locator<PupilManager>().fetchPupilsById(pupilIds);
      debug.success('list entry successful');
    }
  }

  Future deleteSchoolList(String listId) async {
    final client = locator.get<ApiManager>().dioClient.value;
    final response = await client.delete(Endpoints().deleteSchoolList(listId));
    if (response.statusCode == 200) {
      debug.success('list entry successful');
      await fetchSchoolLists();
    }
  }

  SchoolList getSchoolList(String listId) {
    final SchoolList schoolList =
        _schoolLists.value.where((element) => element.listId == listId).first;
    return schoolList;
  }

  List<PupilList> getVisibleSchoolLists(Pupil pupil) {
    final Session session = locator<SessionManager>().credentials.value;
    List<PupilList> visiblePupilLists = pupil.pupilLists!
        .where((pupilList) =>
            getSchoolList(pupilList.originList).visibility == 'public' ||
            getSchoolList(pupilList.originList).createdBy == session.username)
        .toList();
    return visiblePupilLists;
  }

  PupilList getPupilSchoolList(int pupilId, String listId) {
    final Pupil pupil = locator<PupilManager>()
        .pupils
        .value
        .where((element) => element.internalId == pupilId)
        .first;

    final PupilList pupilSchoolList = pupil.pupilLists!
        .where((element) => element.originList == listId)
        .first;

    return pupilSchoolList;
  }

  List<Pupil> getPupilsinSchoolList(String listId) {
    final List<Pupil> pupils = locator<PupilManager>().pupils.value;

    final List<Pupil> listedPupils = pupils
        .where((pupil) => pupil.pupilLists!
            .any((pupilList) => pupilList.originList == listId))
        .toList();
    return listedPupils;
  }
}
