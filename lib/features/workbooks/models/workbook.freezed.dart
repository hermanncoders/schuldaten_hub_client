// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workbook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Workbook _$WorkbookFromJson(Map<String, dynamic> json) {
  return _Workbook.fromJson(json);
}

/// @nodoc
mixin _$Workbook {
  int? get isbn => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkbookCopyWith<Workbook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkbookCopyWith<$Res> {
  factory $WorkbookCopyWith(Workbook value, $Res Function(Workbook) then) =
      _$WorkbookCopyWithImpl<$Res, Workbook>;
  @useResult
  $Res call({int? isbn, String? name, String? subject});
}

/// @nodoc
class _$WorkbookCopyWithImpl<$Res, $Val extends Workbook>
    implements $WorkbookCopyWith<$Res> {
  _$WorkbookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isbn = freezed,
    Object? name = freezed,
    Object? subject = freezed,
  }) {
    return _then(_value.copyWith(
      isbn: freezed == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkbookImplCopyWith<$Res>
    implements $WorkbookCopyWith<$Res> {
  factory _$$WorkbookImplCopyWith(
          _$WorkbookImpl value, $Res Function(_$WorkbookImpl) then) =
      __$$WorkbookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? isbn, String? name, String? subject});
}

/// @nodoc
class __$$WorkbookImplCopyWithImpl<$Res>
    extends _$WorkbookCopyWithImpl<$Res, _$WorkbookImpl>
    implements _$$WorkbookImplCopyWith<$Res> {
  __$$WorkbookImplCopyWithImpl(
      _$WorkbookImpl _value, $Res Function(_$WorkbookImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isbn = freezed,
    Object? name = freezed,
    Object? subject = freezed,
  }) {
    return _then(_$WorkbookImpl(
      isbn: freezed == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkbookImpl implements _Workbook {
  _$WorkbookImpl({this.isbn, this.name, this.subject});

  factory _$WorkbookImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkbookImplFromJson(json);

  @override
  final int? isbn;
  @override
  final String? name;
  @override
  final String? subject;

  @override
  String toString() {
    return 'Workbook(isbn: $isbn, name: $name, subject: $subject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkbookImpl &&
            (identical(other.isbn, isbn) || other.isbn == isbn) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isbn, name, subject);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkbookImplCopyWith<_$WorkbookImpl> get copyWith =>
      __$$WorkbookImplCopyWithImpl<_$WorkbookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkbookImplToJson(
      this,
    );
  }
}

abstract class _Workbook implements Workbook {
  factory _Workbook(
      {final int? isbn,
      final String? name,
      final String? subject}) = _$WorkbookImpl;

  factory _Workbook.fromJson(Map<String, dynamic> json) =
      _$WorkbookImpl.fromJson;

  @override
  int? get isbn;
  @override
  String? get name;
  @override
  String? get subject;
  @override
  @JsonKey(ignore: true)
  _$$WorkbookImplCopyWith<_$WorkbookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
