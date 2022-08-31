import 'package:flutter/material.dart';

class PaddingWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const PaddingWrapper({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 15.0, right: 15.0),
      child: child,
    );
  }
}
