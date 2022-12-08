import 'package:flutter/material.dart';

class UpdateAppointment extends StatelessWidget {
  const UpdateAppointment({super.key});
  static var colorB = Colors.green.shade300;
  static const String routeName = '/update_appointment';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorB,
          title: Text('Update Appointment'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: colorB,
                      height: 160,
                      width: double.infinity,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Text('Title'),
            TextField(),
            Text('Appointment'),
            TextField(),
            Expanded(child: SizedBox()),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Date')),
                Spacer(),
                Text('12/05/22')
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Time')),
                Spacer(),
                Text('08:30 A.M.')
              ],
            ),
            Expanded(child: SizedBox()),
            ElevatedButton(onPressed: () {}, child: Text('Update Appointment')),
          ],
        ),
      ),
    );
  }
}
