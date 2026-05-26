// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Player {

 String? get id; String get firstname; String get lastname; DateTime get birthday;@JsonKey(fromJson: _numFromJson) double get height;@JsonKey(fromJson: _numFromJson) double get weight; String get notes;@JsonKey(fromJson: _footFromJson, toJson: _footToJson) FootPreference get preferredFoot; bool get basicForces; String get city; String get country; String get photo; String? get teamId;
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCopyWith<Player> get copyWith => _$PlayerCopyWithImpl<Player>(this as Player, _$identity);

  /// Serializes this Player to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Player&&(identical(other.id, id) || other.id == id)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.preferredFoot, preferredFoot) || other.preferredFoot == preferredFoot)&&(identical(other.basicForces, basicForces) || other.basicForces == basicForces)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstname,lastname,birthday,height,weight,notes,preferredFoot,basicForces,city,country,photo,teamId);

@override
String toString() {
  return 'Player(id: $id, firstname: $firstname, lastname: $lastname, birthday: $birthday, height: $height, weight: $weight, notes: $notes, preferredFoot: $preferredFoot, basicForces: $basicForces, city: $city, country: $country, photo: $photo, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class $PlayerCopyWith<$Res>  {
  factory $PlayerCopyWith(Player value, $Res Function(Player) _then) = _$PlayerCopyWithImpl;
@useResult
$Res call({
 String? id, String firstname, String lastname, DateTime birthday,@JsonKey(fromJson: _numFromJson) double height,@JsonKey(fromJson: _numFromJson) double weight, String notes,@JsonKey(fromJson: _footFromJson, toJson: _footToJson) FootPreference preferredFoot, bool basicForces, String city, String country, String photo, String? teamId
});




}
/// @nodoc
class _$PlayerCopyWithImpl<$Res>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._self, this._then);

  final Player _self;
  final $Res Function(Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? firstname = null,Object? lastname = null,Object? birthday = null,Object? height = null,Object? weight = null,Object? notes = null,Object? preferredFoot = null,Object? basicForces = null,Object? city = null,Object? country = null,Object? photo = null,Object? teamId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,preferredFoot: null == preferredFoot ? _self.preferredFoot : preferredFoot // ignore: cast_nullable_to_non_nullable
as FootPreference,basicForces: null == basicForces ? _self.basicForces : basicForces // ignore: cast_nullable_to_non_nullable
as bool,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Player].
extension PlayerPatterns on Player {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Player value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Player value)  $default,){
final _that = this;
switch (_that) {
case _Player():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Player value)?  $default,){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String firstname,  String lastname,  DateTime birthday, @JsonKey(fromJson: _numFromJson)  double height, @JsonKey(fromJson: _numFromJson)  double weight,  String notes, @JsonKey(fromJson: _footFromJson, toJson: _footToJson)  FootPreference preferredFoot,  bool basicForces,  String city,  String country,  String photo,  String? teamId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.firstname,_that.lastname,_that.birthday,_that.height,_that.weight,_that.notes,_that.preferredFoot,_that.basicForces,_that.city,_that.country,_that.photo,_that.teamId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String firstname,  String lastname,  DateTime birthday, @JsonKey(fromJson: _numFromJson)  double height, @JsonKey(fromJson: _numFromJson)  double weight,  String notes, @JsonKey(fromJson: _footFromJson, toJson: _footToJson)  FootPreference preferredFoot,  bool basicForces,  String city,  String country,  String photo,  String? teamId)  $default,) {final _that = this;
switch (_that) {
case _Player():
return $default(_that.id,_that.firstname,_that.lastname,_that.birthday,_that.height,_that.weight,_that.notes,_that.preferredFoot,_that.basicForces,_that.city,_that.country,_that.photo,_that.teamId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String firstname,  String lastname,  DateTime birthday, @JsonKey(fromJson: _numFromJson)  double height, @JsonKey(fromJson: _numFromJson)  double weight,  String notes, @JsonKey(fromJson: _footFromJson, toJson: _footToJson)  FootPreference preferredFoot,  bool basicForces,  String city,  String country,  String photo,  String? teamId)?  $default,) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.firstname,_that.lastname,_that.birthday,_that.height,_that.weight,_that.notes,_that.preferredFoot,_that.basicForces,_that.city,_that.country,_that.photo,_that.teamId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Player implements Player {
  const _Player({this.id, required this.firstname, required this.lastname, required this.birthday, @JsonKey(fromJson: _numFromJson) required this.height, @JsonKey(fromJson: _numFromJson) required this.weight, required this.notes, @JsonKey(fromJson: _footFromJson, toJson: _footToJson) required this.preferredFoot, required this.basicForces, required this.city, required this.country, required this.photo, this.teamId});
  factory _Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

@override final  String? id;
@override final  String firstname;
@override final  String lastname;
@override final  DateTime birthday;
@override@JsonKey(fromJson: _numFromJson) final  double height;
@override@JsonKey(fromJson: _numFromJson) final  double weight;
@override final  String notes;
@override@JsonKey(fromJson: _footFromJson, toJson: _footToJson) final  FootPreference preferredFoot;
@override final  bool basicForces;
@override final  String city;
@override final  String country;
@override final  String photo;
@override final  String? teamId;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerCopyWith<_Player> get copyWith => __$PlayerCopyWithImpl<_Player>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Player&&(identical(other.id, id) || other.id == id)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.preferredFoot, preferredFoot) || other.preferredFoot == preferredFoot)&&(identical(other.basicForces, basicForces) || other.basicForces == basicForces)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstname,lastname,birthday,height,weight,notes,preferredFoot,basicForces,city,country,photo,teamId);

@override
String toString() {
  return 'Player(id: $id, firstname: $firstname, lastname: $lastname, birthday: $birthday, height: $height, weight: $weight, notes: $notes, preferredFoot: $preferredFoot, basicForces: $basicForces, city: $city, country: $country, photo: $photo, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) _then) = __$PlayerCopyWithImpl;
@override @useResult
$Res call({
 String? id, String firstname, String lastname, DateTime birthday,@JsonKey(fromJson: _numFromJson) double height,@JsonKey(fromJson: _numFromJson) double weight, String notes,@JsonKey(fromJson: _footFromJson, toJson: _footToJson) FootPreference preferredFoot, bool basicForces, String city, String country, String photo, String? teamId
});




}
/// @nodoc
class __$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(this._self, this._then);

  final _Player _self;
  final $Res Function(_Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? firstname = null,Object? lastname = null,Object? birthday = null,Object? height = null,Object? weight = null,Object? notes = null,Object? preferredFoot = null,Object? basicForces = null,Object? city = null,Object? country = null,Object? photo = null,Object? teamId = freezed,}) {
  return _then(_Player(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,preferredFoot: null == preferredFoot ? _self.preferredFoot : preferredFoot // ignore: cast_nullable_to_non_nullable
as FootPreference,basicForces: null == basicForces ? _self.basicForces : basicForces // ignore: cast_nullable_to_non_nullable
as bool,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
