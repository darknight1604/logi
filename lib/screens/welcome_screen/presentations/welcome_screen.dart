import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fluent.Colors.grey[130],
      body: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              fluent.TextBox(
                placeholder: LocaleKeys.commonNickName.tr(),
              ),
              fluent.FilledButton(
                child: Text(LocaleKeys.commonSubmit.tr()),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
