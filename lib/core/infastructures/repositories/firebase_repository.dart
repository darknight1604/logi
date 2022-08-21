import 'package:logi/core/domains/base_services/logi_service.dart';
import 'package:logi/core/domains/factories/logi_service_factory.dart';

class FirebaseRepository {
  static Future<void> initialFirebase() async {
    LogiService logiService = LogiServiceFactory.getService();
    await logiService.initService();
  }
}
