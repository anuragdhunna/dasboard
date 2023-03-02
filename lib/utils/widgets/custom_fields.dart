import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.validationMessage,
    required this.controller,
  }) : super(key: key);

  final String label;
  final String hintText;
  final Icon icon;
  final String? validationMessage;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        label: Text(label),
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}
