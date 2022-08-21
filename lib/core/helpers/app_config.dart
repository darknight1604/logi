class AppConfig {
  static AppConfig? _instance;

  AppConfig._internal(this.configData);

  factory AppConfig(Map<String, dynamic> configData) {
    _instance ??= AppConfig._internal(configData);
    return _instance ?? AppConfig(configData);
  }

  AppConfig? get instance => _instance;

  static const String keyBlocObserver = 'blocObserver';

  final Map<String, dynamic> configData;

  bool get blocObserver => configData[keyBlocObserver];
}
