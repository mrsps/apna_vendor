import 'package:freezed_annotation/freezed_annotation.dart';
part 'appuser.freezed.dart';
part 'appuser.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    @required String? userId,
    @required String? userPhone,
    @required String? userName,
    @required String? userPin,
    @required UserRole? userRole,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}

enum UserRole {
  @JsonValue("LEADER")
  LEADER,
  @JsonValue("VENDOR")
  VENDOR
}
