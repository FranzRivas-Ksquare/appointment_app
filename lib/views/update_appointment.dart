import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/string_manager.dart';
import '../resources/theme.dart';
import '../resources/values_manager.dart';

class UpdateAppointment extends StatefulWidget {
  const UpdateAppointment({super.key});
  static const String routeName = '/update_appointment';

  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descrCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2027)
      );
    }

    void _showTimePicker() {
      showTimePicker(
          context: context,
          initialTime: TimeOfDay.now()
      );
    }

    _titleCtrl.text = 'Flutter Exam';
    _descrCtrl.text = 'Flutter class in ITK. Exam this Monday! Wake upr early!';

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: ColorManager.lightGreen,
            title: Text(AppString.updateAppoint, style: Theme.of(context).textTheme.headline2),
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: ColorManager.lightGreen,
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
                          '12/05/22',
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
                        Text('02:00 P.M.',
                            style: CustomTextStyle.appointmentTime)
                      ],
                    ),
                    SizedBox(height: AppSize.s52),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Text(AppString.updateAppoint)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}