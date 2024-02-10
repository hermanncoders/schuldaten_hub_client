part of '../endpoints.dart';

class EndpointsSchoolday {
  static const postSchoolday = '/schoolday';

  //- GET
  static const getAllSchooldays = '/schoolday/all';
  static const getSchooldays = '/schoolday/only';
  String getOneSchoolday(DateTime date) {
    return '/schoolday/${date.formatForJson()}';
  }

  //- DELETE
  String deleteSchoolday(DateTime date) {
    return '/schoolday/${date.formatForJson()}';
  }
}
