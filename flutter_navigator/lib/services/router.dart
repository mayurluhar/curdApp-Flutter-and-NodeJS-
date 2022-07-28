import 'package:flutter/material.dart';
import 'package:flutter_navigator/UndefinedView.dart';
import 'package:flutter_navigator/spalsh_screen.dart';
import 'package:flutter_navigator/user/LoginScreen.dart';
import 'package:flutter_navigator/user/RegistrationScreen.dart';
import 'package:flutter_navigator/user/profileScreen.dart';

// ignore: missing_return
Route<dynamic> generateRoute(RouteSettings settings) {
  Map<String, dynamic> arguments = {};
  if (settings.arguments != null) {
    arguments = settings.arguments as Map<String, dynamic>;
  }
  switch (settings.name) {
    case LoginScreen.id:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case SplashScreen.id:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
    case RegistrationScreen.id:
      return MaterialPageRoute(
        builder: (context) => RegistrationScreen(
          arguments: arguments,
        ),
      );
    case ProfileScreen.id:
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => UndefinedView(
          name: settings.name!,
        ),
      );
  }
}
