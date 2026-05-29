// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scout_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoutMatch {

 int? get id; int get matchId; String get scoutId; String get notes;
/// Create a copy of ScoutMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutMatchCopyWith<ScoutMatch> get copyWith => _$ScoutMatchCopyWithImpl<ScoutMatch>(this as ScoutMatch, _$identity);

  /// Serializes this ScoutMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoutMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.scoutId, scoutId) || other.scoutId == scoutId)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,scoutId,notes);

@override
String toString() {
  return 'ScoutMatch(id: $id, matchId: $matchId, scoutId: $scoutId, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ScoutMatchCopyWith<$Res>  {
  factory $ScoutMatchCopyWith(ScoutMatch value, $Res Function(ScoutMatch) _then) = _$ScoutMatchCopyWithImpl;
@useResult
$Res call({
 int? id, int matchId, String scoutId, String notes
});




}
/// @nodoc
class _$ScoutMatchCopyWithImpl<$Res>
    implements $ScoutMatchCopyWith<$Res> {
  _$ScoutMatchCopyWithImpl(this._self, this._then);

  final ScoutMatch _self;
  final $Res Function(ScoutMatch) _then;

/// Create a copy of ScoutMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? matchId = null,Object? scoutId = null,Object? notes = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as int,scoutId: null == scoutId ? _self.scoutId : scoutId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoutMatch].
extension ScoutMatchPatterns on ScoutMatch {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoutMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoutMatch() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoutMatch value)  $default,){
final _that = this;
switch (_that) {
case _ScoutMatch():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoutMatch value)?  $default,){
final _that = this;
switch (_that) {
case _ScoutMatch() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int matchId,  String scoutId,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoutMatch() when $default != null:
return $default(_that.id,_that.matchId,_that.scoutId,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int matchId,  String scoutId,  String notes)  $default,) {final _that = this;
switch (_that) {
case _ScoutMatch():
return $default(_that.id,_that.matchId,_that.scoutId,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int matchId,  String scoutId,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _ScoutMatch() when $default != null:
return $default(_that.id,_that.matchId,_that.scoutId,_that.notes);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ScoutMatch implements ScoutMatch {
  const _ScoutMatch({this.id, required this.matchId, required this.scoutId, required this.notes});
  factory _ScoutMatch.fromJson(Map<String, dynamic> json) => _$ScoutMatchFromJson(json);

@override final  int? id;
@override final  int matchId;
@override final  String scoutId;
@override final  String notes;

/// Create a copy of ScoutMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutMatchCopyWith<_ScoutMatch> get copyWith => __$ScoutMatchCopyWithImpl<_ScoutMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoutMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.scoutId, scoutId) || other.scoutId == scoutId)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,scoutId,notes);

@override
String toString() {
  return 'ScoutMatch(id: $id, matchId: $matchId, scoutId: $scoutId, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ScoutMatchCopyWith<$Res> implements $ScoutMatchCopyWith<$Res> {
  factory _$ScoutMatchCopyWith(_ScoutMatch value, $Res Function(_ScoutMatch) _then) = __$ScoutMatchCopyWithImpl;
@override @useResult
$Res call({
 int? id, int matchId, String scoutId, String notes
});




}
/// @nodoc
class __$ScoutMatchCopyWithImpl<$Res>
    implements _$ScoutMatchCopyWith<$Res> {
  __$ScoutMatchCopyWithImpl(this._self, this._then);

  final _ScoutMatch _self;
  final $Res Function(_ScoutMatch) _then;

/// Create a copy of ScoutMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? matchId = null,Object? scoutId = null,Object? notes = null,}) {
  return _then(_ScoutMatch(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as int,scoutId: null == scoutId ? _self.scoutId : scoutId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
