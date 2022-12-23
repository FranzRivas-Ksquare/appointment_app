import 'package:appointment/custom_widgets/widgets_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/data_provider.dart';
import '../custom_widgets/textfield_custom.dart';
import '../models/models.dart';
import '../custom_widgets/dialog_manager.dart';
import '../custom_widgets/hideKeyboard_custom.dart';

import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/values_manager.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({super.key});
  static const String routeName = AppRoutes.newAppScreen;

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descrCtrl = TextEditingController();

  // TODO: Create a DateTime type variable with dateNow and timeNow values
  String dateNow = DateFormat('y/M/d').format(DateTime.now());
  String timeNow = DateFormat('jm').format(DateTime.now());
  String dateToFormat = '';
  String timeToFormat = '';
  String dtTogether = '';

  @override
  Widget build(BuildContext context) {
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
        dateNow = DateFormat('y/M/d').format(newDate);
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

    void dateTimeParse() async {
      if (dateNow.isNotEmpty && timeNow.isNotEmpty) {
        dateToFormat = dateNow.replaceAll('/', '-');
        if (timeNow.contains('AM')) {
          double timeNumber = double.parse(timeNow
              .replaceAll('AM', '')
              .replaceAll('PM', '')
              .replaceAll(':', '.')
              .replaceAll(' ', ''));
          if (timeNumber >= 12.00) {
            timeNumber = timeNumber - 12.00;
            timeToFormat =
                '0${timeNumber.toStringAsFixed(2).replaceAll('.', ':')}:00.000000';
          } else if (timeNumber >= 1.00 && timeNumber <= 9.59) {
            timeToFormat =
                '0${timeNumber.toStringAsFixed(2).replaceAll('.', ':')}:00.000000';
          } else {
            timeToFormat =
                '${timeNow.replaceAll('AM', '').replaceAll('PM', '').replaceAll(' ', '')}:00.000000';
          }
        } else if (timeNow.contains('PM')) {
          double timeNumber = double.parse(timeNow
              .replaceAll('AM', '')
              .replaceAll('PM', '')
              .replaceAll(':', '.')
              .replaceAll(' ', ''));
          timeNumber = timeNumber + 12;
          timeToFormat =
              '${timeNumber.toStringAsFixed(2).replaceAll('.', ':')}:00.000000';
        }
        dtTogether = '$dateToFormat $timeToFormat';
      }
    }

    //_titleCtrl.text = 'Flutter Exam';
    //_descrCtrl.text = 'Flutter class in ITK. Exam this Monday! Wake upr early!';

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
                          dateTimeParse();
                          Appointment newApp = Appointment(
                              title: _titleCtrl.text,
                              date: '$dateNow $timeNow',
                              description: _descrCtrl.text,
                              author: dataServices.getCurrentUser!.email);
                          // TODO: Validate all appointments date in a loop to verify availability
                          if (await dataServices.createAppointments(newApp)) {
                            DialogManager().sucessDialog(
                                context,
                                AppString.newAppoint,
                                AppRoutes.homeScreen,
                                AppString.home);
                          }
                          print(dateNow);
                          print(timeNow);
                          print(dtTogether);
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
