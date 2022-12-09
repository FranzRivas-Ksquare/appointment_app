import 'package:appointment/models/testData.dart';
import 'package:appointment/resources/color.manager.dart';
import 'package:appointment/widgets/appsCard.dart';
import 'package:flutter/material.dart';

import '../resources/string.manager.dart';
import '../resources/values.manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const String routeName = '/home';

  static final textLines = Appointments();
  static final List buttons = [
    "All",
    "Today",
    "Tomorrow",
    "Past",
  ];
  static final String selected = buttons[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.appBarLightPink,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(AppString.welcome, style: TextStyle(color: Colors.black)),
          Text(AppString.hello,
              style:
                  TextStyle(fontSize: 15, color: ColorManager.appBarDarkPink)),
        ]),
        actions: [
          CircleAvatar(
            radius: AppSize.s28,
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60,
                width: 400,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: buttons.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              height: 25,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: (selected == buttons[index])
                                    ? ColorManager.lightPink
                                    : Colors.white,
                              ),
                              child: Text(
                                buttons[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: (selected == buttons[index])
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: textLines.appointments.length,
                      itemBuilder: (context, index) {
                        return AppointmentsCard(
                            title: textLines.appointments[index]["title"],
                            due: textLines.appointments[index]["due"],
                            description: textLines.appointments[index]
                                ["description"]);
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/createad");
        },
        backgroundColor: ColorManager.darkGreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
