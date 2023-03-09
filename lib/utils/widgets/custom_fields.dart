import 'package:dasboard/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.validationMessage,
    required this.controller,
    required this.message,
  }) : super(key: key);

  final String label;
  final String message;
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
          suffixIcon: Tooltip(
            message: message,
            child: Icon(
              Icons.info_outline_rounded,
              color: AppColors.orange,
            ),
          ),
          labelStyle: TextStyle(
            color: AppColors.orange,
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}
