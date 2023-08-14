import 'package:flutter/material.dart';
import 'package:shoply_admin/constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      this.isSecure = false,
      this.iconShape,
      this.textInputAction,
      this.textInputType,
      this.onSaved,
      this.controller,
      this.isPasswordFeild = false});

  final String hintText;
  bool? isSecure;
  final bool? isPasswordFeild;
  final IconData? iconShape;
  final TextEditingController? controller;

  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? Function(String?)? onSaved;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      height: height * 0.075,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: kSecondaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              cursorColor: kPrimaryColor,
              controller: widget.controller,
              keyboardType: widget.textInputType,
              textInputAction: widget.textInputAction,
              onSaved: widget.onSaved,
              validator: (value) {
                switch (widget.hintText) {
                  case 'email':
                    if (value!.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('shoplyleader')) {
                      return 'please enter a valid email';
                    } else {
                      return null;
                    }
                  case 'password':
                    if (value!.isEmpty) {
                      return 'please enter a valid password';
                    } else if (value.length < 6) {
                      return 'password must be more than 6 digits';
                    } else {
                      return null;
                    }

                  default:
                    if (value!.isEmpty) {
                      return 'this field can\'t be empty';
                    } else {
                      return null;
                    }
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  icon: Icon(
                    widget.iconShape,
                    color: Colors.black87,
                  )),
              obscureText: widget.isSecure!,
            ),
          ),
          if (widget.isPasswordFeild!)
            IconButton(
                onPressed: () {
                  setState(() {
                    widget.isSecure = !widget.isSecure!;
                  });
                },
                icon: const Icon(Icons.remove_red_eye))
        ],
      ),
    );
  }
}
