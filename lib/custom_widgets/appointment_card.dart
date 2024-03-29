import 'package:flutter/material.dart';
import 'package:appointment/resources/color_manager.dart';
import 'package:appointment/resources/values_manager.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/dialog_manager.dart';
import '../controller/appointment_controller.dart';
import '../models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  Appointment appointment;

  AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    var appointmentCtrl = Provider.of<AppointmentCtrl>(context);
    return GestureDetector(
      onTap: () {
        DialogManager().appointmentDialog(
            context, appointment, appointmentCtrl);
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
                      Text(appointment.title, style: Theme.of(context).textTheme.headline5),
                      const SizedBox(height: AppSize.s4),
                      Flexible(
                          child: Text(appointment.description,
                              style: Theme.of(context).textTheme.bodyText1))
                    ])),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.topRight,
              child: Text(appointment.getDate, style: Theme.of(context).textTheme.subtitle1),
            )
          ])),
    );
  }
}
