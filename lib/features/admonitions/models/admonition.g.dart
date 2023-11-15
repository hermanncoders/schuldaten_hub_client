// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admonition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdmonitionImpl _$$AdmonitionImplFromJson(Map<String, dynamic> json) =>
    _$AdmonitionImpl(
      admonishedDay: DateTime.parse(json['admonished_day'] as String),
      admonishedPupilId: json['admonished_pupil_id'] as int,
      admonishingUser: json['admonishing_user'] as String,
      admonitionReason: json['admonition_reason'] as String,
      admonitionType: json['admonition_type'] as String,
      fileUrl: json['file_url'] as String?,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$AdmonitionImplToJson(_$AdmonitionImpl instance) =>
    <String, dynamic>{
      'admonished_day': instance.admonishedDay.toIso8601String(),
      'admonished_pupil_id': instance.admonishedPupilId,
      'admonishing_user': instance.admonishingUser,
      'admonition_reason': instance.admonitionReason,
      'admonition_type': instance.admonitionType,
      'file_url': instance.fileUrl,
      'id': instance.id,
    };
