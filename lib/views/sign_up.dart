import 'package:flutter/material.dart';
import 'package:appointment/resources/string_manager.dart';
import 'package:appointment/resources/values_manager.dart';
import 'package:appointment/custom_widgets/textfield_custom.dart';
import 'package:appointment/database/user_db.dart';
import 'package:provider/provider.dart';
import '../controller/data_provider.dart';
import '../models/models.dart';
import '../custom_widgets/hideKeyboard_custom.dart';
import '../resources/routes_manager.dart';


class SignUp extends StatelessWidget {
  const SignUp({super.key});

  static const String routeName = AppRoutes.signUpScreen;

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var dbProvider = Provider.of<DataProvider>(context);
    TextEditingController _nameCtrl = TextEditingController();
    TextEditingController _emailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();
    TextEditingController _verifyPassCtrl = TextEditingController();
    
    return HideKeyboard(
      child: Scaffold(
        body: SafeArea(
          child: Form(
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
                      onPressed: () async {
                        // TODO: Improve verify password logic
                        if (!_formKey.currentState!.validate()) {
                         User tempUser = User(
                            email: _emailCtrl.text,
                            name: _nameCtrl.text,
                            password: _passwordCtrl.text,
                            avatar: "avatar.jpg");
                         bool validate = await dbProvider.signUpUser(tempUser);
                         if (validate) {
                           Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                        } else {
                          print("No user");
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
      ),
    );
  }
}
