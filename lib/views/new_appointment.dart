import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../resources/color_manager.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/values_manager.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({super.key});
  static const String routeName = '/new_appointment';

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descrCtrl = TextEditingController();

  String dateNow = DateFormat('yMd').format(DateTime.now());
  String timeNow = DateFormat('jm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Future<void> _showDatePicker() async {
      DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2027));

      if (newDate == null) return;
      setState(() {
        dateNow = DateFormat('yMd').format(newDate);
      });
    }

    Future<void> _showTimePicker() async {
      TimeOfDay? newTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (newTime == null) return;
      setState(() {
        timeNow = newTime.format(context).toString();
      });
    }

    _titleCtrl.text = 'Flutter Exam';
    _descrCtrl.text = 'Flutter class in ITK. Exam this Monday! Wake upr early!';

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: Container(),
            title: Text(AppString.newAppoint,
                style: Theme.of(context).textTheme.headline2),
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: ColorManager.darkPink,
                height: AppSize.s110,
                width: double.infinity,
              ),
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
                    TextField(
                      controller: _titleCtrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: AppString.title,
                        //labelText: AppString.title,
                        //helperText: AppString.requiredAdd
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s24,
                    ),
                    Text(AppString.appointment,
                        style: CustomTextStyle.appointmentTitles),
                    TextField(
                      controller: _descrCtrl,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: AppString.descr,
                        //labelText: AppString.descr,
                        //helperText: AppString.requiredAdd
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    Row(
                      children: <Widget>[
                        OutlinedButton(
                            onPressed: _showDatePicker,
                            child: Text(AppString.date)),
                        SizedBox(
                          width: AppSize.s28,
                        ),
                        Text(
                          dateNow,
                          style: CustomTextStyle.appointmentDate,
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      children: <Widget>[
                        OutlinedButton(
                            onPressed: _showTimePicker,
                            child: Text(AppString.time)),
                        SizedBox(
                          width: AppSize.s28,
                        ),
                        Text(timeNow, style: CustomTextStyle.appointmentTime)
                      ],
                    ),
                    SizedBox(height: AppSize.s52),
                    ElevatedButton(
                        onPressed: () {
                          print(dateNow);
                          print(timeNow);
                        },
                        child: Text(AppString.newAppoint)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
