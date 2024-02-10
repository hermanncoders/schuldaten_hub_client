part of '../endpoints.dart';

class EndpointsMissedClass {
  //- GET
  String getMissedClasses = '/missed_class/all';
  String getOneMissedClass(int id) {
    return '/missed_class/$id';
  }

  String getMissedClassesOnDate(DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_class/schoolday/$missedDate';
  }
  //- POST

  static const postMissedClass = '/missed_class';
  static const postMissedClassList = '/missed_class/list';

  //- PATCH

  String patchMissedClass(int id, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_class/$id/$missedDate';
  }

  //- DELETE

  String deleteMissedClass(int id, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_class/$id/$missedDate';
  }
}
