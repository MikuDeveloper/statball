// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school_principal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SchoolPrincipal {

 int? get id; String get name; String get lastname; String? get email; String? get phoneNumber; String? get instagram; String? get facebook;
/// Create a copy of SchoolPrincipal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolPrincipalCopyWith<SchoolPrincipal> get copyWith => _$SchoolPrincipalCopyWithImpl<SchoolPrincipal>(this as SchoolPrincipal, _$identity);

  /// Serializes this SchoolPrincipal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchoolPrincipal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastname,email,phoneNumber,instagram,facebook);

@override
String toString() {
  return 'SchoolPrincipal(id: $id, name: $name, lastname: $lastname, email: $email, phoneNumber: $phoneNumber, instagram: $instagram, facebook: $facebook)';
}


}

/// @nodoc
abstract mixin class $SchoolPrincipalCopyWith<$Res>  {
  factory $SchoolPrincipalCopyWith(SchoolPrincipal value, $Res Function(SchoolPrincipal) _then) = _$SchoolPrincipalCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String lastname, String? email, String? phoneNumber, String? instagram, String? facebook
});




}
/// @nodoc
class _$SchoolPrincipalCopyWithImpl<$Res>
    implements $SchoolPrincipalCopyWith<$Res> {
  _$SchoolPrincipalCopyWithImpl(this._self, this._then);

  final SchoolPrincipal _self;
  final $Res Function(SchoolPrincipal) _then;

/// Create a copy of SchoolPrincipal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? lastname = null,Object? email = freezed,Object? phoneNumber = freezed,Object? instagram = freezed,Object? facebook = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SchoolPrincipal].
extension SchoolPrincipalPatterns on SchoolPrincipal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchoolPrincipal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchoolPrincipal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchoolPrincipal value)  $default,){
final _that = this;
switch (_that) {
case _SchoolPrincipal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchoolPrincipal value)?  $default,){
final _that = this;
switch (_that) {
case _SchoolPrincipal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String lastname,  String? email,  String? phoneNumber,  String? instagram,  String? facebook)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchoolPrincipal() when $default != null:
return $default(_that.id,_that.name,_that.lastname,_that.email,_that.phoneNumber,_that.instagram,_that.facebook);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String lastname,  String? email,  String? phoneNumber,  String? instagram,  String? facebook)  $default,) {final _that = this;
switch (_that) {
case _SchoolPrincipal():
return $default(_that.id,_that.name,_that.lastname,_that.email,_that.phoneNumber,_that.instagram,_that.facebook);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String lastname,  String? email,  String? phoneNumber,  String? instagram,  String? facebook)?  $default,) {final _that = this;
switch (_that) {
case _SchoolPrincipal() when $default != null:
return $default(_that.id,_that.name,_that.lastname,_that.email,_that.phoneNumber,_that.instagram,_that.facebook);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _SchoolPrincipal implements SchoolPrincipal {
  const _SchoolPrincipal({this.id, required this.name, required this.lastname, this.email, this.phoneNumber, this.instagram, this.facebook});
  factory _SchoolPrincipal.fromJson(Map<String, dynamic> json) => _$SchoolPrincipalFromJson(json);

@override final  int? id;
@override final  String name;
@override final  String lastname;
@override final  String? email;
@override final  String? phoneNumber;
@override final  String? instagram;
@override final  String? facebook;

/// Create a copy of SchoolPrincipal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolPrincipalCopyWith<_SchoolPrincipal> get copyWith => __$SchoolPrincipalCopyWithImpl<_SchoolPrincipal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolPrincipalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchoolPrincipal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastname,email,phoneNumber,instagram,facebook);

@override
String toString() {
  return 'SchoolPrincipal(id: $id, name: $name, lastname: $lastname, email: $email, phoneNumber: $phoneNumber, instagram: $instagram, facebook: $facebook)';
}


}

/// @nodoc
abstract mixin class _$SchoolPrincipalCopyWith<$Res> implements $SchoolPrincipalCopyWith<$Res> {
  factory _$SchoolPrincipalCopyWith(_SchoolPrincipal value, $Res Function(_SchoolPrincipal) _then) = __$SchoolPrincipalCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String lastname, String? email, String? phoneNumber, String? instagram, String? facebook
});




}
/// @nodoc
class __$SchoolPrincipalCopyWithImpl<$Res>
    implements _$SchoolPrincipalCopyWith<$Res> {
  __$SchoolPrincipalCopyWithImpl(this._self, this._then);

  final _SchoolPrincipal _self;
  final $Res Function(_SchoolPrincipal) _then;

/// Create a copy of SchoolPrincipal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? lastname = null,Object? email = freezed,Object? phoneNumber = freezed,Object? instagram = freezed,Object? facebook = freezed,}) {
  return _then(_SchoolPrincipal(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
