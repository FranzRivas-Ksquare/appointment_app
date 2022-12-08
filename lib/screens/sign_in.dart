import 'package:flutter/material.dart';
import 'package:appointment/resources/string.manager.dart';
import 'package:appointment/resources/values.manager.dart';
import 'package:appointment/widgets/textfield_custom.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {

    var _formKey = GlobalKey<FormState>();

    TextEditingController _mailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Text(
                    AppString.signin, style: Theme.of(context).textTheme.headline1),
                CustomTextFormField(
                    controller: _mailCtrl, validate: true, isPassword: false),
                CustomTextFormField(
                    controller: _passwordCtrl, validate: true, isPassword: true),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    child: const Text(AppString.signin)
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/sign_up');
                    },
                    child: const Text(AppString.dontAccount)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}