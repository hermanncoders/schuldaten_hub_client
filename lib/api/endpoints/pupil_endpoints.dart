part of '../endpoints.dart';

class EndpointsPupil {
  //- POST
  static const postPupil = '/pupil';
  static const exportPupilsTxt = '/import/pupils/txt';

  //- GET
  static const getAllPupils = '/pupil/all';
  static const getPupils = '/pupil/list';
  static const getPupilsNoNesting = '/pupil/list/no_nesting';
  String getOnePupil(int id) {
    return '/pupil/$id';
  }

  String getPupilAvatar(int id) {
    return '/pupil/$id/avatar';
  }

  //- PATCH
  String patchPupil(int id) {
    return '/pupil/$id';
  }

  String patchPupilhWithAvatar(int id) {
    return '/pupil/$id/avatar';
  }

  //- DELETE
  String deletePupil(int pupilId) {
    return '/pupil/$pupilId';
  }

  String deletePupilAvatar(int pupilId) {
    return '/pupil/$pupilId/avatar';
  }
}
