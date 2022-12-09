import 'package:flutter/material.dart';
import 'resources/theme.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointments',
      theme: getApplicationTheme(),
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/home',
    );
  }
}
