import 'package:flutter/material.dart';
import 'package:appointment/resources/string_manager.dart';
import 'package:appointment/resources/values_manager.dart';
import 'package:appointment/custom_widgets/textfield_custom.dart';

import '../custom_widgets/hideKeyboard_custom.dart';
import '../resources/routes_manager.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  static const String routeName = AppRoutes.signInScreen;

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

    TextEditingController _mailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();

    return HideKeyboard(
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  Text(AppString.signin,
                      style: Theme.of(context).textTheme.headline1),
                  CustomTextFormField(
                    controller: _mailCtrl,
                    validate: true,
                    isPassword: false,
                    labelText: AppString.email,
                    hintText: AppString.email,
                  ),
                  CustomTextFormField(
                    controller: _passwordCtrl,
                    validate: true,
                    isPassword: true,
                    labelText: AppString.password,
                    hintText: AppString.password,
                  ),
                  const Expanded(child: SizedBox()),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.homeScreen);
                        }
                      },
                      child: const Text(AppString.signin)),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.signUpScreen);
                      },
                      child: const Text(AppString.dontAccount))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
