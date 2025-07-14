import 'package:flutter/material.dart';

class Constant extends InheritedWidget {
  static Constant? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Constant>();

  const Constant({required Widget child, Key? key})
      : super(key: key, child: child);
  static const String statusSuccess = "success";

  @override
  bool updateShouldNotify(Constant oldWidget) => false;

  static const String strKey = "strKey";
  static const String intKey = "intKey";
  static const String boolKey = "boolKey";
  static const String listKey = "listKey";
}
