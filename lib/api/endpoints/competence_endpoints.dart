part of '../endpoints.dart';

class EndpointsCompetence {
  //-POST
  String postNewCompetence = '/competence/new';

  //- GET
  String fetchCompetences = '/competence/all/flat';

  //- PATCH
  String patchCompetence(int competenceId) {
    return '/competence/$competenceId/patch';
  }

  //- DELETE
  String deleteCompetence(int id) {
    return '/competence/$id/delete';
  }

  //- COMPETENCE CHECKS ------------------------------------------------

  //- GET

  String getCompetenceCheckFile(String fileId) {
    return '/competence/check/$fileId';
  }

  //- POST

  String postCompetenceCheck(int pupilId) {
    return '/pupil/$pupilId/competence/check';
  }

  String postCompetenceCheckFile(String competenceCheckId) {
    return '/competence/check/$competenceCheckId/file';
  }

  //- PATCH

  String patchCompetenceCheck(String competenceCheckId) {
    return '/competence/check/$competenceCheckId';
  }

  // String patchCompetenceCheckWithFile(String competenceCheckId) {
  //   return '/competence/check/$competenceCheckId';
  // }

  //- DELETE

  String deleteCompetenceCheck(String competenceCheckId) {
    return '/competence/check/$competenceCheckId';
  }

  String deleteCompetenceCheckFile(String fileId) {
    return '/competence/check/$fileId';
  }

  //- COMPETENCE GOALS -------------------------------------------------

  //- POST
  String postCompetenceGoal(int pupilId) {
    return '/pupil/$pupilId/competence/goal';
  }

  //- PATCH
  String patchCompetenceGoal(String competenceGoalId) {
    return '/competence/goal/$competenceGoalId';
  }

  //- DELETE
  String deleteCompetenceGoal(String competenceGoalId) {
    return '/competence/goal/$competenceGoalId/delete';
  }
}
