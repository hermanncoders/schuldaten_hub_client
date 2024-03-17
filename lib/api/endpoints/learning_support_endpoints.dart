part of '../endpoints.dart';

class EndpointsLearningSupport {
  //- GOAL CATEGORIES --------------------------------------------------

  String fetchGoalCategories = '/goalcategories/flat';

  String postCategoryStatus(int pupilId, int categoryId) {
    return '/pupil/$pupilId/category_status/$categoryId';
  }

  String patchCategoryStatus(String categoryStatusId) {
    return '/pupil/category_status/$categoryStatusId';
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
}
