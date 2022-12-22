import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';
import '../controller/data_provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static const String routeName = AppRoutes.profileScreen;

  @override
  Widget build(BuildContext context) {
    var dataServices = Provider.of<DataProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(),
        title: const Text(AppString.profile),
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
                  const SizedBox(
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
                  backgroundImage: FileImage(dataServices.getAvatar),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: Column(
              children: <Widget>[
                Text(dataServices.getCurrentUser.name,
                    style: CustomTextStyle.profileName),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Text(dataServices.getCurrentUser.email,
                    style: Theme.of(context).textTheme.subtitle2),
                const SizedBox(
                  height: AppSize.s110,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.updateProfileScreen);
                    },
                    child: const Text(AppString.updatePro)),
                const SizedBox(
                  height: AppSize.s20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.signInScreen);
                    },
                    child: const Text(AppString.logout))
              ],
            ),
          )
        ],
      ),
    );
  }
}
