// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PupilGoalImpl _$$PupilGoalImplFromJson(Map<String, dynamic> json) =>
    _$PupilGoalImpl(
      achieved: json['achieved'] as int?,
      achievedAt: json['achieved_at'] == null
          ? null
          : DateTime.parse(json['achieved_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      description: json['description'] as String?,
      goalCategoryId: json['goal_category_id'] as int,
      goalChecks: (json['goal_checks'] as List<dynamic>?)
          ?.map((e) => GoalCheck.fromJson(e as Map<String, dynamic>))
          .toList(),
      goalId: json['goal_id'] as String,
      strategies: json['strategies'] as String?,
    );

Map<String, dynamic> _$$PupilGoalImplToJson(_$PupilGoalImpl instance) =>
    <String, dynamic>{
      'achieved': instance.achieved,
      'achieved_at': instance.achievedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'description': instance.description,
      'goal_category_id': instance.goalCategoryId,
      'goal_checks': instance.goalChecks?.map((e) => e.toJson()).toList(),
      'goal_id': instance.goalId,
      'strategies': instance.strategies,
    };
