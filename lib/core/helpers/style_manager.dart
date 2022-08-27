import 'package:flutter/material.dart';

class TextStyleManager {
  static const smallText = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
  );
  static const normalText = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
  );
  static const largeText = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );
  static const extraLargeText = TextStyle(
    fontSize: 18.0,
    color: Colors.black,
  );
}

class ButtonStyleManager {
  static ButtonStyle common = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Colors.white,
    ),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(color: Colors.grey),
    ),
  );
}
