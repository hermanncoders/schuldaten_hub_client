part of '../endpoints.dart';

class EndpointsSchoolList {
  //- POST
  static const postSchoolListWithGroup = '/list/group';
  static const postSchoolList = '/list/all';

  String patchSchoolList(String listId) {
    return '/list/$listId/patch';
  }

  String patchPupilSchoolList(int pupilId, String listId) {
    return '/$pupilId/list/$listId';
  }

  String addPupilsToSchoolList(String listId) {
    return '/list/$listId/pupils';
  }

  String deletePupilsFromSchoolList(String listId) {
    return '/list/$listId/deletepupils';
  }

  //- GET
  static const getSchoolLists = '/list/all/flat';

  String deleteSchoolList(String listId) {
    return '/list/$listId';
  }
}
