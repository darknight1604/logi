import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logi/gen/assets.gen.dart';

class ConfigReader {
  static Future<Map<String, dynamic>> getConfigJson() async {
    String strJson = await rootBundle.loadString(Assets.configs.config);
    return jsonDecode(strJson);
  }
}
