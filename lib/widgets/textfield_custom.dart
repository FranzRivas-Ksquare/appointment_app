import 'package:flutter/material.dart';
import 'package:appointment/resources/string.manager.dart';
import 'package:appointment/resources/values.manager.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.validate,
    required this.isPassword,
  });

  TextEditingController controller;
  bool validate;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          AppMargin.m16, AppMargin.m8, AppMargin.m16, AppMargin.m8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: (value) {
          if (value!.isEmpty) return AppString.requiredAdd;
          return null;
        },
      ),
    );
  }
}
