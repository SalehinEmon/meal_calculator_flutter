import 'package:flutter/material.dart';

class TextFieldComponents extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  String lebelText;
  TextInputType? keyboardType;
  String? Function(String?)? validator;

  TextFieldComponents({
    super.key,
    required this.controller,
    required this.hintText,
    required this.lebelText,
    this.keyboardType,
    this.validator,
  });

  @override
  State<TextFieldComponents> createState() => _TextFieldComponentsState();
}

class _TextFieldComponentsState extends State<TextFieldComponents> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          hintText: widget.hintText,
          labelText: widget.lebelText,
          fillColor: Colors.grey[300],
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
