// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pupil_authorization.freezed.dart';
part 'pupil_authorization.g.dart';

@freezed
class PupilAuthorization with _$PupilAuthorization {
  factory PupilAuthorization({
    String? comment,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'file_url') String? fileUrl,
    @JsonKey(name: 'origin_authorization') required String originAuthorization,
    @JsonKey(name: 'pupil_id') required int pupilId,
    bool? status,
  }) = _Authorization;

  factory PupilAuthorization.fromJson(Map<String, dynamic> json) =>
      _$PupilAuthorizationFromJson(json);
}
