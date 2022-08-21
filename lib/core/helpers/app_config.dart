class AppConfig {
  static AppConfig? _instance;

  AppConfig._internal(this.configData);

  factory AppConfig(Map<String, dynamic> configData) {
    _instance ??= AppConfig._internal(configData);
    return _instance ?? AppConfig(configData);
  }

  static AppConfig? get instance => _instance;

  static const String keyBlocObserver = 'blocObserver';

  static const String keyProjectId = 'projectId';

  final Map<String, dynamic> configData;

  bool get blocObserver => configData[keyBlocObserver];

  String get projectId => configData[keyProjectId];
}
