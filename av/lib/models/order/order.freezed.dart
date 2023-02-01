// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
class _$OrderTearOff {
  const _$OrderTearOff();

  _Order call(
      {String? orderId,
      String? consumerId,
      String? leaderId,
      String? vendorId,
      OrderState? orderState,
      PaymentState? paymentState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp,
      Map<String, int>? products}) {
    return _Order(
      orderId: orderId,
      consumerId: consumerId,
      leaderId: leaderId,
      vendorId: vendorId,
      orderState: orderState,
      paymentState: paymentState,
      timestamp: timestamp,
      products: products,
    );
  }

  Order fromJson(Map<String, Object> json) {
    return Order.fromJson(json);
  }
}

/// @nodoc
const $Order = _$OrderTearOff();

/// @nodoc
mixin _$Order {
  String? get orderId => throw _privateConstructorUsedError;
  String? get consumerId => throw _privateConstructorUsedError;
  String? get leaderId => throw _privateConstructorUsedError;
  String? get vendorId => throw _privateConstructorUsedError;
  OrderState? get orderState => throw _privateConstructorUsedError;
  PaymentState? get paymentState => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
  Timestamp? get timestamp => throw _privateConstructorUsedError;
  Map<String, int>? get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res>;
  $Res call(
      {String? orderId,
      String? consumerId,
      String? leaderId,
      String? vendorId,
      OrderState? orderState,
      PaymentState? paymentState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp,
      Map<String, int>? products});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  final Order _value;
  // ignore: unused_field
  final $Res Function(Order) _then;

  @override
  $Res call({
    Object? orderId = freezed,
    Object? consumerId = freezed,
    Object? leaderId = freezed,
    Object? vendorId = freezed,
    Object? orderState = freezed,
    Object? paymentState = freezed,
    Object? timestamp = freezed,
    Object? products = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerId: consumerId == freezed
          ? _value.consumerId
          : consumerId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaderId: leaderId == freezed
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorId: vendorId == freezed
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      orderState: orderState == freezed
          ? _value.orderState
          : orderState // ignore: cast_nullable_to_non_nullable
              as OrderState?,
      paymentState: paymentState == freezed
          ? _value.paymentState
          : paymentState // ignore: cast_nullable_to_non_nullable
              as PaymentState?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
    ));
  }
}

/// @nodoc
abstract class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) then) =
      __$OrderCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? orderId,
      String? consumerId,
      String? leaderId,
      String? vendorId,
      OrderState? orderState,
      PaymentState? paymentState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp,
      Map<String, int>? products});
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> extends _$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(_Order _value, $Res Function(_Order) _then)
      : super(_value, (v) => _then(v as _Order));

  @override
  _Order get _value => super._value as _Order;

  @override
  $Res call({
    Object? orderId = freezed,
    Object? consumerId = freezed,
    Object? leaderId = freezed,
    Object? vendorId = freezed,
    Object? orderState = freezed,
    Object? paymentState = freezed,
    Object? timestamp = freezed,
    Object? products = freezed,
  }) {
    return _then(_Order(
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerId: consumerId == freezed
          ? _value.consumerId
          : consumerId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaderId: leaderId == freezed
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorId: vendorId == freezed
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      orderState: orderState == freezed
          ? _value.orderState
          : orderState // ignore: cast_nullable_to_non_nullable
              as OrderState?,
      paymentState: paymentState == freezed
          ? _value.paymentState
          : paymentState // ignore: cast_nullable_to_non_nullable
              as PaymentState?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Order implements _Order {
  const _$_Order(
      {this.orderId,
      this.consumerId,
      this.leaderId,
      this.vendorId,
      this.orderState,
      this.paymentState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          this.timestamp,
      this.products});

  factory _$_Order.fromJson(Map<String, dynamic> json) =>
      _$_$_OrderFromJson(json);

  @override
  final String? orderId;
  @override
  final String? consumerId;
  @override
  final String? leaderId;
  @override
  final String? vendorId;
  @override
  final OrderState? orderState;
  @override
  final PaymentState? paymentState;
  @override
  @JsonKey(
      name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp? timestamp;
  @override
  final Map<String, int>? products;

  @override
  String toString() {
    return 'Order(orderId: $orderId, consumerId: $consumerId, leaderId: $leaderId, vendorId: $vendorId, orderState: $orderState, paymentState: $paymentState, timestamp: $timestamp, products: $products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Order &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality()
                    .equals(other.orderId, orderId)) &&
            (identical(other.consumerId, consumerId) ||
                const DeepCollectionEquality()
                    .equals(other.consumerId, consumerId)) &&
            (identical(other.leaderId, leaderId) ||
                const DeepCollectionEquality()
                    .equals(other.leaderId, leaderId)) &&
            (identical(other.vendorId, vendorId) ||
                const DeepCollectionEquality()
                    .equals(other.vendorId, vendorId)) &&
            (identical(other.orderState, orderState) ||
                const DeepCollectionEquality()
                    .equals(other.orderState, orderState)) &&
            (identical(other.paymentState, paymentState) ||
                const DeepCollectionEquality()
                    .equals(other.paymentState, paymentState)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(consumerId) ^
      const DeepCollectionEquality().hash(leaderId) ^
      const DeepCollectionEquality().hash(vendorId) ^
      const DeepCollectionEquality().hash(orderState) ^
      const DeepCollectionEquality().hash(paymentState) ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(products);

  @JsonKey(ignore: true)
  @override
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OrderToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {String? orderId,
      String? consumerId,
      String? leaderId,
      String? vendorId,
      OrderState? orderState,
      PaymentState? paymentState,
      @JsonKey(name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
          Timestamp? timestamp,
      Map<String, int>? products}) = _$_Order;

  factory _Order.fromJson(Map<String, dynamic> json) = _$_Order.fromJson;

  @override
  String? get orderId => throw _privateConstructorUsedError;
  @override
  String? get consumerId => throw _privateConstructorUsedError;
  @override
  String? get leaderId => throw _privateConstructorUsedError;
  @override
  String? get vendorId => throw _privateConstructorUsedError;
  @override
  OrderState? get orderState => throw _privateConstructorUsedError;
  @override
  PaymentState? get paymentState => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      name: 'timestamp', fromJson: _timestampFromJson, toJson: _timestampToJson)
  Timestamp? get timestamp => throw _privateConstructorUsedError;
  @override
  Map<String, int>? get products => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OrderCopyWith<_Order> get copyWith => throw _privateConstructorUsedError;
}
