// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$_$_AppUserFromJson(Map<String, dynamic> json) {
  return _$_AppUser(
    userId: json['userId'] as String?,
    userPhone: json['userPhone'] as String?,
    userName: json['userName'] as String?,
    userPin: json['userPin'] as String?,
    userRole: _$enumDecodeNullable(_$UserRoleEnumMap, json['userRole']),
  );
}

Map<String, dynamic> _$_$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userPhone': instance.userPhone,
      'userName': instance.userName,
      'userPin': instance.userPin,
      'userRole': _$UserRoleEnumMap[instance.userRole],
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

const _$UserRoleEnumMap = {
  UserRole.LEADER: 'LEADER',
  UserRole.VENDOR: 'VENDOR',
};
