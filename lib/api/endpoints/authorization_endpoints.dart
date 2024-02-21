part of '../endpoints.dart';

class EndpointsAuthorization {
  static const String getAuthorizations = '/authorization/all';
  static const String getAuthorizationsFlat = '/authorization/all/flat';
  String deleteAuthorization(int id) {
    return '/authorization/$id';
  }

  String patchAuthorization(int id) {
    return '/authorization/$id';
  }

  String postAuthorization(int id) {
    return '/pupil/$id/authorization';
  }

  static const String postAuthorizationWithPupilsFromList =
      '/authorization/group';

  //-PUPIL AUTHORIZATIONS -------------------------------------------

  String getPupilAuthorizationFile(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId/file';
  }

  String postPupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId/new';
  }

  String postPupilAuthorizations(String authorizationId) {
    return '/pupil/authorization/$authorizationId/group';
  }

  String deletePupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId';
  }

  String patchPupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId';
  }

  String patchPupilAuthorizationWithFile(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId/file';
  }

  String deletePupilAuthorizationFile(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId/file';
  }
}
