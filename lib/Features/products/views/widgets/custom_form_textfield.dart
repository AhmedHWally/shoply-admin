import 'package:flutter/material.dart';

class CustomFormTextFeild extends StatelessWidget {
  const CustomFormTextFeild(
      {super.key,
      required this.hintText,
      this.maxLines = 1,
      required this.onSaved,
      this.textInputType,
      this.textInputAction,
      required this.initalValue});

  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? onSaved;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? initalValue;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: height * 0.1,
        width: width * 0.8,
        child: TextFormField(
            initialValue: initalValue,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            validator: (value) {
              if (value == null || value.trim() == "") {
                return 'can\'t upload with empty value';
              } else {
                return null;
              }
            },
            maxLines: maxLines,
            onSaved: onSaved,
            decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)))));
  }
}
