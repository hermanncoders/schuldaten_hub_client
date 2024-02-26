part of '../endpoints.dart';

class EndpointsPupilWorkbook {
  String newPupilWorkbook(int pupilId, int isbn) {
    return '/pupil/$pupilId/workbook/$isbn';
  }

  String patchPupilWorkbook(int pupilId, int isbn) {
    return '/pupil/$pupilId/workbook/$isbn';
  }

  String deletePupilWorkbook(int pupilId, int isbn) {
    return '/pupil/$pupilId/workbook/$isbn';
  }
}
