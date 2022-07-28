import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator/components/custom_text_field.dart';
import 'package:flutter_navigator/components/splash_button.dart';
import 'package:flutter_navigator/pojo/LoginResponse.dart';
import 'package:flutter_navigator/services/rest_api.dart';
import 'package:flutter_navigator/user/RegistrationScreen.dart';
import 'package:flutter_navigator/user/profileScreen.dart';
import 'package:flutter_navigator/utils/config.dart';
import 'package:flutter_navigator/utils/constant.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showspinner = false;
  Config config = Config();
  RestApi restApi = RestApi();
  Permission? permission;
  Animation? animation;
  AnimationController? animationController;
  String? email, password;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.5, 1.0, curve: Curves.bounceIn),
      ),
    );
    animationController!.forward();
    animationController!.addListener(() {
      setState(() {});
    });
    if (Platform.isAndroid) {
      if (permission != Permission.camera && permission != Permission.storage) {
        config.requestPermission();
      }
    } else {
      if (permission != Permission.camera &&
          permission != Permission.photos &&
          permission != Permission.accessMediaLocation) {
        config.requestPermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kAppBarColor,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: KDarkAppBarColor,
      ),
      body: showspinner
          ? config.loadingView()
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        "assets/i4.jpg",
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hello!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' login to get started',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),

                    Text("Student Demo"),
                    //Username
                    EditTextIcon(
                      hintText: "User Name",
                      keyBoardType: TextInputType.text,
                      password: false,
                      textController: emailController,
                      fillColor: KDarkAppBarColor,
                      borderWidth: 1.0,
                      leadingIcon: const Icon(
                        Icons.person,
                        color: KDarkAppBarColor,
                      ),
                      onTap: () {},
                      hintColor: KDarkAppBarColor,
                      readOnly: false,
                      borderRadius: 5.0,
                      maxLines: 1,
                      focusedBorderColor: Colors.grey,
                      inputAction: TextInputAction.next,
                    ),
                    EditTextIcon(
                      hintText: "Password",
                      hintColor: KDarkAppBarColor,
                      keyBoardType: TextInputType.visiblePassword,
                      password: true,
                      leadingIcon: const Icon(
                        Icons.lock_outline,
                        color: KDarkAppBarColor,
                      ),
                      textController: passwordController,
                      fillColor: Colors.white,
                      borderWidth: 1.0,
                      onTap: () {},
                      readOnly: false,
                      borderRadius: 5.0,
                      maxLines: 1,
                      focusedBorderColor: Colors.grey,
                      inputAction: TextInputAction.next,
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RegistrationScreen.id,
                            arguments: {
                              "type": "add",
                              "pageTitle": "Registration",
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20, top: 8, bottom: 8.0),
                            child: Text(
                              "create Account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 8, bottom: 8),
                      child: MaterialSplashButton(
                        onTap: () {
                          email = emailController.text;
                          password = passwordController.text;
                          if (email!.isEmpty && password!.isEmpty) {
                            config.showToastFailure(
                                "please enter username & password");
                          } else {
                            login();
                          }
                        },
                        borderRadius: 10.0,
                        color: KButtonColor,
                        height: 55,
                        width: width,
                        text: "Login",
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void login() async {
    try {
      if (mounted) {
        setState(() {
          showspinner = true;
        });
      }

      LoginResponse? response = await restApi.login(email!, password!);

      if (response != null) {
        if (response.result == "success") {
          config.showToastSuccess(response.msg);
          config.setStringSharedPreferences("userID", response.data!.sId);
          config.setStringSharedPreferences("email", response.data!.email);
          config.setBooleanSharedPreferences("isLogin", true);

          Navigator.pushNamedAndRemoveUntil(
              context, ProfileScreen.id, ModalRoute.withName(ProfileScreen.id));
          //  Navigator.pushReplacementNamed(context, LoginScreen.id);
        } else {
          config.showToastFailure(response.msg);
        }
      } else {
        config.showToastFailure(SERVICE_FAILURE);
      }

      if (mounted) {
        setState(() {
          showspinner = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (mounted) {
        setState(() {
          showspinner = false;
        });
      }
    }
  }
}
