import 'package:flutter/material.dart';
import 'package:appointment/resources/color_manager.dart';
import 'package:appointment/resources/values_manager.dart';

import 'dialog_manager.dart';

class AppointmentCard extends StatelessWidget {
  String title;
  String due;
  String description;
  String time;
  String date;

  AppointmentCard({
    super.key,
    required this.title,
    required this.due,
    required this.description,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DialogManager()
            .appointmentDialog(context, title, description, date, time);
      },
      onDoubleTap: () {
        Navigator.pushNamed(context, "/update_appointment");
      },
      child: Container(
          height: AppSize.s100,
          margin: const EdgeInsets.all(AppMargin.m8),
          padding: const EdgeInsets.all(AppPadding.p8),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: ColorManager.auxiliary))),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(Icons.favorite,
                color: ColorManager.darkGreen, size: AppSize.s40),
            const SizedBox(width: AppSize.s12),
            SizedBox(
                width: AppSize.s180,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.headline5),
                      const SizedBox(height: AppSize.s4),
                      Flexible(
                          child: Text(description,
                              style: Theme.of(context).textTheme.bodyText1))
                    ])),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.topRight,
              child: Text(due, style: Theme.of(context).textTheme.subtitle1),
            )
          ])),
    );
  }
}
