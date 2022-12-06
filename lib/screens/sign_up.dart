import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            Text("Sign Up"),
            TextField(),
            TextField(),
            TextField(),
            TextField(),
            Expanded(child: SizedBox()),
            ElevatedButton(
                onPressed: () {},
                child: Text('Sign Up')
            ),
            TextButton(
                onPressed: () {},
                child: Text('Already have an account?')
            )
          ],
        )
    );
  }
}