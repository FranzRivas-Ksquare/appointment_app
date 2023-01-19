import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/widgets_custom.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';
import '../controller/user_controller.dart';
import '../models/user_model.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static const String routeName = AppRoutes.profileScreen;

  @override
  Widget build(BuildContext context) {

    User? currentUser = context.watch<UserCtrl>().getCurrentUser;

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
              CustomWidgets().columnColors(context, ColorManager.lightPink),
              CustomWidgets()
                  .circleAvatarProfile(context, currentUser!.getAvatar())
            ],
          ),
          Container(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: Column(
              children: <Widget>[
                Text(currentUser.name!,
                    style: CustomTextStyle.profileName),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Text(currentUser.email,
                    style: Theme.of(context).textTheme.subtitle2),
                const SizedBox(
                  height: AppSize.s110,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.updateProfileScreen, arguments: {
                            'user': currentUser,
                      });
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
