import 'package:freezed_annotation/freezed_annotation.dart';
part 'media.freezed.dart';
part 'media.g.dart';

@freezed
abstract class Media with _$Media {
  const factory Media({
    @required String? entityId,
    @required String? mediaId,
    @required String? mediaUrl// enum **
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}