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
import '../controller/data_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String routeName = AppRoutes.homeScreen;
  @override
  State<Home> createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  // TODO: Filter appointments per date range
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
              Text('${AppString.hello} ${dataServices.getCurrentUser.name}',
                  style: TextStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.appBarDarkPink)),
            ]),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profileScreen);
            },
            child: Padding(
              padding: EdgeInsets.only(right: AppPadding.p18),
              child: CircleAvatar(
                radius: AppSize.s28,
                backgroundImage: FileImage(dataServices.getAvatar),
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
              // TODO: Try to update the appointments listen to a consumer
              Expanded(
                  child: ListView.builder(
                      itemCount: dataServices.appointments.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            direction: DismissDirection.horizontal,
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.red[400],
                              child: Icon(Icons.delete_outline_rounded,
                                  color: Colors.white),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                            ),
                            onDismissed: (direction) {
                              print("hola");
                              dataServices.deleteAppointments(
                                  dataServices.appointments[index].id!);
                            },
                            child: AppointmentCard(
                              id: dataServices.appointments[index].id!,
                              title: dataServices.appointments[index].title,
                              due: dataServices.appointments[index].date
                                  .split(' ')[0],
                              description:
                                  dataServices.appointments[index].description,
                              date: dataServices.appointments[index].date
                                  .split(' ')[0],
                              time: dataServices.appointments[index].date
                                  .split(' ')[1],
                            ));
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton:
          CustomButton().floatingButton(context, AppRoutes.newAppScreen),
    );
  }
}
