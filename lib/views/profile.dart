import 'package:appointment/resources/string_manager.dart';
import 'package:appointment/resources/theme.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          flexibleSpace: Container(),
          title: Text(AppString.profile),
          backgroundColor: ColorManager.lightPink,
        ),
        body: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: ColorManager.lightPink,
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
                  Text("Sherly Cabrera", style: CustomTextStyle.profileName),
                  SizedBox(
                    height: AppSize.s8,
                  ),
                  Text("SherlyCabrera@demo.com",
                      style: CustomTextStyle.profileEmail),
                  SizedBox(
                    height: AppSize.s110,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/update_profile');
                      },
                      child: Text(AppString.updatePro)),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Text(AppString.logout))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
