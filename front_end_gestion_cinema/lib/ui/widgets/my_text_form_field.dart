import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String my_hint;
  final IconData my_icon;
  final bool obscure_text_psw;
  final TextEditingController my_controller;
  final String? Function(String?)? my_validator;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const MyTextFormField(
      {super.key,
      required this.my_icon,
      required this.obscure_text_psw,
      required this.my_controller,
      required this.my_hint,
      required this.my_validator, this.focusNode, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure_text_psw,
      decoration: InputDecoration(
          hintText: my_hint,
          prefixIcon: Icon(my_icon),
          ),
      controller: my_controller,
      validator: my_validator,
      focusNode: focusNode,
      onChanged: onChanged,
    );
  }
}
