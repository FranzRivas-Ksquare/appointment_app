import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  static const String routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text("Sign In"),
          TextField(),
          TextField(),
          Expanded(child: SizedBox()),
          ElevatedButton(
              onPressed: () {},
              child: Text('Sign In')
          ),
          TextButton(
              onPressed: () {},
              child: Text('Don\'t have any account?')
          )
        ],
      ),
    );
  }
}