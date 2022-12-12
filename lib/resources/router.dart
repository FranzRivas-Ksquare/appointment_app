import 'package:flutter/material.dart';

import '../views/sign_in.dart';
import '../views/sign_up.dart';
import '../views/home.dart';
import '../views/profile.dart';
import '../views/update_profile.dart';
import '../views/new_appointment.dart';
import '../views/update_appointment.dart';

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
  Home.routeName: (ctx) => const Home(),
  Profile.routeName: (ctx) => const Profile(),
  UpdateProfile.routeName: (ctx) => const UpdateProfile(),
  NewAppointment.routeName: (ctx) => const NewAppointment(),
  UpdateAppointment.routeName: (ctx) => const UpdateAppointment(),
};
