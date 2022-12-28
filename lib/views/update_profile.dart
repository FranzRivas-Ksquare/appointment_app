import 'dart:ui';
import 'dart:io';

import 'package:appointment/custom_widgets/widgets_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/alert_manager.dart';
import '../custom_widgets/hideKeyboard_custom.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../custom_widgets/textfield_custom.dart';
import '../models/models.dart';
import '../controller/data_provider.dart';
import '../controller/imagePicker.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({
    super.key,
  });
  static const String routeName = AppRoutes.updateProfileScreen;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  bool passwordVisible = true; //obsecure

  String _imagePickerPath = '';
  _loadImageFromCamera(source) async {
    _imagePickerPath =
        await ImagePickerService().uploadImageCamera(source: source);
    setState(() {});
  }

  _loadImageFromGallery(source) async {
    _imagePickerPath =
        await ImagePickerService().uploadImageGallery(source: source);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var dataServices = Provider.of<DataProvider>(context);

    return HideKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            flexibleSpace: Container(),
            title: const Text(AppString.updatePro),
            backgroundColor: ColorManager.auxiliary),
        body: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                CustomWidgets().columnColors(context, ColorManager.auxiliary),
                GestureDetector(
                  onTap: () async {
                    await AlertManager().displaySnackbarPicker(
                      context,
                      OutlinedButton(
                          onPressed: () {
                            _loadImageFromGallery(AppString.gallery);
                          },
                          child: const Text(AppString.gallery)),
                      OutlinedButton(
                          onPressed: () {
                            _loadImageFromCamera(AppString.camera);
                          },
                          child: const Text(AppString.camera)),
                    );
                  },
                  child: CircleAvatar(
                      radius: AppSize.s84,
                      backgroundColor: ColorManager.backgroundColor,
                      child: _imagePickerPath.isNotEmpty
                          ? FutureBuilder(
                              future: Future.delayed(const Duration(
                                  milliseconds: DurationConstant.d3000)),
                              builder: (context, asyncSnapshot) =>
                                  asyncSnapshot.connectionState ==
                                          ConnectionState.done
                                      ? CustomWidgets().containerAvatarProfile(
                                          context, _imagePickerPath)
                                      : const CircularProgressIndicator(
                                          strokeWidth: AppSize.s8),
                            )
                          : CustomWidgets().circleAvatarProfile(context,
                              dataServices.getCurrentUser.getAvatar())),
                ),
              ],
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.fromLTRB(AppPadding.p16,
                    AppPadding.p24, AppPadding.p16, AppPadding.p16),
                child: Column(
                  children: <Widget>[
                    CustomNameField(
                      controller: _nameCtrl,
                      validator: true,
                      hintText: AppString.name,
                      labelText: AppString.name,
                    ),
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                    CustomPasswordField(
                      controller: _passwordCtrl,
                      obsecure: passwordVisible,
                      validator: true,
                      hintText: AppString.password,
                      labelText: AppString.password,
                      suffix: IconButton(
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
                    const SizedBox(
                      height: AppSize.s60,
                    ),
                    //
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            User updateUser = User(
                              name: _nameCtrl.text,
                              email: dataServices.getCurrentUser.email,
                              password: _passwordCtrl.text,
                              avatar: _imagePickerPath,
                            );

                            dataServices.updateUser(updateUser);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(AppString.updatePro)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
