import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum GameEnum {
  caro,
  threeCard,
  thirteenCard,
}

extension GameExtension on GameEnum {
  String getTitle() {
    switch (this) {
      case GameEnum.caro:
        return LocaleKeys.gameCaro.tr();
      case GameEnum.threeCard:
        return LocaleKeys.gameThreeCard.tr();
      default:
        return LocaleKeys.commonUnknown.tr();
    }
  }
}
