import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/notification_service.dart';
import '../custom_widgets/widgets_custom.dart';
import '../custom_widgets/textfield_custom.dart';
import '../custom_widgets/dialog_manager.dart';
import '../custom_widgets/hideKeyboard_custom.dart';
import '../custom_widgets/alert_manager.dart';
import '../resources/dateTime_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/values_manager.dart';
import '../models/appointment_model.dart';
import '../controller/user_controller.dart';
import '../controller/appointment_controller.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({super.key});
  static const String routeName = AppRoutes.newAppScreen;

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descrCtrl = TextEditingController();

  String dateNow = DateFormat('y/MM/d').format(DateTime.now());
  String timeNow = DateFormat('jm').format(DateTime.now());
  DatetimeManager dtmanager = DatetimeManager();
  TimeOfDay newTime = TimeOfDay.now();
  DateTime newDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final AppointmentCtrl appontmentCtrl =
        Provider.of<AppointmentCtrl>(context);
    final UserCtrl userCtrl = Provider.of<UserCtrl>(context);
    Future<void> _showDatePicker() async {
      newDate = await showDatePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorManager.darkGreen,
                      onPrimary: ColorManager.colorWhite,
                      onSurface: ColorManager.colorBlack,
                    ),
                  ),
                  child: child!,
                );
              },
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2027)) ??
          DateTime.now();

      setState(() {
        dateNow = DateFormat('y/MM/d').format(newDate);
      });
    }

    Future<void> _showTimePicker() async {
      newTime = await showTimePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorManager.lightGreen,
                      onPrimary: ColorManager.colorWhite,
                      onSurface: ColorManager.colorBlack,
                    ),
                  ),
                  child: child!,
                );
              },
              initialTime: TimeOfDay.now()) ??
          TimeOfDay.now();

      setState(() {
        timeNow = newTime.format(context).toString();
      });
    }

    return HideKeyboard(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: Container(),
            title: Text(AppString.newAppoint,
                style: Theme.of(context).textTheme.headline2),
          ),
          body: Column(
            children: <Widget>[
              CustomWidgets().containerColors(context, ColorManager.darkPink),
              Container(
                padding: const EdgeInsets.fromLTRB(AppPadding.p14,
                    AppPadding.p28, AppPadding.p24, AppPadding.p14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppString.title,
                      style: CustomTextStyle.appointmentTitles,
                    ),
                    CustomTitleField(
                      controller: _titleCtrl,
                      hintText: AppString.title,
                    ),
                    const SizedBox(
                      height: AppSize.s24,
                    ),
                    Text(AppString.appointment,
                        style: CustomTextStyle.appointmentTitles),
                    CustomAppointmentField(
                      controller: _descrCtrl,
                      hintText: AppString.appointment,
                    ),
                    const SizedBox(
                      height: AppSize.s40,
                    ),
                    Row(
                      children: <Widget>[
                        OutlinedButton(
                            onPressed: _showDatePicker,
                            child: const Text(AppString.date)),
                        const SizedBox(
                          width: AppSize.s28,
                        ),
                        Text(
                          dateNow,
                          style: CustomTextStyle.appointmentDate,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      children: <Widget>[
                        OutlinedButton(
                            onPressed: _showTimePicker,
                            child: const Text(AppString.time)),
                        const SizedBox(
                          width: AppSize.s28,
                        ),
                        Text(timeNow,
                            style: Theme.of(context).textTheme.bodyText2)
                      ],
                    ),
                    const SizedBox(height: AppSize.s52),
                    ElevatedButton(
                        onPressed: () async {
                          Appointment newApp = Appointment(
                              title: _titleCtrl.text,
                              date: DateTime(newDate.year, newDate.month,
                                  newDate.day, newTime.hour, newTime.minute, 0),
                              description: _descrCtrl.text,
                              author: userCtrl.getCurrentUser.email);
                          bool validate = appontmentCtrl.availability(newApp);
                          if (!validate) {
                            AlertManager().displaySnackbarDateTime(context,
                                AppString.warning, AppString.alreadyDate);
                          } else if (await appontmentCtrl.createAppointments(
                              context, newApp)) {
                            NotificationService.pushSchedule(newApp);

                            DialogManager().sucessDialog(
                                context,
                                AppString.newAppoint,
                                AppRoutes.homeScreen,
                                AppString.home);
                            String dtSTring =
                                dtmanager.dateTimeParse(dateNow, timeNow);
                          }
                        },
                        child: const Text(AppString.newAppoint)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
