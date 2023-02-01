// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderForm _$_$_OrderFormFromJson(Map<String, dynamic> json) {
  return _$_OrderForm(
    orderFormId: json['orderFormId'] as String?,
    vendorId: json['vendorId'] as String?,
    orderFormState:
        _$enumDecodeNullable(_$OrderFormStateEnumMap, json['orderFormState']),
    timestamp: _timestampFromJson(json['timestamp'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_OrderFormToJson(_$_OrderForm instance) =>
    <String, dynamic>{
      'orderFormId': instance.orderFormId,
      'vendorId': instance.vendorId,
      'orderFormState': _$OrderFormStateEnumMap[instance.orderFormState],
      'timestamp': _timestampToJson(instance.timestamp),
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

const _$OrderFormStateEnumMap = {
  OrderFormState.ACTIVE: 'ACTIVE',
  OrderFormState.INACTIVE: 'INACTIVE',
};
