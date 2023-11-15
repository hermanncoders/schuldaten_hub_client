import 'package:schuldaten_hub/common/utils/extensions.dart';

class Endpoints {
  static const String baseUrl = 'https://datahub.hermannschule.de/api';
  //static const baseUrl = 'http://10.0.2.2:5000/api'; // android VM
  //static const baseUrl = 'http://127.0.0.1:5000/api'; //windows

  //- SCHOOL LISTS

  static const getSchoolLists = '/list/all/flat';
  static const postSchoolListWithGroup = '/list/group';
  String patchPupilSchoolList(int pupilId, String listId) {
    return '/$pupilId/list/$listId';
  }

  //- SCHOOLDAYS

  static const getSchooldays = '/schoolday/only';

  //- PUPIL

  static const getAllPupils = '/pupil/all';

  static const getPupils = '/pupil/list';

  static const postPupil = '/pupil';

  static const exportPupilsTxt = '/import/pupils/txt';

  String getOnePupil(int id) {
    return '/pupil/$id';
  }

  String deletePupil(int id) {
    return '/pupil/$id';
  }

  String patchPupil(int id) {
    return '/pupil/$id';
  }

  String getPupilAvatar(int id) {
    return '/pupil/$id/avatar';
  }

  String patchPupilhWithAvatar(int id) {
    return '/pupil/$id/avatar';
  }
  //- ADMONITION ------------------------------------------------------

  String admonitionPost = '/api/admonition';
  String admonitionGetAll = '/api/admonition/all';
  String deleteAdmonition(int id) {
    return '/admonition/$id';
  }

  String getAdmonition(int id) {
    return '/admonition/$id';
  }

  String patchAdmonition(int id) {
    return '/admonition/$id';
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

  //- COMPETENCES ------------------------------------------------------
  String fetchCompetences = '/competence/all/flat';

  String postNewCompetence = '/competence/new';

  String patchCompetence(int competenceId) {
    return '/competence/$competenceId/patch';
  }

  String patchCompetenceCheck(int id) {
    return '/competence/check/$id';
  }

  String patchCompetenceCheckWithFile(int id) {
    return '/competence/check/$id';
  }

  String deleteCompetenceCheckFile(int id) {
    return '/competence/nomedia/$id';
  }

  String getCompetenceCheckFile(int id) {
    return '/competence/check/$id/image';
  }

  String postCompetenceCheck(int id) {
    return '/pupil/$id/competence/check';
  }

  String deleteCompetenceCheck(int id) {
    return '/competence/check/$id';
  }

  //- GOAL CATEGORIES --------------------------------------------------
  String fetchGoalCategories = '/goalcategories/flat';

  String postCategoryStatus(int pupilId, int categoryId) {
    return '/pupil/$pupilId/category_status/$categoryId';
  }
  //- GOALS ------------------------------------------------------------

  String patchgoal(int id) {
    return '/goal/$id';
  }

  String postGoal(int id) {
    return '/pupil/$id/goal';
  }

  //- GOAL CHECKS ------------------------------------------------------

  String postGoalCheck(int id) {
    return '/goal/$id/check';
  }

  String patchGoalCheck(int id) {
    return '/goal/check/$id';
  }

//- MISSED CLASSES
  String getMissedClasses = '/missed_class/all';
  String getOneMissedClass(int id) {
    return '/missed_class/$id';
  }

  static const postMissedClass = '/missed_class';

  static const postMissedClassList = '/missed_class/list';

  String patchMissedClass(int id, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_class/$id/$missedDate';
  }

  String deleteMissedClass(int id, DateTime date) {
    final missedDate = date.formatForJson();
    return '/missed_class/$id/$missedDate';
  }
  //- User Endpoints ------------------------------------------------------

  static const login = '/login';

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 30000);
}
