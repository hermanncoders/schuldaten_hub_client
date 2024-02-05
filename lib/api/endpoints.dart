import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';

class Endpoints {
  // dev environment urls:
  //static const baseUrl = 'http://10.0.2.2:5000/api'; // android VM
  //static const baseUrl = 'http://127.0.0.1:5000/api'; //windows

  //- SCHOOLDAYS

  //- POST
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

  //- PUPIL -----------------------------------------------------------

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

  //- ADMONITION ------------------------------------------------------

  //- POST
  static const postAdmonition = '/admonition';

  //- GET
  static const fetchAdmonitions = '/api/admonition/all';

  String getAdmonition(String id) {
    return '/admonition/$id';
  }

  String getAdmonitionFile(String id) {
    return '/admonition/$id/file';
  }

  //- PATCH
  String patchAdmonition(String id) {
    return '/admonition/$id/patch';
  }

  String patchAdmonitionFile(String id) {
    return '/admonition/$id/file';
  }

  //- DELETE
  String deleteAdmonition(String id) {
    return '/admonition/$id/delete';
  }

//- DELETE
  String deleteAdmonitionFile(String id) {
    return '/admonition/$id/file';
  }
  //- AUTHORIZATIONS ---------------------------------------------------

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

  //-PUPIL AUTHORIZATIONS -------------------------------------------

  String patchPupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId';
  }

  String patchPupilAuthorizationWithFile(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId/file';
  }

  String getPupilAuthorizationFile(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId/file';
  }

  String deletePupilAuthorization(int pupilId, String authorizationId) {
    return '/pupil/$pupilId/authorization/$authorizationId/file';
  }
  //- COMPETENCES ------------------------------------------------------

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

  //- GOAL CATEGORIES --------------------------------------------------

  String fetchGoalCategories = '/goalcategories/flat';

  String postCategoryStatus(int pupilId, int categoryId) {
    return '/pupil/$pupilId/category_status/$categoryId';
  }

  String deleteCategoryStatus(String categoryStatusId) {
    return '/pupil/category_status/$categoryStatusId/delete';
  }

  //- GOALS ------------------------------------------------------------

  //-POST

  String postGoal(int pupilId) {
    return '/pupil/$pupilId/goal';
  }

  //- PATCH

  String patchgoal(String goalId) {
    return '/goal/$goalId';
  }

  //- DELETE

  String deleteGoal(String goalId) {
    return '/goal/$goalId/delete';
  }

  //- GOAL CHECKS ------------------------------------------------------

  String postGoalCheck(int id) {
    return '/goal/$id/check';
  }

  String patchGoalCheck(int id) {
    return '/goal/check/$id';
  }

//- MISSED CLASSES ----------------------------------------------------

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

  //- SCHOOL LISTS ------------------------------------------------------

  //- POST
  static const postSchoolListWithGroup = '/list/group';
  static const postSchoolList = '/list/all';
  String patchPupilSchoolList(int pupilId, String listId) {
    return '/$pupilId/list/$listId';
  }

  String addPupilsToSchoolList(String listId) {
    return '/list/$listId/pupils';
  }

  //- GET
  static const getSchoolLists = '/list/all/flat';

  String deleteSchoolList(String listId) {
    return '/list/$listId';
  }

  //- USER ------------------------------------------------------

  static const login = '/login';

  //- POST

  static const createUser = '/user';

  //- GET

  static const getAllUsers = '/user/all';

  //- PATCH

  String patchUser(String publicId) {
    return 'user/$publicId';
  }

  //- DELETE

  String deleteUser(String publicId) {
    return 'user/$publicId';
  }

  //- increase credit
  static const increaseCredit = '/user/all/credit';
  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 30000);
}
