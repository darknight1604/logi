import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  final int? radius;
  final void Function()? onTap;
  final Widget child;
  final Color? color;

  const CircleButtonWidget({
    Key? key,
    required this.child,
    this.radius = 15,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: (radius ?? 0) * 2,
        height: (radius ?? 0) * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: child,
      ),
    );
  }
}
