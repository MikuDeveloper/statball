// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sb_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SbUser {

 String get id; String get email; String get role; DateTime get createdAt;
/// Create a copy of SbUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SbUserCopyWith<SbUser> get copyWith => _$SbUserCopyWithImpl<SbUser>(this as SbUser, _$identity);

  /// Serializes this SbUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SbUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,role,createdAt);

@override
String toString() {
  return 'SbUser(id: $id, email: $email, role: $role, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SbUserCopyWith<$Res>  {
  factory $SbUserCopyWith(SbUser value, $Res Function(SbUser) _then) = _$SbUserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String role, DateTime createdAt
});




}
/// @nodoc
class _$SbUserCopyWithImpl<$Res>
    implements $SbUserCopyWith<$Res> {
  _$SbUserCopyWithImpl(this._self, this._then);

  final SbUser _self;
  final $Res Function(SbUser) _then;

/// Create a copy of SbUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? role = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SbUser].
extension SbUserPatterns on SbUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SbUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SbUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SbUser value)  $default,){
final _that = this;
switch (_that) {
case _SbUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SbUser value)?  $default,){
final _that = this;
switch (_that) {
case _SbUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String role,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SbUser() when $default != null:
return $default(_that.id,_that.email,_that.role,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String role,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SbUser():
return $default(_that.id,_that.email,_that.role,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String role,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SbUser() when $default != null:
return $default(_that.id,_that.email,_that.role,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _SbUser implements SbUser {
  const _SbUser({required this.id, required this.email, required this.role, required this.createdAt});
  factory _SbUser.fromJson(Map<String, dynamic> json) => _$SbUserFromJson(json);

@override final  String id;
@override final  String email;
@override final  String role;
@override final  DateTime createdAt;

/// Create a copy of SbUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SbUserCopyWith<_SbUser> get copyWith => __$SbUserCopyWithImpl<_SbUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SbUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SbUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,role,createdAt);

@override
String toString() {
  return 'SbUser(id: $id, email: $email, role: $role, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SbUserCopyWith<$Res> implements $SbUserCopyWith<$Res> {
  factory _$SbUserCopyWith(_SbUser value, $Res Function(_SbUser) _then) = __$SbUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String role, DateTime createdAt
});




}
/// @nodoc
class __$SbUserCopyWithImpl<$Res>
    implements _$SbUserCopyWith<$Res> {
  __$SbUserCopyWithImpl(this._self, this._then);

  final _SbUser _self;
  final $Res Function(_SbUser) _then;

/// Create a copy of SbUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? role = null,Object? createdAt = null,}) {
  return _then(_SbUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
