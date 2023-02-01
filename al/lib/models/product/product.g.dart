// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$_$_ProductFromJson(Map<String, dynamic> json) {
  return _$_Product(
    userId: json['userId'] as String?,
    productId: json['productId'] as String?,
    categoryId: json['categoryId'] as String?,
    productName: json['productName'] as String?,
    productMeasure:
        _$enumDecodeNullable(_$MeasureEnumMap, json['productMeasure']),
    productMinimumQuantity: json['productMinimumQuantity'] as int?,
    productPrice: (json['productPrice'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'productId': instance.productId,
      'categoryId': instance.categoryId,
      'productName': instance.productName,
      'productMeasure': _$MeasureEnumMap[instance.productMeasure],
      'productMinimumQuantity': instance.productMinimumQuantity,
      'productPrice': instance.productPrice,
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

const _$MeasureEnumMap = {
  Measure.KILOGRAM: 'KILOGRAM',
  Measure.FIVEHUNDREDGRAM: 'FIVEHUNDREDGRAM',
  Measure.TWOFIFTYGRAM: 'TWOFIFTYGRAM',
  Measure.HUNDREDGRAM: 'HUNDREDGRAM',
  Measure.LITRE: 'LITRE',
  Measure.FIVEHUNDREDML: 'FIVEHUNDREDML',
  Measure.TWOFIFTYML: 'TWOFIFTYML',
  Measure.HUNDREDML: 'HUNDREDML',
  Measure.UNIT: 'UNIT',
  Measure.DOZEN: 'DOZEN',
};
