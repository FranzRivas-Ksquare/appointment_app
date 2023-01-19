import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import '../resources/theme.dart';
import '../resources/router.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../controller/timeratio_provider.dart';
import '../controller/database_controller.dart';
import '../controller/user_controller.dart';
import '../controller/appointment_controller.dart';

// TODO: Comment all the code
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  DatabaseCtrl().startDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseCtrl()),
        ChangeNotifierProvider(create: (context) => UserCtrl()),
        ChangeNotifierProvider(create: (context) => AppointmentCtrl()),
        ChangeNotifierProvider(create: (context) => TimeRatioProvider()),
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
