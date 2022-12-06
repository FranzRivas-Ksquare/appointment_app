import 'package:flutter/material.dart';
import 'theme.dart';
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
      theme: AppTheme.theme,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
