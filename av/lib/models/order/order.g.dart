// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$_$_OrderFromJson(Map<String, dynamic> json) {
  return _$_Order(
    orderId: json['orderId'] as String?,
    consumerId: json['consumerId'] as String?,
    leaderId: json['leaderId'] as String?,
    vendorId: json['vendorId'] as String?,
    orderState: _$enumDecodeNullable(_$OrderStateEnumMap, json['orderState']),
    paymentState:
        _$enumDecodeNullable(_$PaymentStateEnumMap, json['paymentState']),
    timestamp: _timestampFromJson(json['timestamp'] as Timestamp),
    products: (json['products'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$_$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'consumerId': instance.consumerId,
      'leaderId': instance.leaderId,
      'vendorId': instance.vendorId,
      'orderState': _$OrderStateEnumMap[instance.orderState],
      'paymentState': _$PaymentStateEnumMap[instance.paymentState],
      'timestamp': _timestampToJson(instance.timestamp),
      'products': instance.products,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$OrderStateEnumMap = {
  OrderState.CREATED: 'CREATED',
  OrderState.SHIPPED: 'SHIPPED',
  OrderState.CANCELLED: 'CANCELLED',
  OrderState.DELIVERED: 'DELIVERED',
};

const _$PaymentStateEnumMap = {
  PaymentState.PENDING: 'PENDING',
  PaymentState.DONE: 'DONE',
};
