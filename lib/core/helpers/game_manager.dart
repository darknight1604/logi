import 'package:logi/features/home/domains/enums/game_enum.dart';
import 'package:logi/features/home/domains/models/game.dart';

class GameManager {
  static List<Game> listGameAvailable() {
    return const [
      Game(
        gameEnum: GameEnum.caro,
      ),
      Game(
        gameEnum: GameEnum.threeCard,
      )
    ];
  }
}
