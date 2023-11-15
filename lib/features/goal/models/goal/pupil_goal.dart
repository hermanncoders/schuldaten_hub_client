// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:schuldaten_hub/features/goal/models/goal/goal_check.dart';

part 'pupil_goal.freezed.dart';
part 'pupil_goal.g.dart';

@freezed
class PupilGoal with _$PupilGoal {
  factory PupilGoal({
    int? achieved,
    @JsonKey(name: 'achieved_at') DateTime? achievedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    String? description,
    @JsonKey(name: 'goal_category_id') required int goalCategoryId,
    @JsonKey(name: 'goal_checks') List<GoalCheck>? goalChecks,
    @JsonKey(name: 'goal_id') required String goalId,
    String? strategies,
  }) = _PupilGoal;

  factory PupilGoal.fromJson(Map<String, dynamic> json) =>
      _$PupilGoalFromJson(json);
}
