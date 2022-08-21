import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logi/core/helpers/text_style_manager.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String value)? onSubmitted;
  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.controller,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyleManager.normalText,
      ),
      onSubmitted: onSubmitted,
    );
  }
}
