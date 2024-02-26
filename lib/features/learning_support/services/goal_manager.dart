import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';

import 'package:schuldaten_hub/features/learning_support/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

import '../models/category/pupil_category_status.dart';

class GoalManager {
  ValueListenable<List<GoalCategory>> get goalCategories => _goalCategories;
  ValueListenable<bool> get isRunning => _isRunning;

  final _goalCategories = ValueNotifier<List<GoalCategory>>([]);
  final _isRunning = ValueNotifier<bool>(false);

  GoalManager() {
    debug.warning('GoalManager initialized');
  }
  Future<GoalManager> init() async {
    await fetchGoalCategories();
    return this;
  }

  final client = locator.get<ApiManager>().dioClient.value;
  Future fetchGoalCategories() async {
    _isRunning.value = true;
    try {
      final response =
          await client.get(EndpointsLearningSupport().fetchGoalCategories);
      final goalCategories =
          (response.data as List).map((e) => GoalCategory.fromJson(e)).toList();
      debug.success(
          'Fetched ${goalCategories.length} goal categories! | ${StackTrace.current}');
      _goalCategories.value = goalCategories;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future postCategoryStatus(
      Pupil pupil, int goalCategoryId, String state, String comment) async {
    _isRunning.value = true;

    final data =
        jsonEncode({"state": state, "file_url": null, "comment": comment});
    try {
      final response = await client.post(
          EndpointsLearningSupport()
              .postCategoryStatus(pupil.internalId, goalCategoryId),
          data: data);
      if (response.statusCode == 200) {
        locator<PupilManager>().patchPupilFromResponse(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future deleteCategoryStatus(String statusId) async {
    _isRunning.value = true;
    try {
      final response = await client
          .delete(EndpointsLearningSupport().deleteCategoryStatus(statusId));
      if (response.statusCode == 200) {
        locator<PupilManager>().patchPupilFromResponse(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
    }
  }

  Future postNewCategoryGoal(int goalCategoryId, int pupilId,
      String description, String strategies) async {
    _isRunning.value = true;

    final data = jsonEncode({
      "goal_category_id": goalCategoryId,
      "created_at": DateTime.now().formatForJson(),
      "achieved": 0,
      "achieved_at": null,
      "description": description,
      "strategies": strategies
    });
    try {
      final response = await client
          .post(EndpointsLearningSupport().postGoal(pupilId), data: data);
      if (response.statusCode == 200) {
        locator<PupilManager>().patchPupilFromResponse(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future deleteGoal(String goalId) async {
    // final List<Pupil> pupils = locator<PupilManager>().pupils.value;
    // final Pupil pupil = pupils
    //     .where((element) =>
    //         element.pupilGoals!.any((element) => element.goalId == goalId))
    //     .single;
    _isRunning.value = true;

    try {
      final response =
          await client.delete(EndpointsLearningSupport().deleteGoal(goalId));
      if (response.statusCode == 200) {
        locator<PupilManager>().patchPupilFromResponse(response.data);
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
    }
  }

  GoalCategory getGoalCategory(int categoryId) {
    final GoalCategory goalCategory = goalCategories.value
        .firstWhere((element) => element.categoryId == categoryId);
    return goalCategory;
  }

  GoalCategory getRootCategory(int categoryId) {
    GoalCategory goalCategory = _goalCategories.value
        .firstWhere((element) => element.categoryId == categoryId);
    if (goalCategory.parentCategory == null) {
      return goalCategory;
    } else {
      return getRootCategory(goalCategory.parentCategory!);
    }
  }

  Color getCategoryColor(int categoryId) {
    final GoalCategory rootCategory = getRootCategory(categoryId);
    return getRootCategoryColor(rootCategory)!;
  }

  Color? getRootCategoryColor(GoalCategory goalCategory) {
    if (goalCategory.categoryName == 'Körper, Wahrnehmung, Motorik') {
      return koerperWahrnehmungMotorikColor;
    } else if (goalCategory.categoryName == 'Sozialkompetenz / Emotionalität') {
      return sozialEmotionalColor;
    } else if (goalCategory.categoryName == 'Mathematik') {
      return mathematikColor;
    } else if (goalCategory.categoryName == 'Lernen und Leisten') {
      return lernenLeistenColor;
    } else if (goalCategory.categoryName == 'Deutsch') {
      return deutschColor;
    } else if (goalCategory.categoryName == 'Sprache und Sprechen') {
      return spracheSprechenColor;
    }
    return null;
  }

  Widget getCategoryStatusSymbol(
      Pupil pupil, int goalCategoryId, String statusId) {
    if (pupil.pupilCategoryStatuses!.isNotEmpty) {
      final PupilCategoryStatus categoryStatus = pupil.pupilCategoryStatuses!
          .firstWhere((element) =>
              element.goalCategoryId == goalCategoryId &&
              element.statusId == statusId);

      switch (categoryStatus.state) {
        case 'none':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_1-4.png'));
        case 'green':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_4-4.png'));
        case 'yellow':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_3-4.png'));
        // case 'orange':
        //   return Colors.orange;
        case 'red':
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_2-4.png'));
      }
      return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
    }

    return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
  }

  Widget getLastCategoryStatusSymbol(Pupil pupil, int goalCategoryId) {
    if (pupil.pupilCategoryStatuses!.isNotEmpty) {
      final PupilCategoryStatus? categoryStatus = pupil.pupilCategoryStatuses!
          .lastWhereOrNull(
              (element) => element.goalCategoryId == goalCategoryId);

      if (categoryStatus != null) {
        switch (categoryStatus.state) {
          case 'none':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_1-4.png'));
          case 'green':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_4-4.png'));
          case 'yellow':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_3-4.png'));
          // case 'orange':
          //   return Colors.orange;
          case 'red':
            return SizedBox(
                width: 50, child: Image.asset('assets/growth_2-4.png'));
        }
      }
      return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
    }

    return SizedBox(width: 40, child: Image.asset('assets/growth_1-4.png'));
  }
}
