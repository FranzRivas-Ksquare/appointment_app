import 'package:flutter/material.dart';

class NewAppointment extends StatelessWidget {
  const NewAppointment({super.key});
  static var colorB = Colors.redAccent.shade400;
  static const String routeName = '/new_appointment';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorB,
          title: Text('New Appointment'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: colorB,
                      height: 160,
                      width: double.infinity,
                    ),
                  ],
                ),
              ],
            ),
            Text('Title'),
            TextField(),
            Text('Appointment'),
            TextField(),
            Row(
              children: <Widget>[
                ElevatedButton(onPressed: () {}, child: Text('Date')),
                Spacer(),
                Text('12/05/22')
              ],
            ),
            Row(
              children: <Widget>[
                ElevatedButton(onPressed: () {}, child: Text('Time')),
                Spacer(),
                Text('08:30 A.M.')
              ],
            ),
            Expanded(child: SizedBox()),
            ElevatedButton(onPressed: () {}, child: Text('New Appointment')),
          ],
        ),
      ),
    );
  }
}
