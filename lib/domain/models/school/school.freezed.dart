// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$School {

 int? get id; String get name; String? get site; String? get facebook; String? get instagram; String? get phoneNumber; String? get email; String? get city; String? get state; String? get country; int? get principalId;
/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolCopyWith<School> get copyWith => _$SchoolCopyWithImpl<School>(this as School, _$identity);

  /// Serializes this School to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is School&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.site, site) || other.site == site)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.principalId, principalId) || other.principalId == principalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,site,facebook,instagram,phoneNumber,email,city,state,country,principalId);

@override
String toString() {
  return 'School(id: $id, name: $name, site: $site, facebook: $facebook, instagram: $instagram, phoneNumber: $phoneNumber, email: $email, city: $city, state: $state, country: $country, principalId: $principalId)';
}


}

/// @nodoc
abstract mixin class $SchoolCopyWith<$Res>  {
  factory $SchoolCopyWith(School value, $Res Function(School) _then) = _$SchoolCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String? site, String? facebook, String? instagram, String? phoneNumber, String? email, String? city, String? state, String? country, int? principalId
});




}
/// @nodoc
class _$SchoolCopyWithImpl<$Res>
    implements $SchoolCopyWith<$Res> {
  _$SchoolCopyWithImpl(this._self, this._then);

  final School _self;
  final $Res Function(School) _then;

/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? site = freezed,Object? facebook = freezed,Object? instagram = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? principalId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,principalId: freezed == principalId ? _self.principalId : principalId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [School].
extension SchoolPatterns on School {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _School value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _School() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _School value)  $default,){
final _that = this;
switch (_that) {
case _School():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _School value)?  $default,){
final _that = this;
switch (_that) {
case _School() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String? site,  String? facebook,  String? instagram,  String? phoneNumber,  String? email,  String? city,  String? state,  String? country,  int? principalId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _School() when $default != null:
return $default(_that.id,_that.name,_that.site,_that.facebook,_that.instagram,_that.phoneNumber,_that.email,_that.city,_that.state,_that.country,_that.principalId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String? site,  String? facebook,  String? instagram,  String? phoneNumber,  String? email,  String? city,  String? state,  String? country,  int? principalId)  $default,) {final _that = this;
switch (_that) {
case _School():
return $default(_that.id,_that.name,_that.site,_that.facebook,_that.instagram,_that.phoneNumber,_that.email,_that.city,_that.state,_that.country,_that.principalId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String? site,  String? facebook,  String? instagram,  String? phoneNumber,  String? email,  String? city,  String? state,  String? country,  int? principalId)?  $default,) {final _that = this;
switch (_that) {
case _School() when $default != null:
return $default(_that.id,_that.name,_that.site,_that.facebook,_that.instagram,_that.phoneNumber,_that.email,_that.city,_that.state,_that.country,_that.principalId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _School implements School {
  const _School({this.id, required this.name, this.site, this.facebook, this.instagram, this.phoneNumber, this.email, this.city, this.state, this.country, this.principalId});
  factory _School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

@override final  int? id;
@override final  String name;
@override final  String? site;
@override final  String? facebook;
@override final  String? instagram;
@override final  String? phoneNumber;
@override final  String? email;
@override final  String? city;
@override final  String? state;
@override final  String? country;
@override final  int? principalId;

/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolCopyWith<_School> get copyWith => __$SchoolCopyWithImpl<_School>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _School&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.site, site) || other.site == site)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.principalId, principalId) || other.principalId == principalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,site,facebook,instagram,phoneNumber,email,city,state,country,principalId);

@override
String toString() {
  return 'School(id: $id, name: $name, site: $site, facebook: $facebook, instagram: $instagram, phoneNumber: $phoneNumber, email: $email, city: $city, state: $state, country: $country, principalId: $principalId)';
}


}

/// @nodoc
abstract mixin class _$SchoolCopyWith<$Res> implements $SchoolCopyWith<$Res> {
  factory _$SchoolCopyWith(_School value, $Res Function(_School) _then) = __$SchoolCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String? site, String? facebook, String? instagram, String? phoneNumber, String? email, String? city, String? state, String? country, int? principalId
});




}
/// @nodoc
class __$SchoolCopyWithImpl<$Res>
    implements _$SchoolCopyWith<$Res> {
  __$SchoolCopyWithImpl(this._self, this._then);

  final _School _self;
  final $Res Function(_School) _then;

/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? site = freezed,Object? facebook = freezed,Object? instagram = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? principalId = freezed,}) {
  return _then(_School(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,principalId: freezed == principalId ? _self.principalId : principalId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
