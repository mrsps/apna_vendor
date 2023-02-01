// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'orderform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderForm _$OrderFormFromJson(Map<String, dynamic> json) {
  return _OrderForm.fromJson(json);
}

/// @nodoc
class _$OrderFormTearOff {
  const _$OrderFormTearOff();

  _OrderForm call(
      {String? orderFormId,
      String? vendorId,
      OrderFormState? orderFormState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp}) {
    return _OrderForm(
      orderFormId: orderFormId,
      vendorId: vendorId,
      orderFormState: orderFormState,
      timestamp: timestamp,
    );
  }

  OrderForm fromJson(Map<String, Object> json) {
    return OrderForm.fromJson(json);
  }
}

/// @nodoc
const $OrderForm = _$OrderFormTearOff();

/// @nodoc
mixin _$OrderForm {
  String? get orderFormId => throw _privateConstructorUsedError;
  String? get vendorId => throw _privateConstructorUsedError;
  OrderFormState? get orderFormState => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
  Timestamp? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderFormCopyWith<OrderForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderFormCopyWith<$Res> {
  factory $OrderFormCopyWith(OrderForm value, $Res Function(OrderForm) then) =
      _$OrderFormCopyWithImpl<$Res>;
  $Res call(
      {String? orderFormId,
      String? vendorId,
      OrderFormState? orderFormState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp});
}

/// @nodoc
class _$OrderFormCopyWithImpl<$Res> implements $OrderFormCopyWith<$Res> {
  _$OrderFormCopyWithImpl(this._value, this._then);

  final OrderForm _value;
  // ignore: unused_field
  final $Res Function(OrderForm) _then;

  @override
  $Res call({
    Object? orderFormId = freezed,
    Object? vendorId = freezed,
    Object? orderFormState = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      orderFormId: orderFormId == freezed
          ? _value.orderFormId
          : orderFormId // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorId: vendorId == freezed
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      orderFormState: orderFormState == freezed
          ? _value.orderFormState
          : orderFormState // ignore: cast_nullable_to_non_nullable
              as OrderFormState?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ));
  }
}

/// @nodoc
abstract class _$OrderFormCopyWith<$Res> implements $OrderFormCopyWith<$Res> {
  factory _$OrderFormCopyWith(
          _OrderForm value, $Res Function(_OrderForm) then) =
      __$OrderFormCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? orderFormId,
      String? vendorId,
      OrderFormState? orderFormState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp});
}

/// @nodoc
class __$OrderFormCopyWithImpl<$Res> extends _$OrderFormCopyWithImpl<$Res>
    implements _$OrderFormCopyWith<$Res> {
  __$OrderFormCopyWithImpl(_OrderForm _value, $Res Function(_OrderForm) _then)
      : super(_value, (v) => _then(v as _OrderForm));

  @override
  _OrderForm get _value => super._value as _OrderForm;

  @override
  $Res call({
    Object? orderFormId = freezed,
    Object? vendorId = freezed,
    Object? orderFormState = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_OrderForm(
      orderFormId: orderFormId == freezed
          ? _value.orderFormId
          : orderFormId // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorId: vendorId == freezed
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      orderFormState: orderFormState == freezed
          ? _value.orderFormState
          : orderFormState // ignore: cast_nullable_to_non_nullable
              as OrderFormState?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderForm implements _OrderForm {
  const _$_OrderForm(
      {this.orderFormId,
      this.vendorId,
      this.orderFormState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          this.timestamp});

  factory _$_OrderForm.fromJson(Map<String, dynamic> json) =>
      _$_$_OrderFormFromJson(json);

  @override
  final String? orderFormId;
  @override
  final String? vendorId;
  @override
  final OrderFormState? orderFormState;
  @override
  @JsonKey(
      name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp? timestamp;

  @override
  String toString() {
    return 'OrderForm(orderFormId: $orderFormId, vendorId: $vendorId, orderFormState: $orderFormState, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OrderForm &&
            (identical(other.orderFormId, orderFormId) ||
                const DeepCollectionEquality()
                    .equals(other.orderFormId, orderFormId)) &&
            (identical(other.vendorId, vendorId) ||
                const DeepCollectionEquality()
                    .equals(other.vendorId, vendorId)) &&
            (identical(other.orderFormState, orderFormState) ||
                const DeepCollectionEquality()
                    .equals(other.orderFormState, orderFormState)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(orderFormId) ^
      const DeepCollectionEquality().hash(vendorId) ^
      const DeepCollectionEquality().hash(orderFormState) ^
      const DeepCollectionEquality().hash(timestamp);

  @JsonKey(ignore: true)
  @override
  _$OrderFormCopyWith<_OrderForm> get copyWith =>
      __$OrderFormCopyWithImpl<_OrderForm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OrderFormToJson(this);
  }
}

abstract class _OrderForm implements OrderForm {
  const factory _OrderForm(
      {String? orderFormId,
      String? vendorId,
      OrderFormState? orderFormState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp}) = _$_OrderForm;

  factory _OrderForm.fromJson(Map<String, dynamic> json) =
      _$_OrderForm.fromJson;

  @override
  String? get orderFormId => throw _privateConstructorUsedError;
  @override
  String? get vendorId => throw _privateConstructorUsedError;
  @override
  OrderFormState? get orderFormState => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
  Timestamp? get timestamp => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OrderFormCopyWith<_OrderForm> get copyWith =>
      throw _privateConstructorUsedError;
}
