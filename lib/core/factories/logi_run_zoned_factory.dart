import 'package:logi/core/base_services/logi_run_zoned.dart';
import 'package:logi/core/services/default_run_zoned.dart';
import 'package:logi/core/services/hydrated_run_zoned.dart';

class LogiRunZonedFactory {
  static LogiRunZoned getRunZoned({bool isDefault = false}) {
    if (isDefault) {
      return DefaultRunZoned();
    }
    return HydratedRunZoned();
  }
}
