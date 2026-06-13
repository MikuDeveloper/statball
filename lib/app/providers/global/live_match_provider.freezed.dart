// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_match_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveMatchData {

 int get matchId; int? get scoutMatchId; int? get selectedPlayerId; String? get selectedEventType; String? get selectedZone; Map<String, dynamic> get eventDetails; String get quickNote; int get currentMinute; bool get clockRunning;
/// Create a copy of LiveMatchData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMatchDataCopyWith<LiveMatchData> get copyWith => _$LiveMatchDataCopyWithImpl<LiveMatchData>(this as LiveMatchData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMatchData&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.scoutMatchId, scoutMatchId) || other.scoutMatchId == scoutMatchId)&&(identical(other.selectedPlayerId, selectedPlayerId) || other.selectedPlayerId == selectedPlayerId)&&(identical(other.selectedEventType, selectedEventType) || other.selectedEventType == selectedEventType)&&(identical(other.selectedZone, selectedZone) || other.selectedZone == selectedZone)&&const DeepCollectionEquality().equals(other.eventDetails, eventDetails)&&(identical(other.quickNote, quickNote) || other.quickNote == quickNote)&&(identical(other.currentMinute, currentMinute) || other.currentMinute == currentMinute)&&(identical(other.clockRunning, clockRunning) || other.clockRunning == clockRunning));
}


@override
int get hashCode => Object.hash(runtimeType,matchId,scoutMatchId,selectedPlayerId,selectedEventType,selectedZone,const DeepCollectionEquality().hash(eventDetails),quickNote,currentMinute,clockRunning);

@override
String toString() {
  return 'LiveMatchData(matchId: $matchId, scoutMatchId: $scoutMatchId, selectedPlayerId: $selectedPlayerId, selectedEventType: $selectedEventType, selectedZone: $selectedZone, eventDetails: $eventDetails, quickNote: $quickNote, currentMinute: $currentMinute, clockRunning: $clockRunning)';
}


}

/// @nodoc
abstract mixin class $LiveMatchDataCopyWith<$Res>  {
  factory $LiveMatchDataCopyWith(LiveMatchData value, $Res Function(LiveMatchData) _then) = _$LiveMatchDataCopyWithImpl;
@useResult
$Res call({
 int matchId, int? scoutMatchId, int? selectedPlayerId, String? selectedEventType, String? selectedZone, Map<String, dynamic> eventDetails, String quickNote, int currentMinute, bool clockRunning
});




}
/// @nodoc
class _$LiveMatchDataCopyWithImpl<$Res>
    implements $LiveMatchDataCopyWith<$Res> {
  _$LiveMatchDataCopyWithImpl(this._self, this._then);

  final LiveMatchData _self;
  final $Res Function(LiveMatchData) _then;

/// Create a copy of LiveMatchData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? scoutMatchId = freezed,Object? selectedPlayerId = freezed,Object? selectedEventType = freezed,Object? selectedZone = freezed,Object? eventDetails = null,Object? quickNote = null,Object? currentMinute = null,Object? clockRunning = null,}) {
  return _then(_self.copyWith(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as int,scoutMatchId: freezed == scoutMatchId ? _self.scoutMatchId : scoutMatchId // ignore: cast_nullable_to_non_nullable
as int?,selectedPlayerId: freezed == selectedPlayerId ? _self.selectedPlayerId : selectedPlayerId // ignore: cast_nullable_to_non_nullable
as int?,selectedEventType: freezed == selectedEventType ? _self.selectedEventType : selectedEventType // ignore: cast_nullable_to_non_nullable
as String?,selectedZone: freezed == selectedZone ? _self.selectedZone : selectedZone // ignore: cast_nullable_to_non_nullable
as String?,eventDetails: null == eventDetails ? _self.eventDetails : eventDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,quickNote: null == quickNote ? _self.quickNote : quickNote // ignore: cast_nullable_to_non_nullable
as String,currentMinute: null == currentMinute ? _self.currentMinute : currentMinute // ignore: cast_nullable_to_non_nullable
as int,clockRunning: null == clockRunning ? _self.clockRunning : clockRunning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveMatchData].
extension LiveMatchDataPatterns on LiveMatchData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMatchData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMatchData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMatchData value)  $default,){
final _that = this;
switch (_that) {
case _LiveMatchData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMatchData value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMatchData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int matchId,  int? scoutMatchId,  int? selectedPlayerId,  String? selectedEventType,  String? selectedZone,  Map<String, dynamic> eventDetails,  String quickNote,  int currentMinute,  bool clockRunning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMatchData() when $default != null:
return $default(_that.matchId,_that.scoutMatchId,_that.selectedPlayerId,_that.selectedEventType,_that.selectedZone,_that.eventDetails,_that.quickNote,_that.currentMinute,_that.clockRunning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int matchId,  int? scoutMatchId,  int? selectedPlayerId,  String? selectedEventType,  String? selectedZone,  Map<String, dynamic> eventDetails,  String quickNote,  int currentMinute,  bool clockRunning)  $default,) {final _that = this;
switch (_that) {
case _LiveMatchData():
return $default(_that.matchId,_that.scoutMatchId,_that.selectedPlayerId,_that.selectedEventType,_that.selectedZone,_that.eventDetails,_that.quickNote,_that.currentMinute,_that.clockRunning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int matchId,  int? scoutMatchId,  int? selectedPlayerId,  String? selectedEventType,  String? selectedZone,  Map<String, dynamic> eventDetails,  String quickNote,  int currentMinute,  bool clockRunning)?  $default,) {final _that = this;
switch (_that) {
case _LiveMatchData() when $default != null:
return $default(_that.matchId,_that.scoutMatchId,_that.selectedPlayerId,_that.selectedEventType,_that.selectedZone,_that.eventDetails,_that.quickNote,_that.currentMinute,_that.clockRunning);case _:
  return null;

}
}

}

/// @nodoc


class _LiveMatchData implements LiveMatchData {
  const _LiveMatchData({required this.matchId, this.scoutMatchId, this.selectedPlayerId, this.selectedEventType, this.selectedZone, final  Map<String, dynamic> eventDetails = const <String, dynamic>{}, this.quickNote = '', this.currentMinute = 0, this.clockRunning = false}): _eventDetails = eventDetails;
  

@override final  int matchId;
@override final  int? scoutMatchId;
@override final  int? selectedPlayerId;
@override final  String? selectedEventType;
@override final  String? selectedZone;
 final  Map<String, dynamic> _eventDetails;
@override@JsonKey() Map<String, dynamic> get eventDetails {
  if (_eventDetails is EqualUnmodifiableMapView) return _eventDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_eventDetails);
}

@override@JsonKey() final  String quickNote;
@override@JsonKey() final  int currentMinute;
@override@JsonKey() final  bool clockRunning;

/// Create a copy of LiveMatchData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMatchDataCopyWith<_LiveMatchData> get copyWith => __$LiveMatchDataCopyWithImpl<_LiveMatchData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMatchData&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.scoutMatchId, scoutMatchId) || other.scoutMatchId == scoutMatchId)&&(identical(other.selectedPlayerId, selectedPlayerId) || other.selectedPlayerId == selectedPlayerId)&&(identical(other.selectedEventType, selectedEventType) || other.selectedEventType == selectedEventType)&&(identical(other.selectedZone, selectedZone) || other.selectedZone == selectedZone)&&const DeepCollectionEquality().equals(other._eventDetails, _eventDetails)&&(identical(other.quickNote, quickNote) || other.quickNote == quickNote)&&(identical(other.currentMinute, currentMinute) || other.currentMinute == currentMinute)&&(identical(other.clockRunning, clockRunning) || other.clockRunning == clockRunning));
}


