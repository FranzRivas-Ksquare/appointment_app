import 'package:appointment/screens/home.dart';
import 'package:flutter/material.dart';

import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
// import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/update_profile.dart';
import 'screens/new_appointment.dart';
import 'screens/update_appointment.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final name = settings.name;

  return MaterialPageRoute(
    builder: routes[name]!,
    settings: settings,
  );
}

var routes = <String, WidgetBuilder>{
  SignIn.routeName: (ctx) => const SignIn(),
  SignUp.routeName: (ctx) => const SignUp(),
  // Home.routeName: (ctx) => const Home(),
  Profile.routeName: (ctx) => const Profile(),
  UpdateProfile.routeName: (ctx) => const UpdateProfile(),
  NewAppointment.routeName: (ctx) => const NewAppointment(),
  UpdateAppointment.routeName: (ctx) => const UpdateAppointment(),
};
