import 'package:flutter/material.dart';
import 'package:appointment/resources/string_manager.dart';
import 'package:appointment/resources/values_manager.dart';

import '../resources/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.validate,
    required this.isPassword,
    required this.labelText,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool validate;
  final bool isPassword;
  final String labelText;
  final String hintText;

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
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
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
    this.isMulti = false,
    this.autofocus = false,
    this.enabled = true,
    this.keyboardType = TextInputType.name,
  });

  final bool validator;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool isMulti;
  final bool autofocus;
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
      minLines: isMulti ? 4 : 1,
      maxLines: isMulti ? null : 1,
      autofocus: autofocus,
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
    this.isMulti = false,
    this.autofocus = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  final bool validator;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Widget suffix;
  final bool obsecure;
  final bool isMulti;
  final bool autofocus;
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
        // if (value.length < 8) {
        //   return AppString.requiredPass;
        // }
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

class CustomTitleField extends StatelessWidget {
  CustomTitleField({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.enabled = true,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool autofocus;
  final bool enabled;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: false,
      enabled: true,
      keyboardType: TextInputType.text,
      style: (TextStyle(color: ColorManager.darkGreen)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ColorManager.darkPink),
      ),
    );
  }
}

class CustomAppointmentField extends StatelessWidget {
  CustomAppointmentField({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.enabled = true,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool autofocus;
  final bool enabled;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: false,
      enabled: true,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      style: (TextStyle(color: ColorManager.darkGreen)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ColorManager.darkPink),
      ),
    );
  }
}
