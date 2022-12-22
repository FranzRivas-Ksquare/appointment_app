import 'package:appointment/resources/color_manager.dart';
import 'package:appointment/resources/routes_manager.dart';
import 'package:appointment/resources/string_manager.dart';
import 'package:appointment/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'button_custom.dart';

class DialogManager {
  appointmentDialog(
      context, int id, String title, String descr, String date, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(AppPadding.p14),
          title: SizedBox(
            height: AppSize.s180,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  child: CustomButton().closeIconButton(context),
                ),
                Flexible(child: Text(title)),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Flexible(
                    child: Text(descr,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center)),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(AppPadding.p14),
          content: SizedBox(
            height: AppSize.s80,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text('${AppString.date}: '),
                    Text(date)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('${AppString.time}: ',
                        style: Theme.of(context).textTheme.bodyText2),
                    Text(time, style: Theme.of(context).textTheme.bodyText2)
                  ],
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.all(AppPadding.p14),
          actions: [
            TextButton(
              style:
                  TextButton.styleFrom(foregroundColor: ColorManager.darkGreen),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.updateAppScreen, arguments: {
                  'id': id,
                });
              },
              child: const Text(AppString.updateAppoint),
            ),
          ],
        );
      },
    );
  }

  sucessDialog(context, String title, String route, String textButton) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              padding: const EdgeInsets.all(AppPadding.p14),
              width: MediaQuery.of(context).size.width,
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, route);
                    },
                    child: Text(textButton)),
              )
            ],
            actionsPadding: const EdgeInsets.fromLTRB(
                AppPadding.p14, AppPadding.p8, AppPadding.p14, AppPadding.p28),
          );
        });
  }
}
