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
import '../controller/user_controller.dart';
import '../controller/appointment_controller.dart';
import '../controller/timeratiobar_service.dart';
import '../models/user_model.dart';
import '../models/appointment_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String routeName = AppRoutes.homeScreen;
  @override
  State<Home> createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  late AppointmentCtrl appointmentCtrl;
  late TimeRatioBarService trService;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      appointmentCtrl = Provider.of<AppointmentCtrl>(context, listen: false);
      appointmentCtrl.fetchAppointments(context);
      trService = Provider.of<TimeRatioBarService>(context, listen: false);
      trService.fillTimeRatioArray();
      context.read<TimeRatioBarService>().changeTimeRatio(0);
      context.read<AppointmentCtrl>().timeRatioAll();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Appointment> appointments = context.watch<AppointmentCtrl>().getAppointments;
    User? currentUser = context.watch<UserCtrl>().getCurrentUser;
    List<TimeRatio> timeRatios = context.watch<TimeRatioBarService>().timeRatioButtons;

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
              padding: const EdgeInsets.only(right: AppPadding.p18),
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
                  itemCount: timeRatios.length,
                  itemBuilder: ((context, index) {
                    return Row(
                      children: [
                        timeRatios.elementAt(index),
                      ],
                    );
                  })),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        appointment: appointments[index],
                      );
                    })),
          ],
        )),
      ),
      floatingActionButton:
          CustomButton().floatingButton(context, AppRoutes.newAppScreen),
    );
  }
}
