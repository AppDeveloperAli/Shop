import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppComponents {
  static goToPage({required BuildContext context, required Widget navigateTo}) {
    return Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => navigateTo,
      ),
    );
  }
}
