import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/dialog_manager.dart';
import '../custom_widgets/hideKeyboard_custom.dart';
import '../custom_widgets/textfield_custom.dart';
import '../custom_widgets/alert_manager.dart';
import '../custom_widgets/widgets_custom.dart';
import '../resources/color_manager.dart';
import '../resources/dateTime_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/values_manager.dart';
import '../models/models.dart';
import '../controller/database_controller.dart';

class UpdateAppointment extends StatefulWidget {
  Appointment appointment;
  UpdateAppointment({super.key, required Appointment this.appointment});

  static const String routeName = AppRoutes.updateAppScreen;

  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descrCtrl = TextEditingController();
  final DatetimeManager dtmanager = DatetimeManager();

  String dateNow = '';
  String timeNow = '';
  int _id = 0;

  TimeOfDay newTime = TimeOfDay.now();
  DateTime newDate = DateTime.now();

  Future<void> _showDatePicker(dateTimeNow) async {
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
            initialDate: dateTimeNow,
            firstDate: DateTime(2022),
            lastDate: DateTime(2027)) ??
        dateTimeNow;

    setState(() {
      dateNow = DateFormat('y/MM/d').format(newDate);
    });
  }

  Future<void> _showTimePicker(dateTimeNow) async {
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
            initialTime: TimeOfDay.fromDateTime(dateTimeNow)) ??
        TimeOfDay.fromDateTime(dateTimeNow);

    setState(() {
      timeNow = newTime.format(context).toString();
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _titleCtrl.text = widget.appointment.title;
      _descrCtrl.text = widget.appointment.description;
      dateNow = DateFormat('y/MM/d').format(widget.appointment.date);
      timeNow = TimeOfDay.fromDateTime(widget.appointment.date).format(context);
      _id = widget.appointment.id;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descrCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dataServices = Provider.of<DatabaseCtrl>(context);
    DateTime appointmentDT = widget.appointment.date;

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
                            onPressed: () => _showDatePicker(appointmentDT),
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
                            onPressed: () => _showTimePicker(appointmentDT),
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
                            id: _id,
                            title: _titleCtrl.text,
                            description: _descrCtrl.text,
                            date: DateTime(newDate.year, newDate.month,
                                newDate.day, newTime.hour, newTime.minute, 0),
                            author: dataServices.getCurrentUser.email,
                          );
                          bool validate =
                              dataServices.availability(updateAppointment);
                          if (!validate) {
                            AlertManager().displaySnackbarDateTime(context,
                                AppString.warning, AppString.alreadyDate);
                          } else if (await dataServices
                              .updateAppointments(updateAppointment)) {
                            DialogManager().sucessDialog(
                                context,
                                AppString.upSuccess,
                                AppRoutes.homeScreen,
                                AppString.home);
                          }
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
