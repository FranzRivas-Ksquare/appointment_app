import 'package:flutter/material.dart';
import '../views/sign_in.dart';
import '../views/sign_up.dart';
import '../views/home.dart';
import '../views/profile.dart';
import '../views/update_profile.dart';
import '../views/new_appointment.dart';
import '../views/update_appointment.dart';
import '../models/user_model.dart';
import '../models/appointment_model.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final name = settings.name;

  return MaterialPageRoute(
    builder: routes[name]!,
    settings: settings,
  );
}

var routes = <String, WidgetBuilder>{
  SignIn.routeName: (ctx) => const SafeArea(child: SignIn()),
  SignUp.routeName: (ctx) => const SafeArea(child: SignUp()),
  Home.routeName: (ctx) => const SafeArea(child: Home()),
  Profile.routeName: (ctx) => const SafeArea(child: Profile()),
  UpdateProfile.routeName: (ctx) {
      final args = ModalRoute.of(ctx)!.settings.arguments as Map<String, dynamic>;
      return SafeArea(child: UpdateProfile(user: args['user']! as User));
    },
  NewAppointment.routeName: (ctx) => const SafeArea(child: NewAppointment()),
  UpdateAppointment.routeName: (ctx) {
    final args = ModalRoute.of(ctx)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(child: UpdateAppointment(appointment: args['appointment']! as Appointment));
  },
};
