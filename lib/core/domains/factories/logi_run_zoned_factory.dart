import 'package:logi/core/domains/base_services/logi_run_zoned.dart';
import 'package:logi/core/domains/services/default_run_zoned.dart';
import 'package:logi/core/domains/services/hydrated_run_zoned.dart';

class LogiRunZonedFactory {
  static LogiRunZoned getRunZoned({bool isDefault = false}) {
    if (isDefault) {
      return DefaultRunZoned();
    }
    return HydratedRunZoned();
  }
}
