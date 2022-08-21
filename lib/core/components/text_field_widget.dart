import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logi/core/helpers/text_style_manager.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String value)? onSubmitted;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;

  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.controller,
    this.onSubmitted,
    this.labelStyle = TextStyleManager.smallText,
    this.labelText,
    this.hintStyle = TextStyleManager.normalText,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
      ),
      onSubmitted: onSubmitted,
    );
  }
}
