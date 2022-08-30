import 'package:freezed_annotation/freezed_annotation.dart';

part 'caro_position.freezed.dart';
part 'caro_position.g.dart';

@freezed
class CaroPosition with _$CaroPosition {
  const CaroPosition._();
  const factory CaroPosition({
    String? userId,
    String? nickname,
    String? roomId,
    // x
    int? column,
    // y
    int? row,
  }) = _CaroPosition;

  factory CaroPosition.fromJson(Map<String, Object?> json) =>
      _$CaroPositionFromJson(json);

  bool get isSelected => userId != null && userId?.isNotEmpty == true;

  bool isSelfSelected(String userId) {
    return isSelected && userId == this.userId;
  }
}
