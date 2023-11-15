// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competence_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompetenceCheckImpl _$$CompetenceCheckImplFromJson(
        Map<String, dynamic> json) =>
    _$CompetenceCheckImpl(
      checkId: json['check_id'] as String,
      comment: json['comment'] as String,
      competenceId: json['competence_id'] as int,
      competenceStatus: json['competence_status'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      pupilId: json['pupil_id'] as int,
      isReport: json['is_report'] as bool,
      reportId: json['report_id'] as String?,
      competenceCheckFiles: (json['competence_check_files'] as List<dynamic>?)
          ?.map((e) => CompetenceCheckFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CompetenceCheckImplToJson(
        _$CompetenceCheckImpl instance) =>
    <String, dynamic>{
      'check_id': instance.checkId,
      'comment': instance.comment,
      'competence_id': instance.competenceId,
      'competence_status': instance.competenceStatus,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'pupil_id': instance.pupilId,
      'is_report': instance.isReport,
      'report_id': instance.reportId,
      'competence_check_files':
          instance.competenceCheckFiles?.map((e) => e.toJson()).toList(),
    };

_$CompetenceCheckFileImpl _$$CompetenceCheckFileImplFromJson(
        Map<String, dynamic> json) =>
    _$CompetenceCheckFileImpl(
      checkId: json['check_id'] as String,
      fileId: json['file_id'] as String,
      fileUrl: json['file_url'] as String,
    );

Map<String, dynamic> _$$CompetenceCheckFileImplToJson(
        _$CompetenceCheckFileImpl instance) =>
    <String, dynamic>{
      'check_id': instance.checkId,
      'file_id': instance.fileId,
      'file_url': instance.fileUrl,
    };
