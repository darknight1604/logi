import 'package:flutter/material.dart';
import 'package:logi/core/helpers/style_manager.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CaroScreen extends StatefulWidget {
  const CaroScreen({Key? key}) : super(key: key);

  @override
  State<CaroScreen> createState() => _CaroScreenState();
}

class _CaroScreenState extends State<CaroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('Welcome to Caro'),
          ),
          ElevatedButton(
            style: ButtonStyleManager.common,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              LocaleKeys.commonBack.tr(),
              style: TextStyleManager.normalText,
            ),
          ),
        ],
      ),
    );
  }
}
