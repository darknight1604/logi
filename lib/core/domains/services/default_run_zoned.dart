import 'package:logi/core/domains/base_services/logi_run_zoned.dart';

class DefaultRunZoned extends LogiRunZoned {
  @override
  Future<R> runZoned<R>(R Function() body) async {
    return body();
  }
}
