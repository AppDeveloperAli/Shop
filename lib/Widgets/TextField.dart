import 'package:flutter/material.dart';

class MyTextInputText extends StatefulWidget {
  String? labelText;
  TextEditingController controller;
  TextInputType? keyboardType;

  MyTextInputText(
      {super.key, required this.controller, this.labelText, this.keyboardType});

  @override
  State<MyTextInputText> createState() => _MyTextInputTextState();
}

class _MyTextInputTextState extends State<MyTextInputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
