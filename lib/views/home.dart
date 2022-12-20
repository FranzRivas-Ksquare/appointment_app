import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../custom_widgets/appointment_card.dart';
import '../custom_widgets/button_custom.dart';
import '../custom_widgets/time_ratio.dart';
import '../models/dummy_data.dart';
import '../controller/data_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const String routeName = AppRoutes.homeScreen;

  static final textLines = Appointments();
  static final List buttons = [
    "All",
    "Today",
    "Tomorrow",
    "Past",
  ];

  static final String selected = buttons[2];

  @override
  Widget build(BuildContext context) {
    //--Set provider
    var dataServices = Provider.of<DataProvider>(context);
    dataServices.fetchAppointments();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.appBarLightPink,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppString.welcome,
                  style: Theme.of(context).textTheme.headline3),
              Text(AppString.hello,
                  style: TextStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.appBarDarkPink)),
            ]),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profileScreen);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: AppPadding.p18),
              child: CircleAvatar(
                radius: AppSize.s28,
                backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: AppSize.s60,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: buttons.length,
                    itemBuilder: ((context, index) {
                      return Row(
                        children: [
                          TimeRatio(text: buttons[index], isSelect: false)
                        ],
                      );
                    })),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: dataServices.appointments.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(
                            title: dataServices.appointments[index].title,
                            due: dataServices.appointments[index].date,
                            description:
                                dataServices.appointments[index].description,
                          date: dataServices.appointments[index].date,
                          time: dataServices.appointments[index].date,
                        );
                      })
                  ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          CustomButton().floatingButton(context, AppRoutes.newAppScreen),
    );
  }
}
