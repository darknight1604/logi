import 'package:equatable/equatable.dart';
import 'package:logi/features/home/domains/enums/game_enum.dart';

class Game extends Equatable {
  final GameEnum? gameEnum;
  final bool? selected;

  const Game({
    this.gameEnum,
    this.selected,
  });

  @override
  List<Object?> get props => [
        gameEnum,
        selected,
      ];
}
