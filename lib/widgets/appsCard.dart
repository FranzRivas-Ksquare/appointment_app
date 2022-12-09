import 'package:appointment/resources/color.manager.dart';
import 'package:flutter/material.dart';

class AppointmentsCard extends StatelessWidget {
  String title;
  String due;
  String description;

  AppointmentsCard({
    super.key,
    required this.title,
    required this.due,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 400,
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xffeaeaea), width: 2.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: ColorManager.darkGreen,
              size: 50.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.black)),
                  Flexible(
                    child: Text(description,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(due,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)),
              ],
            )
          ],
        ));
  }
}
