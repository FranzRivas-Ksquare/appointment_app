import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import '../resources/theme.dart';
import '../resources/router.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../controller/timeratiobar_service.dart';
import '../controller/database_service.dart';
import '../controller/user_controller.dart';
import '../controller/appointment_controller.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  DatabaseService().startDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => UserCtrl()),
        ChangeNotifierProvider(create: (context) => AppointmentCtrl()),
        ChangeNotifierProvider(create: (context) => TimeRatioBarService()),
      ],
      child: MaterialApp(
        title: AppString.appTitle,
        theme: getApplicationTheme(),
        onGenerateRoute: onGenerateRoute,
        initialRoute: AppRoutes.signInScreen,
      ),
    );
  }
}
