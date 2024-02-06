import 'package:freezed_annotation/freezed_annotation.dart';

part 'flags.freezed.dart';
part 'flags.g.dart';

@freezed
class Flags with _$Flags {
  factory Flags({
    bool? allowCustomUserDisplayNames,
    bool? allowCustomUserAvatars,
    bool? allowCustomPassthroughUserPasswords,
    bool? allowUnauthenticatedPasswordResets,
    bool? forbidRoomCreation,
    bool? forbidEncryptedRoomCreation,
    bool? forbidUnencryptedRoomCreation,
    bool? allow3pidLogin,
  }) = _Flags;

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);
}
