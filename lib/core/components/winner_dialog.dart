import 'package:flutter/material.dart';
import 'package:logi/core/components/divider_widget.dart';
import 'package:logi/core/components/sized_box_widget.dart';
import 'package:logi/core/helpers/style_manager.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class WinnerDialog extends StatelessWidget {
  final void Function() onConfirm;
  final String winnerNickname;

  const WinnerDialog({
    Key? key,
    required this.onConfirm,
    required this.winnerNickname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            LocaleKeys.commonCongratulation.tr(),
            style: TextStyleManager.largeText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const DividerWidget(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: LocaleKeys.caroScreenWinnerDescription.tr(),
                  style: TextStyleManager.normalText.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: winnerNickname,
                  style: TextStyleManager.normalText.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBoxWidget.h15,
          ElevatedButton(
            onPressed: () {
              onConfirm.call();
            },
            child: Text(
              LocaleKeys.commonSubmit.tr(),
              style: TextStyleManager.normalText,
            ),
          ),
        ],
      ),
    );
  }
}
