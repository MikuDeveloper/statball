// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameMatch {

 int? get id; DateTime get date; String get localTeamId; String get visitorTeamId;
/// Create a copy of GameMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameMatchCopyWith<GameMatch> get copyWith => _$GameMatchCopyWithImpl<GameMatch>(this as GameMatch, _$identity);

  /// Serializes this GameMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.localTeamId, localTeamId) || other.localTeamId == localTeamId)&&(identical(other.visitorTeamId, visitorTeamId) || other.visitorTeamId == visitorTeamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,localTeamId,visitorTeamId);

@override
String toString() {
  return 'GameMatch(id: $id, date: $date, localTeamId: $localTeamId, visitorTeamId: $visitorTeamId)';
}


}

/// @nodoc
abstract mixin class $GameMatchCopyWith<$Res>  {
  factory $GameMatchCopyWith(GameMatch value, $Res Function(GameMatch) _then) = _$GameMatchCopyWithImpl;
@useResult
$Res call({
 int? id, DateTime date, String localTeamId, String visitorTeamId
});




}
/// @nodoc
class _$GameMatchCopyWithImpl<$Res>
    implements $GameMatchCopyWith<$Res> {
  _$GameMatchCopyWithImpl(this._self, this._then);

  final GameMatch _self;
  final $Res Function(GameMatch) _then;

/// Create a copy of GameMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? date = null,Object? localTeamId = null,Object? visitorTeamId = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,localTeamId: null == localTeamId ? _self.localTeamId : localTeamId // ignore: cast_nullable_to_non_nullable
as String,visitorTeamId: null == visitorTeamId ? _self.visitorTeamId : visitorTeamId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GameMatch].
extension GameMatchPatterns on GameMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameMatch value)  $default,){
final _that = this;
switch (_that) {
case _GameMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameMatch value)?  $default,){
final _that = this;
switch (_that) {
case _GameMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  DateTime date,  String localTeamId,  String visitorTeamId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameMatch() when $default != null:
return $default(_that.id,_that.date,_that.localTeamId,_that.visitorTeamId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  DateTime date,  String localTeamId,  String visitorTeamId)  $default,) {final _that = this;
switch (_that) {
case _GameMatch():
return $default(_that.id,_that.date,_that.localTeamId,_that.visitorTeamId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  DateTime date,  String localTeamId,  String visitorTeamId)?  $default,) {final _that = this;
switch (_that) {
case _GameMatch() when $default != null:
return $default(_that.id,_that.date,_that.localTeamId,_that.visitorTeamId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _GameMatch implements GameMatch {
  const _GameMatch({this.id, required this.date, required this.localTeamId, required this.visitorTeamId});
  factory _GameMatch.fromJson(Map<String, dynamic> json) => _$GameMatchFromJson(json);

@override final  int? id;
@override final  DateTime date;
@override final  String localTeamId;
@override final  String visitorTeamId;

/// Create a copy of GameMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameMatchCopyWith<_GameMatch> get copyWith => __$GameMatchCopyWithImpl<_GameMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.localTeamId, localTeamId) || other.localTeamId == localTeamId)&&(identical(other.visitorTeamId, visitorTeamId) || other.visitorTeamId == visitorTeamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,localTeamId,visitorTeamId);

@override
String toString() {
  return 'GameMatch(id: $id, date: $date, localTeamId: $localTeamId, visitorTeamId: $visitorTeamId)';
}


}

/// @nodoc
abstract mixin class _$GameMatchCopyWith<$Res> implements $GameMatchCopyWith<$Res> {
  factory _$GameMatchCopyWith(_GameMatch value, $Res Function(_GameMatch) _then) = __$GameMatchCopyWithImpl;
@override @useResult
$Res call({
 int? id, DateTime date, String localTeamId, String visitorTeamId
});




}
/// @nodoc
class __$GameMatchCopyWithImpl<$Res>
    implements _$GameMatchCopyWith<$Res> {
  __$GameMatchCopyWithImpl(this._self, this._then);

  final _GameMatch _self;
  final $Res Function(_GameMatch) _then;

/// Create a copy of GameMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? date = null,Object? localTeamId = null,Object? visitorTeamId = null,}) {
  return _then(_GameMatch(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,localTeamId: null == localTeamId ? _self.localTeamId : localTeamId // ignore: cast_nullable_to_non_nullable
as String,visitorTeamId: null == visitorTeamId ? _self.visitorTeamId : visitorTeamId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
