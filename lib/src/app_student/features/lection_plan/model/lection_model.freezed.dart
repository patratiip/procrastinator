// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LectionModel {
  String? get lectionID => throw _privateConstructorUsedError;
  String get theme => throw _privateConstructorUsedError;
  String get trainer => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get dayOfWeek => throw _privateConstructorUsedError;

  /// Create a copy of LectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LectionModelCopyWith<LectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectionModelCopyWith<$Res> {
  factory $LectionModelCopyWith(
          LectionModel value, $Res Function(LectionModel) then) =
      _$LectionModelCopyWithImpl<$Res, LectionModel>;
  @useResult
  $Res call(
      {String? lectionID,
      String theme,
      String trainer,
      DateTime date,
      String dayOfWeek});
}

/// @nodoc
class _$LectionModelCopyWithImpl<$Res, $Val extends LectionModel>
    implements $LectionModelCopyWith<$Res> {
  _$LectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lectionID = freezed,
    Object? theme = null,
    Object? trainer = null,
    Object? date = null,
    Object? dayOfWeek = null,
  }) {
    return _then(_value.copyWith(
      lectionID: freezed == lectionID
          ? _value.lectionID
          : lectionID // ignore: cast_nullable_to_non_nullable
              as String?,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      trainer: null == trainer
          ? _value.trainer
          : trainer // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LectionModelImplCopyWith<$Res>
    implements $LectionModelCopyWith<$Res> {
  factory _$$LectionModelImplCopyWith(
          _$LectionModelImpl value, $Res Function(_$LectionModelImpl) then) =
      __$$LectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? lectionID,
      String theme,
      String trainer,
      DateTime date,
      String dayOfWeek});
}

/// @nodoc
class __$$LectionModelImplCopyWithImpl<$Res>
    extends _$LectionModelCopyWithImpl<$Res, _$LectionModelImpl>
    implements _$$LectionModelImplCopyWith<$Res> {
  __$$LectionModelImplCopyWithImpl(
      _$LectionModelImpl _value, $Res Function(_$LectionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lectionID = freezed,
    Object? theme = null,
    Object? trainer = null,
    Object? date = null,
    Object? dayOfWeek = null,
  }) {
    return _then(_$LectionModelImpl(
      lectionID: freezed == lectionID
          ? _value.lectionID
          : lectionID // ignore: cast_nullable_to_non_nullable
              as String?,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      trainer: null == trainer
          ? _value.trainer
          : trainer // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LectionModelImpl extends _LectionModel {
  const _$LectionModelImpl(
      {this.lectionID = null,
      required this.theme,
      required this.trainer,
      required this.date,
      required this.dayOfWeek})
      : super._();

  @override
  @JsonKey()
  final String? lectionID;
  @override
  final String theme;
  @override
  final String trainer;
  @override
  final DateTime date;
  @override
  final String dayOfWeek;

  @override
  String toString() {
    return 'LectionModel(lectionID: $lectionID, theme: $theme, trainer: $trainer, date: $date, dayOfWeek: $dayOfWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectionModelImpl &&
            (identical(other.lectionID, lectionID) ||
                other.lectionID == lectionID) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.trainer, trainer) || other.trainer == trainer) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, lectionID, theme, trainer, date, dayOfWeek);

  /// Create a copy of LectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LectionModelImplCopyWith<_$LectionModelImpl> get copyWith =>
      __$$LectionModelImplCopyWithImpl<_$LectionModelImpl>(this, _$identity);
}

abstract class _LectionModel extends LectionModel {
  const factory _LectionModel(
      {final String? lectionID,
      required final String theme,
      required final String trainer,
      required final DateTime date,
      required final String dayOfWeek}) = _$LectionModelImpl;
  const _LectionModel._() : super._();

  @override
  String? get lectionID;
  @override
  String get theme;
  @override
  String get trainer;
  @override
  DateTime get date;
  @override
  String get dayOfWeek;

  /// Create a copy of LectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LectionModelImplCopyWith<_$LectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
