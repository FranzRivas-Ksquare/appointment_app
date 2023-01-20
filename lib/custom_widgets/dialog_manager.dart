import 'package:flutter/material.dart';
import '../controller/notification_service.dart';
import 'button_custom.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../models/appointment_model.dart';
import '../controller/dateTimeFormat.dart';
import '../controller/appointment_controller.dart';

class DialogManager {
  appointmentDialog(
      context, Appointment appointment, AppointmentCtrl appointmentCtrl) {
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
                Flexible(child: Text(appointment.title)),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Flexible(
                    child: Text(appointment.description,
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
                    Text(DateTimeFormat().getDate(appointment.getDate))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('${AppString.time}: ',
                        style: Theme.of(context).textTheme.bodyText2),
                    Text(DateTimeFormat().getTime(appointment.getTime),
                        style: Theme.of(context).textTheme.bodyText2)
                  ],
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.all(AppPadding.p14),
          actions: [
            IconButton(
                onPressed: () {
                  appointmentCtrl.deleteAppointments(context, appointment.id);
                  NotificationService.deleteNotification(appointment);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete)),
            TextButton(
              style:
                  TextButton.styleFrom(foregroundColor: ColorManager.darkGreen),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.updateAppScreen,
                    arguments: {
                      'appointment': appointment,
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
