import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logi/features/home/domains/enums/game_enum.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const Room._();
  const factory Room({
    String? id,
    GameEnum? gameEnum,
    int? maxSize,
    String? name,
  }) = _Room;

  factory Room.fromJson(Map<String, Object?> json) => _$RoomFromJson(json);
}
