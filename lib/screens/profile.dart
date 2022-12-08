import 'package:appointment/resources/string.manager.dart';
import 'package:flutter/material.dart';

import '../resources/color.manager.dart';
import '../resources/values.manager.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  Text("Sherly Cabrera"),
                  Text("SherlyCabrera@demo.com"),
                  SizedBox(
                    height: AppSize.s120,
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: Text(AppString.updatePro)),
                  TextButton(onPressed: () {}, child: Text(AppString.logout))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
