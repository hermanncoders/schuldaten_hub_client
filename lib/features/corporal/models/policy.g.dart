// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PolicyImpl _$$PolicyImplFromJson(Map<String, dynamic> json) => _$PolicyImpl(
      schemaVersion: json['schemaVersion'] as int?,
      identificationStamp: json['identificationStamp'],
      flags: json['flags'] == null
          ? null
          : Flags.fromJson(json['flags'] as Map<String, dynamic>),
      hooks: json['hooks'],
      managedRoomIds: (json['managedRoomIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PolicyImplToJson(_$PolicyImpl instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'identificationStamp': instance.identificationStamp,
      'flags': instance.flags,
      'hooks': instance.hooks,
      'managedRoomIds': instance.managedRoomIds,
      'users': instance.users,
    };
