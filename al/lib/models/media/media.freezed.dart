// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Media _$MediaFromJson(Map<String, dynamic> json) {
  return _Media.fromJson(json);
}

/// @nodoc
class _$MediaTearOff {
  const _$MediaTearOff();

  _Media call({String? entityId, String? mediaId, String? mediaUrl}) {
    return _Media(
      entityId: entityId,
      mediaId: mediaId,
      mediaUrl: mediaUrl,
    );
  }

  Media fromJson(Map<String, Object> json) {
    return Media.fromJson(json);
  }
}

/// @nodoc
const $Media = _$MediaTearOff();

/// @nodoc
mixin _$Media {
  String? get entityId => throw _privateConstructorUsedError;
  String? get mediaId => throw _privateConstructorUsedError;
  String? get mediaUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaCopyWith<Media> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaCopyWith<$Res> {
  factory $MediaCopyWith(Media value, $Res Function(Media) then) =
      _$MediaCopyWithImpl<$Res>;
  $Res call({String? entityId, String? mediaId, String? mediaUrl});
}

/// @nodoc
class _$MediaCopyWithImpl<$Res> implements $MediaCopyWith<$Res> {
  _$MediaCopyWithImpl(this._value, this._then);

  final Media _value;
  // ignore: unused_field
  final $Res Function(Media) _then;

  @override
  $Res call({
    Object? entityId = freezed,
    Object? mediaId = freezed,
    Object? mediaUrl = freezed,
  }) {
    return _then(_value.copyWith(
      entityId: entityId == freezed
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaId: mediaId == freezed
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaUrl: mediaUrl == freezed
          ? _value.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MediaCopyWith<$Res> implements $MediaCopyWith<$Res> {
  factory _$MediaCopyWith(_Media value, $Res Function(_Media) then) =
      __$MediaCopyWithImpl<$Res>;
  @override
  $Res call({String? entityId, String? mediaId, String? mediaUrl});
}

/// @nodoc
class __$MediaCopyWithImpl<$Res> extends _$MediaCopyWithImpl<$Res>
    implements _$MediaCopyWith<$Res> {
  __$MediaCopyWithImpl(_Media _value, $Res Function(_Media) _then)
      : super(_value, (v) => _then(v as _Media));

  @override
  _Media get _value => super._value as _Media;

  @override
  $Res call({
    Object? entityId = freezed,
    Object? mediaId = freezed,
    Object? mediaUrl = freezed,
  }) {
    return _then(_Media(
      entityId: entityId == freezed
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaId: mediaId == freezed
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaUrl: mediaUrl == freezed
          ? _value.mediaUrl
          : mediaUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Media implements _Media {
  const _$_Media({this.entityId, this.mediaId, this.mediaUrl});

  factory _$_Media.fromJson(Map<String, dynamic> json) =>
      _$_$_MediaFromJson(json);

  @override
  final String? entityId;
  @override
  final String? mediaId;
  @override
  final String? mediaUrl;

  @override
  String toString() {
    return 'Media(entityId: $entityId, mediaId: $mediaId, mediaUrl: $mediaUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Media &&
            (identical(other.entityId, entityId) ||
                const DeepCollectionEquality()
                    .equals(other.entityId, entityId)) &&
            (identical(other.mediaId, mediaId) ||
                const DeepCollectionEquality()
                    .equals(other.mediaId, mediaId)) &&
            (identical(other.mediaUrl, mediaUrl) ||
                const DeepCollectionEquality()
                    .equals(other.mediaUrl, mediaUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(entityId) ^
      const DeepCollectionEquality().hash(mediaId) ^
      const DeepCollectionEquality().hash(mediaUrl);

  @JsonKey(ignore: true)
  @override
  _$MediaCopyWith<_Media> get copyWith =>
      __$MediaCopyWithImpl<_Media>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MediaToJson(this);
  }
}

abstract class _Media implements Media {
  const factory _Media({String? entityId, String? mediaId, String? mediaUrl}) =
      _$_Media;

  factory _Media.fromJson(Map<String, dynamic> json) = _$_Media.fromJson;

  @override
  String? get entityId => throw _privateConstructorUsedError;
  @override
  String? get mediaId => throw _privateConstructorUsedError;
  @override
  String? get mediaUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MediaCopyWith<_Media> get copyWith => throw _privateConstructorUsedError;
}
