import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_navigator/user/LoginScreen.dart';
import 'package:flutter_navigator/user/RegistrationScreen.dart';
import 'package:flutter_navigator/user/profileScreen.dart';

import 'package:flutter_navigator/utils/config.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  Config config = Config();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => navigation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset("assets/i4.jpg")],
      ),
    );
  }

  navigation() async {
    isLogin = await config.getBooleanSharedPreferences("isLogin") ?? false;
    if (isLogin) {
      Navigator.pushReplacementNamed(context, ProfileScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }
}
