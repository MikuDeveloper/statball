// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchEvent {

 int? get id; String get type; String get location; int get minute; Map<String, dynamic> get details; int get matchPlayerId; int get scoutMatchId;
/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchEventCopyWith<MatchEvent> get copyWith => _$MatchEventCopyWithImpl<MatchEvent>(this as MatchEvent, _$identity);

  /// Serializes this MatchEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.minute, minute) || other.minute == minute)&&const DeepCollectionEquality().equals(other.details, details)&&(identical(other.matchPlayerId, matchPlayerId) || other.matchPlayerId == matchPlayerId)&&(identical(other.scoutMatchId, scoutMatchId) || other.scoutMatchId == scoutMatchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,location,minute,const DeepCollectionEquality().hash(details),matchPlayerId,scoutMatchId);

@override
String toString() {
  return 'MatchEvent(id: $id, type: $type, location: $location, minute: $minute, details: $details, matchPlayerId: $matchPlayerId, scoutMatchId: $scoutMatchId)';
}


}

/// @nodoc
abstract mixin class $MatchEventCopyWith<$Res>  {
  factory $MatchEventCopyWith(MatchEvent value, $Res Function(MatchEvent) _then) = _$MatchEventCopyWithImpl;
@useResult
$Res call({
 int? id, String type, String location, int minute, Map<String, dynamic> details, int matchPlayerId, int scoutMatchId
});




}
/// @nodoc
class _$MatchEventCopyWithImpl<$Res>
    implements $MatchEventCopyWith<$Res> {
  _$MatchEventCopyWithImpl(this._self, this._then);

  final MatchEvent _self;
  final $Res Function(MatchEvent) _then;

/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = null,Object? location = null,Object? minute = null,Object? details = null,Object? matchPlayerId = null,Object? scoutMatchId = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,matchPlayerId: null == matchPlayerId ? _self.matchPlayerId : matchPlayerId // ignore: cast_nullable_to_non_nullable
as int,scoutMatchId: null == scoutMatchId ? _self.scoutMatchId : scoutMatchId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchEvent].
extension MatchEventPatterns on MatchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchEvent value)  $default,){
final _that = this;
switch (_that) {
case _MatchEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchEvent value)?  $default,){
final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String type,  String location,  int minute,  Map<String, dynamic> details,  int matchPlayerId,  int scoutMatchId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
return $default(_that.id,_that.type,_that.location,_that.minute,_that.details,_that.matchPlayerId,_that.scoutMatchId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String type,  String location,  int minute,  Map<String, dynamic> details,  int matchPlayerId,  int scoutMatchId)  $default,) {final _that = this;
switch (_that) {
case _MatchEvent():
return $default(_that.id,_that.type,_that.location,_that.minute,_that.details,_that.matchPlayerId,_that.scoutMatchId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String type,  String location,  int minute,  Map<String, dynamic> details,  int matchPlayerId,  int scoutMatchId)?  $default,) {final _that = this;
switch (_that) {
case _MatchEvent() when $default != null:
return $default(_that.id,_that.type,_that.location,_that.minute,_that.details,_that.matchPlayerId,_that.scoutMatchId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _MatchEvent implements MatchEvent {
  const _MatchEvent({this.id, required this.type, required this.location, required this.minute, final  Map<String, dynamic> details = const <String, dynamic>{}, required this.matchPlayerId, required this.scoutMatchId}): _details = details;
  factory _MatchEvent.fromJson(Map<String, dynamic> json) => _$MatchEventFromJson(json);

@override final  int? id;
@override final  String type;
@override final  String location;
@override final  int minute;
 final  Map<String, dynamic> _details;
@override@JsonKey() Map<String, dynamic> get details {
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_details);
}

@override final  int matchPlayerId;
@override final  int scoutMatchId;

/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchEventCopyWith<_MatchEvent> get copyWith => __$MatchEventCopyWithImpl<_MatchEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.minute, minute) || other.minute == minute)&&const DeepCollectionEquality().equals(other._details, _details)&&(identical(other.matchPlayerId, matchPlayerId) || other.matchPlayerId == matchPlayerId)&&(identical(other.scoutMatchId, scoutMatchId) || other.scoutMatchId == scoutMatchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,location,minute,const DeepCollectionEquality().hash(_details),matchPlayerId,scoutMatchId);

@override
String toString() {
  return 'MatchEvent(id: $id, type: $type, location: $location, minute: $minute, details: $details, matchPlayerId: $matchPlayerId, scoutMatchId: $scoutMatchId)';
}


}

/// @nodoc
abstract mixin class _$MatchEventCopyWith<$Res> implements $MatchEventCopyWith<$Res> {
  factory _$MatchEventCopyWith(_MatchEvent value, $Res Function(_MatchEvent) _then) = __$MatchEventCopyWithImpl;
@override @useResult
$Res call({
 int? id, String type, String location, int minute, Map<String, dynamic> details, int matchPlayerId, int scoutMatchId
});




}
/// @nodoc
class __$MatchEventCopyWithImpl<$Res>
    implements _$MatchEventCopyWith<$Res> {
  __$MatchEventCopyWithImpl(this._self, this._then);

  final _MatchEvent _self;
  final $Res Function(_MatchEvent) _then;

/// Create a copy of MatchEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = null,Object? location = null,Object? minute = null,Object? details = null,Object? matchPlayerId = null,Object? scoutMatchId = null,}) {
  return _then(_MatchEvent(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,details: null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,matchPlayerId: null == matchPlayerId ? _self.matchPlayerId : matchPlayerId // ignore: cast_nullable_to_non_nullable
as int,scoutMatchId: null == scoutMatchId ? _self.scoutMatchId : scoutMatchId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
