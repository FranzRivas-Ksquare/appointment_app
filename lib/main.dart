import 'package:appointment/controller/timeratio_provider.dart';
import 'package:appointment/resources/routes_manager.dart';
import 'package:appointment/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'resources/theme.dart';
import 'resources/router.dart';
import 'controller/data_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
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
