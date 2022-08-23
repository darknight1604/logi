import 'package:logi/core/base_services/logi_base_service.dart';
import 'package:logi/core/factories/logi_service_factory.dart';

class LogiService {
  static Future<void> initialFirebase() async {
    LogiBaseService logiService = LogiServiceFactory.getService();
    await logiService.initService();
  }
}
