import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
import '../models/models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String routeName = AppRoutes.homeScreen;
  @override
  State<Home> createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  // TODO: Filter appointments per date range
  late DataProvider dataServices;
  //static final String selected = buttons[2];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dataServices = Provider.of<DataProvider>(context, listen: false);
      dataServices.fillTimeRatioArray();
      dataServices.fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Appointment> appointments = context.watch<DataProvider>().appointments;
    User? currentUser = context.watch<DataProvider>().currentUser;
    List<TimeRatio> _timeRatios =
        context.watch<DataProvider>().getTimeRatioButtons;
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
              Text('${AppString.hello} ${currentUser?.name ?? 'no name'}',
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
                backgroundImage: currentUser!.getAvatar(),
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
                    itemCount: _timeRatios.length,
                    itemBuilder: ((context, index) {
                      return Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                dataServices.notifyListeners();
                              },
                              child: _timeRatios.elementAt(index))
                        ],
                      );
                    })),
              ),
              // TODO: Parse data in model
              Expanded(
                  child: ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(
                          id: appointments[index].id,
                          title: appointments[index].title,
                          due: appointments[index].getDate.split(' ')[0],
                          description: appointments[index].description,
                          date: appointments[index].getDate.split(' ')[0],
                          time: appointments[index].getDate.split(' ')[1],
                        );
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