@override
int get hashCode => Object.hash(runtimeType,matchId,scoutMatchId,selectedPlayerId,selectedEventType,selectedZone,const DeepCollectionEquality().hash(_eventDetails),quickNote,currentMinute,clockRunning);

@override
String toString() {
  return 'LiveMatchData(matchId: $matchId, scoutMatchId: $scoutMatchId, selectedPlayerId: $selectedPlayerId, selectedEventType: $selectedEventType, selectedZone: $selectedZone, eventDetails: $eventDetails, quickNote: $quickNote, currentMinute: $currentMinute, clockRunning: $clockRunning)';
}


}

/// @nodoc
abstract mixin class _$LiveMatchDataCopyWith<$Res> implements $LiveMatchDataCopyWith<$Res> {
  factory _$LiveMatchDataCopyWith(_LiveMatchData value, $Res Function(_LiveMatchData) _then) = __$LiveMatchDataCopyWithImpl;
@override @useResult
$Res call({
 int matchId, int? scoutMatchId, int? selectedPlayerId, String? selectedEventType, String? selectedZone, Map<String, dynamic> eventDetails, String quickNote, int currentMinute, bool clockRunning
});




}
/// @nodoc
class __$LiveMatchDataCopyWithImpl<$Res>
    implements _$LiveMatchDataCopyWith<$Res> {
  __$LiveMatchDataCopyWithImpl(this._self, this._then);

  final _LiveMatchData _self;
  final $Res Function(_LiveMatchData) _then;

/// Create a copy of LiveMatchData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? scoutMatchId = freezed,Object? selectedPlayerId = freezed,Object? selectedEventType = freezed,Object? selectedZone = freezed,Object? eventDetails = null,Object? quickNote = null,Object? currentMinute = null,Object? clockRunning = null,}) {
  return _then(_LiveMatchData(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as int,scoutMatchId: freezed == scoutMatchId ? _self.scoutMatchId : scoutMatchId // ignore: cast_nullable_to_non_nullable
as int?,selectedPlayerId: freezed == selectedPlayerId ? _self.selectedPlayerId : selectedPlayerId // ignore: cast_nullable_to_non_nullable
as int?,selectedEventType: freezed == selectedEventType ? _self.selectedEventType : selectedEventType // ignore: cast_nullable_to_non_nullable
as String?,selectedZone: freezed == selectedZone ? _self.selectedZone : selectedZone // ignore: cast_nullable_to_non_nullable
as String?,eventDetails: null == eventDetails ? _self._eventDetails : eventDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,quickNote: null == quickNote ? _self.quickNote : quickNote // ignore: cast_nullable_to_non_nullable
as String,currentMinute: null == currentMinute ? _self.currentMinute : currentMinute // ignore: cast_nullable_to_non_nullable
as int,clockRunning: null == clockRunning ? _self.clockRunning : clockRunning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
