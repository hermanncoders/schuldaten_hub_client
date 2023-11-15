// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admonition.freezed.dart';
part 'admonition.g.dart';

@freezed
class Admonition with _$Admonition {
  factory Admonition({
    @JsonKey(name: 'admonished_day') required DateTime admonishedDay,
    @JsonKey(name: 'admonished_pupil_id') required int admonishedPupilId,
    @JsonKey(name: 'admonishing_user') required String admonishingUser,
    @JsonKey(name: 'admonition_reason') required String admonitionReason,
    @JsonKey(name: 'admonition_type') required String admonitionType,
    @JsonKey(name: 'file_url') String? fileUrl,
    required int id,
  }) = _Admonition;

  factory Admonition.fromJson(Map<String, dynamic> json) =>
      _$AdmonitionFromJson(json);
}
