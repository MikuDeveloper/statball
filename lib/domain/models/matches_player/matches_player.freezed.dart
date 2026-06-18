// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matches_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchesPlayer {

 int? get id; int get matchId; String get playerId;@JsonKey(fromJson: _positionFromJson, toJson: _positionToJson) PlayerPosition get position; Map<String, dynamic> get statsPhysics; Map<String, dynamic> get statsQual; Map<String, dynamic> get statsTech;@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) EvaluationStatus get evaluationStatus; String? get notes;
/// Create a copy of MatchesPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchesPlayerCopyWith<MatchesPlayer> get copyWith => _$MatchesPlayerCopyWithImpl<MatchesPlayer>(this as MatchesPlayer, _$identity);

  /// Serializes this MatchesPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchesPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.position, position) || other.position == position)&&const DeepCollectionEquality().equals(other.statsPhysics, statsPhysics)&&const DeepCollectionEquality().equals(other.statsQual, statsQual)&&const DeepCollectionEquality().equals(other.statsTech, statsTech)&&(identical(other.evaluationStatus, evaluationStatus) || other.evaluationStatus == evaluationStatus)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,playerId,position,const DeepCollectionEquality().hash(statsPhysics),const DeepCollectionEquality().hash(statsQual),const DeepCollectionEquality().hash(statsTech),evaluationStatus,notes);

@override
String toString() {
  return 'MatchesPlayer(id: $id, matchId: $matchId, playerId: $playerId, position: $position, statsPhysics: $statsPhysics, statsQual: $statsQual, statsTech: $statsTech, evaluationStatus: $evaluationStatus, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $MatchesPlayerCopyWith<$Res>  {
  factory $MatchesPlayerCopyWith(MatchesPlayer value, $Res Function(MatchesPlayer) _then) = _$MatchesPlayerCopyWithImpl;
@useResult
$Res call({
 int? id, int matchId, String playerId,@JsonKey(fromJson: _positionFromJson, toJson: _positionToJson) PlayerPosition position, Map<String, dynamic> statsPhysics, Map<String, dynamic> statsQual, Map<String, dynamic> statsTech,@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) EvaluationStatus evaluationStatus, String? notes
});




}
/// @nodoc
class _$MatchesPlayerCopyWithImpl<$Res>
    implements $MatchesPlayerCopyWith<$Res> {
  _$MatchesPlayerCopyWithImpl(this._self, this._then);

  final MatchesPlayer _self;
  final $Res Function(MatchesPlayer) _then;

/// Create a copy of MatchesPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? matchId = null,Object? playerId = null,Object? position = null,Object? statsPhysics = null,Object? statsQual = null,Object? statsTech = null,Object? evaluationStatus = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as int,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as PlayerPosition,statsPhysics: null == statsPhysics ? _self.statsPhysics : statsPhysics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statsQual: null == statsQual ? _self.statsQual : statsQual // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statsTech: null == statsTech ? _self.statsTech : statsTech // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,evaluationStatus: null == evaluationStatus ? _self.evaluationStatus : evaluationStatus // ignore: cast_nullable_to_non_nullable
as EvaluationStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchesPlayer].
extension MatchesPlayerPatterns on MatchesPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchesPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchesPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchesPlayer value)  $default,){
final _that = this;
switch (_that) {
case _MatchesPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchesPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _MatchesPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int matchId,  String playerId, @JsonKey(fromJson: _positionFromJson, toJson: _positionToJson)  PlayerPosition position,  Map<String, dynamic> statsPhysics,  Map<String, dynamic> statsQual,  Map<String, dynamic> statsTech, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  EvaluationStatus evaluationStatus,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchesPlayer() when $default != null:
return $default(_that.id,_that.matchId,_that.playerId,_that.position,_that.statsPhysics,_that.statsQual,_that.statsTech,_that.evaluationStatus,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int matchId,  String playerId, @JsonKey(fromJson: _positionFromJson, toJson: _positionToJson)  PlayerPosition position,  Map<String, dynamic> statsPhysics,  Map<String, dynamic> statsQual,  Map<String, dynamic> statsTech, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  EvaluationStatus evaluationStatus,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _MatchesPlayer():
return $default(_that.id,_that.matchId,_that.playerId,_that.position,_that.statsPhysics,_that.statsQual,_that.statsTech,_that.evaluationStatus,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int matchId,  String playerId, @JsonKey(fromJson: _positionFromJson, toJson: _positionToJson)  PlayerPosition position,  Map<String, dynamic> statsPhysics,  Map<String, dynamic> statsQual,  Map<String, dynamic> statsTech, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  EvaluationStatus evaluationStatus,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _MatchesPlayer() when $default != null:
return $default(_that.id,_that.matchId,_that.playerId,_that.position,_that.statsPhysics,_that.statsQual,_that.statsTech,_that.evaluationStatus,_that.notes);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _MatchesPlayer implements MatchesPlayer {
  const _MatchesPlayer({this.id, required this.matchId, required this.playerId, @JsonKey(fromJson: _positionFromJson, toJson: _positionToJson) required this.position, final  Map<String, dynamic> statsPhysics = const <String, dynamic>{}, final  Map<String, dynamic> statsQual = const <String, dynamic>{}, final  Map<String, dynamic> statsTech = const <String, dynamic>{}, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) this.evaluationStatus = EvaluationStatus.enEvaluacion, this.notes}): _statsPhysics = statsPhysics,_statsQual = statsQual,_statsTech = statsTech;
  factory _MatchesPlayer.fromJson(Map<String, dynamic> json) => _$MatchesPlayerFromJson(json);

@override final  int? id;
@override final  int matchId;
@override final  String playerId;
@override@JsonKey(fromJson: _positionFromJson, toJson: _positionToJson) final  PlayerPosition position;
 final  Map<String, dynamic> _statsPhysics;
@override@JsonKey() Map<String, dynamic> get statsPhysics {
  if (_statsPhysics is EqualUnmodifiableMapView) return _statsPhysics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statsPhysics);
}

 final  Map<String, dynamic> _statsQual;
@override@JsonKey() Map<String, dynamic> get statsQual {
  if (_statsQual is EqualUnmodifiableMapView) return _statsQual;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statsQual);
}

 final  Map<String, dynamic> _statsTech;
@override@JsonKey() Map<String, dynamic> get statsTech {
  if (_statsTech is EqualUnmodifiableMapView) return _statsTech;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statsTech);
}

@override@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) final  EvaluationStatus evaluationStatus;
@override final  String? notes;

