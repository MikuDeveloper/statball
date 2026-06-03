// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Scout {

 String? get id; String get name; String get lastname; DateTime get birthday; String get phoneNumber; String get address; String get photo;
/// Create a copy of Scout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutCopyWith<Scout> get copyWith => _$ScoutCopyWithImpl<Scout>(this as Scout, _$identity);

  /// Serializes this Scout to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Scout&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.photo, photo) || other.photo == photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastname,birthday,phoneNumber,address,photo);

@override
String toString() {
  return 'Scout(id: $id, name: $name, lastname: $lastname, birthday: $birthday, phoneNumber: $phoneNumber, address: $address, photo: $photo)';
}


}

/// @nodoc
abstract mixin class $ScoutCopyWith<$Res>  {
  factory $ScoutCopyWith(Scout value, $Res Function(Scout) _then) = _$ScoutCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String lastname, DateTime birthday, String phoneNumber, String address, String photo
});




}
/// @nodoc
class _$ScoutCopyWithImpl<$Res>
    implements $ScoutCopyWith<$Res> {
  _$ScoutCopyWithImpl(this._self, this._then);

  final Scout _self;
  final $Res Function(Scout) _then;

/// Create a copy of Scout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? lastname = null,Object? birthday = null,Object? phoneNumber = null,Object? address = null,Object? photo = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Scout].
extension ScoutPatterns on Scout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Scout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Scout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Scout value)  $default,){
final _that = this;
switch (_that) {
case _Scout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Scout value)?  $default,){
final _that = this;
switch (_that) {
case _Scout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String lastname,  DateTime birthday,  String phoneNumber,  String address,  String photo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Scout() when $default != null:
return $default(_that.id,_that.name,_that.lastname,_that.birthday,_that.phoneNumber,_that.address,_that.photo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String lastname,  DateTime birthday,  String phoneNumber,  String address,  String photo)  $default,) {final _that = this;
switch (_that) {
case _Scout():
return $default(_that.id,_that.name,_that.lastname,_that.birthday,_that.phoneNumber,_that.address,_that.photo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String lastname,  DateTime birthday,  String phoneNumber,  String address,  String photo)?  $default,) {final _that = this;
switch (_that) {
case _Scout() when $default != null:
return $default(_that.id,_that.name,_that.lastname,_that.birthday,_that.phoneNumber,_that.address,_that.photo);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Scout implements Scout {
  const _Scout({this.id, required this.name, required this.lastname, required this.birthday, required this.phoneNumber, required this.address, required this.photo});
  factory _Scout.fromJson(Map<String, dynamic> json) => _$ScoutFromJson(json);

@override final  String? id;
@override final  String name;
@override final  String lastname;
@override final  DateTime birthday;
@override final  String phoneNumber;
@override final  String address;
@override final  String photo;

/// Create a copy of Scout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutCopyWith<_Scout> get copyWith => __$ScoutCopyWithImpl<_Scout>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Scout&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.photo, photo) || other.photo == photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastname,birthday,phoneNumber,address,photo);

@override
String toString() {
  return 'Scout(id: $id, name: $name, lastname: $lastname, birthday: $birthday, phoneNumber: $phoneNumber, address: $address, photo: $photo)';
}


}

/// @nodoc
abstract mixin class _$ScoutCopyWith<$Res> implements $ScoutCopyWith<$Res> {
  factory _$ScoutCopyWith(_Scout value, $Res Function(_Scout) _then) = __$ScoutCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String lastname, DateTime birthday, String phoneNumber, String address, String photo
});




}
/// @nodoc
class __$ScoutCopyWithImpl<$Res>
    implements _$ScoutCopyWith<$Res> {
  __$ScoutCopyWithImpl(this._self, this._then);

  final _Scout _self;
  final $Res Function(_Scout) _then;

/// Create a copy of Scout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? lastname = null,Object? birthday = null,Object? phoneNumber = null,Object? address = null,Object? photo = null,}) {
  return _then(_Scout(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
