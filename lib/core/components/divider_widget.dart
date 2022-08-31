import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final Color? color;
  final double? height;

  const DividerWidget({
    Key? key,
    this.color = Colors.grey,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: height,
    );
  }
}
