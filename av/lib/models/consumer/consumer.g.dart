// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConsumerAddress _$_$_ConsumerAddressFromJson(Map<String, dynamic> json) {
  return _$_ConsumerAddress(
    consumerId: json['consumerId'] as String?,
    consumerPhone: json['consumerPhone'] as String?,
    consumerName: json['consumerName'] as String?,
    consumerHouse: json['consumerHouse'] as String?,
    consumerApartment: json['consumerApartment'] as String?,
  );
}

Map<String, dynamic> _$_$_ConsumerAddressToJson(_$_ConsumerAddress instance) =>
    <String, dynamic>{
      'consumerId': instance.consumerId,
      'consumerPhone': instance.consumerPhone,
      'consumerName': instance.consumerName,
      'consumerHouse': instance.consumerHouse,
      'consumerApartment': instance.consumerApartment,
    };
