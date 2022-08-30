import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logi/features/authentication/domains/models/user.dart';

part 'room_user.g.dart';

part 'room_user.freezed.dart';

@freezed
class RoomUser with _$RoomUser {
  // Added constructor. Must not have any parameter
  const RoomUser._();

  const factory RoomUser({
    String? roomId,
    String? userId,
    String? nickName,
    int? joinDate,
  }) = _RoomUser;

  factory RoomUser.fromJson(Map<String, Object?> json) =>
      _$RoomUserFromJson(json);

  User get user {
    return User(
      id: userId,
      nickname: nickName,
    );
  }
}
