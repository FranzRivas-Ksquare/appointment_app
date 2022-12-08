import 'package:flutter/material.dart';

import '../resources/color.manager.dart';
import '../resources/string.manager.dart';
import '../resources/values.manager.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});
  static const String routeName = '/update_profile';

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(AppPadding.p14),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: AppString.name, hintText: AppString.name),
                  ),
                  SizedBox(
                    height: AppSize.s16,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: AppString.password,
                        hintText: AppString.password),
                  ),
                  SizedBox(
                    height: AppSize.s52,
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: Text(AppString.updatePro)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
