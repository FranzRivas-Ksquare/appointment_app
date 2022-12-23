import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../resources/routes_manager.dart';
import '../custom_widgets/textfield_custom.dart';
import '../custom_widgets/hideKeyboard_custom.dart';
import '../custom_widgets/alert_manager.dart';
import '../controller/data_provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  static const String routeName = AppRoutes.signInScreen;

  @override
  Widget build(BuildContext context) {
    var dataServices = Provider.of<DataProvider>(context);
    var _formKey = GlobalKey<FormState>();

    TextEditingController _emailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();

    return HideKeyboard(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Text(AppString.signin,
                    style: Theme.of(context).textTheme.headline1),
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
                const Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool validate = await dataServices.signInUser(
                            _emailCtrl.text, _passwordCtrl.text);
                        if (validate) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.homeScreen);
                          print(dataServices.getAvatar);
                        } else {
                          // TODO: Fix singInUser service before continue!!!
                          AlertManager().displaySnackbarLogIn(
                              context, AppString.message, AppString.noUser);
                        }
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
    );
  }
}
