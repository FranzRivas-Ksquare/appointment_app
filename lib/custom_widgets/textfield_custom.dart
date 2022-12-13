import 'package:flutter/material.dart';
import 'package:appointment/resources/string_manager.dart';
import 'package:appointment/resources/values_manager.dart';

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

//Name Field Profile
class CustomNameField extends StatelessWidget {
  CustomNameField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.labelText,
    this.autofocus = false,
    this.isMulti = false,
    this.enabled = true,
    this.keyboardType = TextInputType.name,
  });

  final bool validator;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool autofocus;
  final bool isMulti;
  final bool enabled;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.requiredAdd;
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: AppString.name,
        labelText: AppString.name,
      ),
      autofocus: autofocus,
      minLines: isMulti ? 4 : 1,
      maxLines: isMulti ? null : 1,
      enabled: enabled,
      keyboardType: keyboardType,
    );
  }
}

//Password Field Profile
class CustomPasswordField extends StatelessWidget {
  CustomPasswordField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.labelText,
    required this.suffix,
    this.obsecure = false,
    this.autofocus = false,
    this.isMulti = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  final bool validator;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Widget suffix;
  final bool obsecure;
  final bool autofocus;
  final bool isMulti;
  final bool enabled;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.requiredAdd;
        }
        if (value.length < 8) {
          return AppString.requiredPass;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: AppString.password,
        labelText: AppString.password,
        suffixIcon: suffix,
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
