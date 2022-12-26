import 'package:appointment/custom_widgets/widgets_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/dialog_manager.dart';
import '../custom_widgets/hideKeyboard_custom.dart';
import '../custom_widgets/textfield_custom.dart';
import '../custom_widgets/alert_manager.dart';
import '../resources/color_manager.dart';
import '../resources/dateTime_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/values_manager.dart';
import '../models/models.dart';
import '../controller/data_provider.dart';

class UpdateAppointment extends StatefulWidget {
  const UpdateAppointment({super.key});

  static const String routeName = AppRoutes.updateAppScreen;

  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  final TextEditingController _titleCtrl =
      TextEditingController(text: 'init text test');
  final TextEditingController _descrCtrl =
      TextEditingController(text: 'init text test');
  DatetimeManager dtmanager = DatetimeManager();
  String dateNow = DateFormat('yMd').format(DateTime.now());
  String timeNow = DateFormat('jm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var dataServices = Provider.of<DataProvider>(context);

    Future<void> _showDatePicker() async {
      DateTime? newDate = await showDatePicker(
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
          lastDate: DateTime(2027));

      if (newDate == null) return;
      setState(() {
        dateNow = DateFormat('yMd').format(newDate);
      });
    }

    Future<void> _showTimePicker() async {
      TimeOfDay? newTime = await showTimePicker(
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
          initialTime: TimeOfDay.now());

      if (newTime == null) return;
      setState(() {
        timeNow = newTime.format(context).toString();
      });
    }

    return HideKeyboard(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: ColorManager.lightGreen,
            title: Text(AppString.updateAppoint,
                style: Theme.of(context).textTheme.headline2),
          ),
          body: Column(
            children: <Widget>[
              CustomWidgets().containerColors(context, ColorManager.lightGreen),
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
                          Appointment updateAppointment = Appointment(
                            id: args['id'],
                            title: _titleCtrl.text,
                            description: _descrCtrl.text,
                            date: dtmanager.dateTimeParse(dateNow, timeNow),
                            author: dataServices.getCurrentUser.email,
                          );
                          if(!dataServices.availability(updateAppointment)) {
                            AlertManager().displaySnackbarDateTime(
                                context, AppString.warning, AppString.alreadyDate);
                          }
                          if (await dataServices
                              .updateAppointments(updateAppointment)) {
                            DialogManager().sucessDialog(
                                context,
                                AppString.upSuccess,
                                AppRoutes.homeScreen,
                                AppString.home);
                          }
                          print(dateNow);
                          print(timeNow);
                          //print()
                        },
                        child: const Text(AppString.updateAppoint)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
