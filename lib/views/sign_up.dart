import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../resources/routes_manager.dart';
import '../custom_widgets/textfield_custom.dart';
import '../custom_widgets/hideKeyboard_custom.dart';
import '../custom_widgets/alert_manager.dart';
import '../controller/data_provider.dart';
import '../models/models.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  static const String routeName = AppRoutes.signUpScreen;

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var dataServices = Provider.of<DataProvider>(context);
    TextEditingController _nameCtrl = TextEditingController();
    TextEditingController _emailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();
    TextEditingController _verifyPassCtrl = TextEditingController();

    bool emailValid;

    return HideKeyboard(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Text(AppString.signup,
                    style: Theme.of(context).textTheme.headline1),
                CustomTextFormField(
                  controller: _nameCtrl,
                  validate: false,
                  isPassword: false,
                  labelText: AppString.name,
                  hintText: AppString.name,
                ),
                CustomTextFormField(
                  controller: _emailCtrl,
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
                CustomTextFormField(
                  controller: _verifyPassCtrl,
                  validate: true,
                  isPassword: true,
                  labelText: AppString.confirmPass,
                  hintText: AppString.confirmPass,
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () {
                      emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailCtrl.text);
                      if (!emailValid) {
                        AlertManager().errorMessage();
                        _emailCtrl.text = '';
                      }
                      if (_formKey.currentState!.validate()) {
                        if (_passwordCtrl.text != _verifyPassCtrl.text) {
                          AlertManager().displaySnackbarSignUp(
                              context, AppString.error, AppString.noMatch);
                        } else {
                          User tempUser = User(
                              email: _emailCtrl.text,
                              name: _nameCtrl.text,
                              password: _passwordCtrl.text,
                              avatar: "avatar.jpg");
                          dataServices.signUpUser(tempUser);
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.homeScreen);
                        }
                      }
                    },
                    child: const Text(AppString.signup)),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.signInScreen);
                    },
                    child: const Text(AppString.alreadyAccount))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
