// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'consumer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConsumerAddress _$ConsumerAddressFromJson(Map<String, dynamic> json) {
  return _ConsumerAddress.fromJson(json);
}

/// @nodoc
class _$ConsumerAddressTearOff {
  const _$ConsumerAddressTearOff();

  _ConsumerAddress call(
      {String? consumerId,
      String? consumerPhone,
      String? consumerName,
      String? consumerHouse,
      String? consumerApartment}) {
    return _ConsumerAddress(
      consumerId: consumerId,
      consumerPhone: consumerPhone,
      consumerName: consumerName,
      consumerHouse: consumerHouse,
      consumerApartment: consumerApartment,
    );
  }

  ConsumerAddress fromJson(Map<String, Object> json) {
    return ConsumerAddress.fromJson(json);
  }
}

/// @nodoc
const $ConsumerAddress = _$ConsumerAddressTearOff();

/// @nodoc
mixin _$ConsumerAddress {
  String? get consumerId => throw _privateConstructorUsedError;
  String? get consumerPhone => throw _privateConstructorUsedError;
  String? get consumerName => throw _privateConstructorUsedError;
  String? get consumerHouse => throw _privateConstructorUsedError;
  String? get consumerApartment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsumerAddressCopyWith<ConsumerAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumerAddressCopyWith<$Res> {
  factory $ConsumerAddressCopyWith(
          ConsumerAddress value, $Res Function(ConsumerAddress) then) =
      _$ConsumerAddressCopyWithImpl<$Res>;
  $Res call(
      {String? consumerId,
      String? consumerPhone,
      String? consumerName,
      String? consumerHouse,
      String? consumerApartment});
}

/// @nodoc
class _$ConsumerAddressCopyWithImpl<$Res>
    implements $ConsumerAddressCopyWith<$Res> {
  _$ConsumerAddressCopyWithImpl(this._value, this._then);

  final ConsumerAddress _value;
  // ignore: unused_field
  final $Res Function(ConsumerAddress) _then;

  @override
  $Res call({
    Object? consumerId = freezed,
    Object? consumerPhone = freezed,
    Object? consumerName = freezed,
    Object? consumerHouse = freezed,
    Object? consumerApartment = freezed,
  }) {
    return _then(_value.copyWith(
      consumerId: consumerId == freezed
          ? _value.consumerId
          : consumerId // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerPhone: consumerPhone == freezed
          ? _value.consumerPhone
          : consumerPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerName: consumerName == freezed
          ? _value.consumerName
          : consumerName // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerHouse: consumerHouse == freezed
          ? _value.consumerHouse
          : consumerHouse // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerApartment: consumerApartment == freezed
          ? _value.consumerApartment
          : consumerApartment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ConsumerAddressCopyWith<$Res>
    implements $ConsumerAddressCopyWith<$Res> {
  factory _$ConsumerAddressCopyWith(
          _ConsumerAddress value, $Res Function(_ConsumerAddress) then) =
      __$ConsumerAddressCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? consumerId,
      String? consumerPhone,
      String? consumerName,
      String? consumerHouse,
      String? consumerApartment});
}

/// @nodoc
class __$ConsumerAddressCopyWithImpl<$Res>
    extends _$ConsumerAddressCopyWithImpl<$Res>
    implements _$ConsumerAddressCopyWith<$Res> {
  __$ConsumerAddressCopyWithImpl(
      _ConsumerAddress _value, $Res Function(_ConsumerAddress) _then)
      : super(_value, (v) => _then(v as _ConsumerAddress));

  @override
  _ConsumerAddress get _value => super._value as _ConsumerAddress;

  @override
  $Res call({
    Object? consumerId = freezed,
    Object? consumerPhone = freezed,
    Object? consumerName = freezed,
    Object? consumerHouse = freezed,
    Object? consumerApartment = freezed,
  }) {
    return _then(_ConsumerAddress(
      consumerId: consumerId == freezed
          ? _value.consumerId
          : consumerId // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerPhone: consumerPhone == freezed
          ? _value.consumerPhone
          : consumerPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerName: consumerName == freezed
          ? _value.consumerName
          : consumerName // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerHouse: consumerHouse == freezed
          ? _value.consumerHouse
          : consumerHouse // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerApartment: consumerApartment == freezed
          ? _value.consumerApartment
          : consumerApartment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConsumerAddress implements _ConsumerAddress {
  const _$_ConsumerAddress(
      {this.consumerId,
      this.consumerPhone,
      this.consumerName,
      this.consumerHouse,
      this.consumerApartment});

  factory _$_ConsumerAddress.fromJson(Map<String, dynamic> json) =>
      _$_$_ConsumerAddressFromJson(json);

  @override
  final String? consumerId;
  @override
  final String? consumerPhone;
  @override
  final String? consumerName;
  @override
  final String? consumerHouse;
  @override
  final String? consumerApartment;

  @override
  String toString() {
    return 'ConsumerAddress(consumerId: $consumerId, consumerPhone: $consumerPhone, consumerName: $consumerName, consumerHouse: $consumerHouse, consumerApartment: $consumerApartment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConsumerAddress &&
            (identical(other.consumerId, consumerId) ||
                const DeepCollectionEquality()
                    .equals(other.consumerId, consumerId)) &&
            (identical(other.consumerPhone, consumerPhone) ||
                const DeepCollectionEquality()
                    .equals(other.consumerPhone, consumerPhone)) &&
            (identical(other.consumerName, consumerName) ||
                const DeepCollectionEquality()
                    .equals(other.consumerName, consumerName)) &&
            (identical(other.consumerHouse, consumerHouse) ||
                const DeepCollectionEquality()
                    .equals(other.consumerHouse, consumerHouse)) &&
            (identical(other.consumerApartment, consumerApartment) ||
                const DeepCollectionEquality()
                    .equals(other.consumerApartment, consumerApartment)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(consumerId) ^
      const DeepCollectionEquality().hash(consumerPhone) ^
      const DeepCollectionEquality().hash(consumerName) ^
      const DeepCollectionEquality().hash(consumerHouse) ^
      const DeepCollectionEquality().hash(consumerApartment);

  @JsonKey(ignore: true)
  @override
  _$ConsumerAddressCopyWith<_ConsumerAddress> get copyWith =>
      __$ConsumerAddressCopyWithImpl<_ConsumerAddress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConsumerAddressToJson(this);
  }
}

abstract class _ConsumerAddress implements ConsumerAddress {
  const factory _ConsumerAddress(
      {String? consumerId,
      String? consumerPhone,
      String? consumerName,
      String? consumerHouse,
      String? consumerApartment}) = _$_ConsumerAddress;

  factory _ConsumerAddress.fromJson(Map<String, dynamic> json) =
      _$_ConsumerAddress.fromJson;

  @override
  String? get consumerId => throw _privateConstructorUsedError;
  @override
  String? get consumerPhone => throw _privateConstructorUsedError;
  @override
  String? get consumerName => throw _privateConstructorUsedError;
  @override
  String? get consumerHouse => throw _privateConstructorUsedError;
  @override
  String? get consumerApartment => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConsumerAddressCopyWith<_ConsumerAddress> get copyWith =>
      throw _privateConstructorUsedError;
}
