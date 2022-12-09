import 'package:flutter/material.dart';

import '../resources/color.manager.dart';
import '../resources/string.manager.dart';
import '../resources/values.manager.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});
  static const String routeName = '/update_profile';

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    _nameCtrl.text = 'Sherly Cabrera';
    _passwordCtrl.text = 'SherlyCabrera01';

    void initState() {
      super.initState();
      passwordVisible = true;
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            flexibleSpace: Container(),
            title: Text(AppString.updatePro),
            backgroundColor: ColorManager.auxiliary),
        body: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: ColorManager.auxiliary,
                      height: AppSize.s110,
                      width: double.infinity,
                    ),
                    Container(
                      height: AppSize.s60,
                      width: double.infinity,
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: AppSize.s84,
                  backgroundColor: ColorManager.backgroundColor,
                  child: CircleAvatar(
                    radius: AppSize.s80,
                    backgroundImage:
                        NetworkImage('https://picsum.photos/200/300'),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(AppPadding.p16, AppPadding.p24,
                  AppPadding.p16, AppPadding.p16),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nameCtrl,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: AppString.name,
                      labelText: AppString.name,
                      //helperText: AppString.requiredAdd
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s16,
                  ),
                  TextField(
                    controller: _passwordCtrl,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      hintText: AppString.password,
                      labelText: AppString.password,
                      //helperText: AppString.requiredAdd,
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: AppSize.s60,
                  ),
                  //
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Text(AppString.updatePro)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
