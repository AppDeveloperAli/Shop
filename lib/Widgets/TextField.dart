import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextInputText extends StatefulWidget {
  String? labelText;
  TextEditingController controller;
  TextInputType? keyboardType;
  final bool allowOnlyNumericInput;

  MyTextInputText({
    super.key,
    required this.controller,
    this.labelText,
    this.keyboardType,
    this.allowOnlyNumericInput = false,
  });

  @override
  State<MyTextInputText> createState() => _MyTextInputTextState();
}

class _MyTextInputTextState extends State<MyTextInputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      inputFormatters: widget.allowOnlyNumericInput
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ]
          : null,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
