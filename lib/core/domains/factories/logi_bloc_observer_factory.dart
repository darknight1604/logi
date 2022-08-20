import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/helpers/default_bloc_observer.dart';
import 'package:logi/core/helpers/logi_bloc_observer.dart';

class LogiBlocObserverFactory {
  static BlocObserver getBlocObserver({bool defaultObserver = false}) {
    if (defaultObserver) {
      return DefaultBlocObserver();
    }
    return LogiBlocObserver();
  }
}
