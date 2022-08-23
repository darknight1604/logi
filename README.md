# logi

A new Flutter project.

## Getting Started

```
flutter pub get

flutter packages pub run build_runner build

flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart -O lib/gen
```

### Build Windows app

```
flutter pub get && flutter packages pub run build_runner build && flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart -O lib/gen flutter run -d windows
```

### Build MacOS app

```
flutter pub get && flutter packages pub run build_runner build && flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart -O lib/gen flutter run -d macos
```