/// Create a copy of MatchesPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchesPlayerCopyWith<_MatchesPlayer> get copyWith => __$MatchesPlayerCopyWithImpl<_MatchesPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchesPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchesPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.position, position) || other.position == position)&&const DeepCollectionEquality().equals(other._statsPhysics, _statsPhysics)&&const DeepCollectionEquality().equals(other._statsQual, _statsQual)&&const DeepCollectionEquality().equals(other._statsTech, _statsTech)&&(identical(other.evaluationStatus, evaluationStatus) || other.evaluationStatus == evaluationStatus)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,playerId,position,const DeepCollectionEquality().hash(_statsPhysics),const DeepCollectionEquality().hash(_statsQual),const DeepCollectionEquality().hash(_statsTech),evaluationStatus,notes);

@override
String toString() {
  return 'MatchesPlayer(id: $id, matchId: $matchId, playerId: $playerId, position: $position, statsPhysics: $statsPhysics, statsQual: $statsQual, statsTech: $statsTech, evaluationStatus: $evaluationStatus, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$MatchesPlayerCopyWith<$Res> implements $MatchesPlayerCopyWith<$Res> {
  factory _$MatchesPlayerCopyWith(_MatchesPlayer value, $Res Function(_MatchesPlayer) _then) = __$MatchesPlayerCopyWithImpl;
@override @useResult
$Res call({
 int? id, int matchId, String playerId,@JsonKey(fromJson: _positionFromJson, toJson: _positionToJson) PlayerPosition position, Map<String, dynamic> statsPhysics, Map<String, dynamic> statsQual, Map<String, dynamic> statsTech,@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) EvaluationStatus evaluationStatus, String? notes
});




}
/// @nodoc
class __$MatchesPlayerCopyWithImpl<$Res>
    implements _$MatchesPlayerCopyWith<$Res> {
  __$MatchesPlayerCopyWithImpl(this._self, this._then);

  final _MatchesPlayer _self;
  final $Res Function(_MatchesPlayer) _then;

/// Create a copy of MatchesPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? matchId = null,Object? playerId = null,Object? position = null,Object? statsPhysics = null,Object? statsQual = null,Object? statsTech = null,Object? evaluationStatus = null,Object? notes = freezed,}) {
  return _then(_MatchesPlayer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as int,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as PlayerPosition,statsPhysics: null == statsPhysics ? _self._statsPhysics : statsPhysics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statsQual: null == statsQual ? _self._statsQual : statsQual // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,statsTech: null == statsTech ? _self._statsTech : statsTech // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,evaluationStatus: null == evaluationStatus ? _self.evaluationStatus : evaluationStatus // ignore: cast_nullable_to_non_nullable
as EvaluationStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
