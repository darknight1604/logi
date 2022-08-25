import 'package:flutter/material.dart';
import 'package:logi/core/helpers/text_style_manager.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          LocaleKeys.errorMessageNotFound.tr(),
          style: TextStyleManager.largeText,
        ),
      ),
    );
  }
}
