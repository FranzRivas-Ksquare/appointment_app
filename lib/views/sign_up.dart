import 'package:flutter/material.dart';
import 'package:appointment/resources/string_manager.dart';
import 'package:appointment/resources/values_manager.dart';
import 'package:appointment/custom_widgets/textfield_custom.dart';
import 'package:appointment/database/user_db.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  static const String routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {

    var _formKey = GlobalKey<FormState>();

    TextEditingController _nameCtrl = TextEditingController();
    TextEditingController _emailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();
    TextEditingController _verifyPassCtrl = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Text(
                    AppString.signup, style: Theme.of(context).textTheme.headline1),
                CustomTextFormField(
                    controller: _nameCtrl, validate: false, isPassword: false),
                CustomTextFormField(
                    controller: _emailCtrl, validate: true, isPassword: false),
                CustomTextFormField(
                    controller: _passwordCtrl, validate: true, isPassword: true),
                CustomTextFormField(
                    controller: _verifyPassCtrl, validate: true, isPassword: true),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () {  // TODO: Improve verify password logic
                      if (!_formKey.currentState!.validate()) {
                        UserDB(dbName: 'user.db').create(
                            _emailCtrl.text,
                            _nameCtrl.text,
                            _passwordCtrl.text,
                            null
                        );
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    child: const Text(AppString.signup)
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text(AppString.alreadyAccount)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}