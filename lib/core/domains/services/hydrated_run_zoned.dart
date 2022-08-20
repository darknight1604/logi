import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:logi/core/domains/base_services/logi_run_zoned.dart';
import 'package:path_provider/path_provider.dart';

class HydratedRunZoned extends LogiRunZoned {
  @override
  Future<R> runZoned<R>(R Function() body) async {
    final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    );

    return HydratedBlocOverrides.runZoned(
      body,
      storage: storage,
    );
  }
}
