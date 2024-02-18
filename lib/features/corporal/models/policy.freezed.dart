// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Policy _$PolicyFromJson(Map<String, dynamic> json) {
  return _Policy.fromJson(json);
}

/// @nodoc
mixin _$Policy {
  int? get schemaVersion => throw _privateConstructorUsedError;
  dynamic get identificationStamp => throw _privateConstructorUsedError;
  Flags? get flags => throw _privateConstructorUsedError;
  dynamic get hooks => throw _privateConstructorUsedError;
  List<String>? get managedRoomIds => throw _privateConstructorUsedError;
  List<User>? get users => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PolicyCopyWith<Policy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyCopyWith<$Res> {
  factory $PolicyCopyWith(Policy value, $Res Function(Policy) then) =
      _$PolicyCopyWithImpl<$Res, Policy>;
  @useResult
  $Res call(
      {int? schemaVersion,
      dynamic identificationStamp,
      Flags? flags,
      dynamic hooks,
      List<String>? managedRoomIds,
      List<User>? users});

  $FlagsCopyWith<$Res>? get flags;
}

/// @nodoc
class _$PolicyCopyWithImpl<$Res, $Val extends Policy>
    implements $PolicyCopyWith<$Res> {
  _$PolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemaVersion = freezed,
    Object? identificationStamp = freezed,
    Object? flags = freezed,
    Object? hooks = freezed,
    Object? managedRoomIds = freezed,
    Object? users = freezed,
  }) {
    return _then(_value.copyWith(
      schemaVersion: freezed == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      identificationStamp: freezed == identificationStamp
          ? _value.identificationStamp
          : identificationStamp // ignore: cast_nullable_to_non_nullable
              as dynamic,
      flags: freezed == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as Flags?,
      hooks: freezed == hooks
          ? _value.hooks
          : hooks // ignore: cast_nullable_to_non_nullable
              as dynamic,
      managedRoomIds: freezed == managedRoomIds
          ? _value.managedRoomIds
          : managedRoomIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FlagsCopyWith<$Res>? get flags {
    if (_value.flags == null) {
      return null;
    }

    return $FlagsCopyWith<$Res>(_value.flags!, (value) {
      return _then(_value.copyWith(flags: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PolicyImplCopyWith<$Res> implements $PolicyCopyWith<$Res> {
  factory _$$PolicyImplCopyWith(
          _$PolicyImpl value, $Res Function(_$PolicyImpl) then) =
      __$$PolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? schemaVersion,
      dynamic identificationStamp,
      Flags? flags,
      dynamic hooks,
      List<String>? managedRoomIds,
      List<User>? users});

  @override
  $FlagsCopyWith<$Res>? get flags;
}

/// @nodoc
class __$$PolicyImplCopyWithImpl<$Res>
    extends _$PolicyCopyWithImpl<$Res, _$PolicyImpl>
    implements _$$PolicyImplCopyWith<$Res> {
  __$$PolicyImplCopyWithImpl(
      _$PolicyImpl _value, $Res Function(_$PolicyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemaVersion = freezed,
    Object? identificationStamp = freezed,
    Object? flags = freezed,
    Object? hooks = freezed,
    Object? managedRoomIds = freezed,
    Object? users = freezed,
  }) {
    return _then(_$PolicyImpl(
      schemaVersion: freezed == schemaVersion
          ? _value.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      identificationStamp: freezed == identificationStamp
          ? _value.identificationStamp
          : identificationStamp // ignore: cast_nullable_to_non_nullable
              as dynamic,
      flags: freezed == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as Flags?,
      hooks: freezed == hooks
          ? _value.hooks
          : hooks // ignore: cast_nullable_to_non_nullable
              as dynamic,
      managedRoomIds: freezed == managedRoomIds
          ? _value._managedRoomIds
          : managedRoomIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PolicyImpl implements _Policy {
  _$PolicyImpl(
      {this.schemaVersion,
      this.identificationStamp,
      this.flags,
      this.hooks,
      final List<String>? managedRoomIds,
      final List<User>? users})
      : _managedRoomIds = managedRoomIds,
        _users = users;

  factory _$PolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolicyImplFromJson(json);

  @override
  final int? schemaVersion;
  @override
  final dynamic identificationStamp;
  @override
  final Flags? flags;
  @override
  final dynamic hooks;
  final List<String>? _managedRoomIds;
  @override
  List<String>? get managedRoomIds {
    final value = _managedRoomIds;
    if (value == null) return null;
    if (_managedRoomIds is EqualUnmodifiableListView) return _managedRoomIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<User>? _users;
  @override
  List<User>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Policy(schemaVersion: $schemaVersion, identificationStamp: $identificationStamp, flags: $flags, hooks: $hooks, managedRoomIds: $managedRoomIds, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyImpl &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            const DeepCollectionEquality()
                .equals(other.identificationStamp, identificationStamp) &&
            (identical(other.flags, flags) || other.flags == flags) &&
            const DeepCollectionEquality().equals(other.hooks, hooks) &&
            const DeepCollectionEquality()
                .equals(other._managedRoomIds, _managedRoomIds) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schemaVersion,
      const DeepCollectionEquality().hash(identificationStamp),
      flags,
      const DeepCollectionEquality().hash(hooks),
      const DeepCollectionEquality().hash(_managedRoomIds),
      const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyImplCopyWith<_$PolicyImpl> get copyWith =>
      __$$PolicyImplCopyWithImpl<_$PolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolicyImplToJson(
      this,
    );
  }
}

abstract class _Policy implements Policy {
  factory _Policy(
      {final int? schemaVersion,
      final dynamic identificationStamp,
      final Flags? flags,
      final dynamic hooks,
      final List<String>? managedRoomIds,
      final List<User>? users}) = _$PolicyImpl;

  factory _Policy.fromJson(Map<String, dynamic> json) = _$PolicyImpl.fromJson;

  @override
  int? get schemaVersion;
  @override
  dynamic get identificationStamp;
  @override
  Flags? get flags;
  @override
  dynamic get hooks;
  @override
  List<String>? get managedRoomIds;
  @override
  List<User>? get users;
  @override
  @JsonKey(ignore: true)
  _$$PolicyImplCopyWith<_$PolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
