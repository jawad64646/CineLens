// core/navigation/navigation.dart

import 'package:flutter/material.dart';

class Navigation {
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
