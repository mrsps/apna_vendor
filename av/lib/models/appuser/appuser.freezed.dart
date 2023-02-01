// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'appuser.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
class _$AppUserTearOff {
  const _$AppUserTearOff();

  _AppUser call(
      {String? userId,
      String? userPhone,
      String? userName,
      String? userPin,
      UserRole? userRole}) {
    return _AppUser(
      userId: userId,
      userPhone: userPhone,
      userName: userName,
      userPin: userPin,
      userRole: userRole,
    );
  }

  AppUser fromJson(Map<String, Object> json) {
    return AppUser.fromJson(json);
  }
}

/// @nodoc
const $AppUser = _$AppUserTearOff();

/// @nodoc
mixin _$AppUser {
  String? get userId => throw _privateConstructorUsedError;
  String? get userPhone => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get userPin => throw _privateConstructorUsedError;
  UserRole? get userRole => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? userPhone,
      String? userName,
      String? userPin,
      UserRole? userRole});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  final AppUser _value;
  // ignore: unused_field
  final $Res Function(AppUser) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userPhone = freezed,
    Object? userName = freezed,
    Object? userPin = freezed,
    Object? userRole = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: userPhone == freezed
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userPin: userPin == freezed
          ? _value.userPin
          : userPin // ignore: cast_nullable_to_non_nullable
              as String?,
      userRole: userRole == freezed
          ? _value.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as UserRole?,
    ));
  }
}

/// @nodoc
abstract class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) then) =
      __$AppUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      String? userPhone,
      String? userName,
      String? userPin,
      UserRole? userRole});
}

/// @nodoc
class __$AppUserCopyWithImpl<$Res> extends _$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(_AppUser _value, $Res Function(_AppUser) _then)
      : super(_value, (v) => _then(v as _AppUser));

  @override
  _AppUser get _value => super._value as _AppUser;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userPhone = freezed,
    Object? userName = freezed,
    Object? userPin = freezed,
    Object? userRole = freezed,
  }) {
    return _then(_AppUser(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: userPhone == freezed
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userPin: userPin == freezed
          ? _value.userPin
          : userPin // ignore: cast_nullable_to_non_nullable
              as String?,
      userRole: userRole == freezed
          ? _value.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as UserRole?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser implements _AppUser {
  const _$_AppUser(
      {this.userId,
      this.userPhone,
      this.userName,
      this.userPin,
      this.userRole});

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$_$_AppUserFromJson(json);

  @override
  final String? userId;
  @override
  final String? userPhone;
  @override
  final String? userName;
  @override
  final String? userPin;
  @override
  final UserRole? userRole;

  @override
  String toString() {
    return 'AppUser(userId: $userId, userPhone: $userPhone, userName: $userName, userPin: $userPin, userRole: $userRole)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppUser &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.userPhone, userPhone) ||
                const DeepCollectionEquality()
                    .equals(other.userPhone, userPhone)) &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.userPin, userPin) ||
                const DeepCollectionEquality()
                    .equals(other.userPin, userPin)) &&
            (identical(other.userRole, userRole) ||
                const DeepCollectionEquality()
                    .equals(other.userRole, userRole)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(userPhone) ^
      const DeepCollectionEquality().hash(userName) ^
      const DeepCollectionEquality().hash(userPin) ^
      const DeepCollectionEquality().hash(userRole);

  @JsonKey(ignore: true)
  @override
  _$AppUserCopyWith<_AppUser> get copyWith =>
      __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AppUserToJson(this);
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser(
      {String? userId,
      String? userPhone,
      String? userName,
      String? userPin,
      UserRole? userRole}) = _$_AppUser;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override
  String? get userId => throw _privateConstructorUsedError;
  @override
  String? get userPhone => throw _privateConstructorUsedError;
  @override
  String? get userName => throw _privateConstructorUsedError;
  @override
  String? get userPin => throw _privateConstructorUsedError;
  @override
  UserRole? get userRole => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppUserCopyWith<_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
