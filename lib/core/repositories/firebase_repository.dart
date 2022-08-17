import 'package:logi/core/base_services/logi_service.dart';
import 'package:logi/core/helpers/logi_service_helper.dart';

class FirebaseRepository {
  static Future<void> initialFirebase() async {
    LogiService logiService = LogiServiceHelper.getService();
    await logiService.initService();
  }
}
