import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator/pojo/CommonResponse.dart';
import 'package:flutter_navigator/pojo/StudentData.dart';
import 'package:flutter_navigator/pojo/StudentDetailResponse.dart';
import 'package:flutter_navigator/user/LoginScreen.dart';
import 'package:flutter_navigator/user/RegistrationScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_navigator/components/profileDetailRaw.dart';
import 'package:flutter_navigator/components/splash_button.dart';
import 'package:flutter_navigator/services/rest_api.dart';
import 'package:flutter_navigator/utils/config.dart';
import 'package:flutter_navigator/utils/constant.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "ProfileScreen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showSpinner = false;
  Config config = Config();
  RestApi restApi = RestApi();
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? imageFile;
  StudentData studentData = StudentData();
  //StudentData studentData = new StudentDate();

  @override
  void initState() {
    profile();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: kAppBarColor),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Yes',
                  style: TextStyle(color: kAppBarColor),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: KDarkAppBarColor,
        ),
        body: showSpinner
            ? config.loadingView()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    //Profile Image
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              config.imageChoiceDialog(
                                  context, openGallery, openCamera);
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kAppBarColor,
                                border: Border.all(
                                    color: KDarkAppBarColor, width: 3),
                                image: DecorationImage(
                                  fit: studentData.studentImage!.isEmpty
                                      ? BoxFit.cover
                                      : BoxFit.contain,
                                  image: loadImage(),
                                ),
                              ),
                              child: Stack(
                                children: const <Widget>[
                                  Positioned(
                                    right: 0.0,
                                    bottom: 0.0,
                                    child: Icon(
                                      FontAwesomeIcons.pencil,
                                      size: 18.0,
                                      color: KDarkAppBarColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Profile Details
                    Container(
                      width: width,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                studentData.studentName!,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              studentData.email!,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          Column(
                            children: [
                              ProfileDetailRaw(
                                  title: "Contact no : ",
                                  detail: studentData.contactNo!),
                              ProfileDetailRaw(
                                  title: "Gender : ",
                                  detail: studentData.gender!),
                              ProfileDetailRaw(
                                  title: "DOB : ",
                                  detail: studentData.studentDOB!),
                              ProfileDetailRaw(
                                  title: "Language : ",
                                  detail: studentData.language!),
                              ProfileDetailRaw(
                                  title: "Language : ",
                                  detail: studentData.language!),
                            ],
                          )
                        ],
                      ),
                    ),
                    //Buttons
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconSplashButton(
                                    height: 55,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RegistrationScreen.id,
                                          arguments: {
                                            "type": "edit",
                                            "pageTitle": "Edit Profile",
                                          }).whenComplete(() {
                                        profile();
                                      });
                                    },
                                    icon: const Icon(FontAwesomeIcons.pencil,
                                        color: Colors.blue),
                                    borderWidth: 2.0,
                                    borderColor: Colors.grey,
                                    borderRadius: 10.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconSplashButton(
                                    height: 55,
                                    onTap: () {
                                      config.logoutDialog(context, () {
                                        logout();
                                      });
                                    },
                                    icon: const Icon(FontAwesomeIcons.powerOff,
                                        color: Colors.red),
                                    borderColor: Colors.grey,
                                    borderRadius: 10.0,
                                    borderWidth: 2.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void logout() async {
    config.setBooleanSharedPreferences("isLogin", false);
    config.setStringSharedPreferences("userID", "");
    config.setStringSharedPreferences("userName", "");

    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, ModalRoute.withName(LoginScreen.id));
  }

  void openGallery() async {
    final picture = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      imageFile = picture;
      updateStudentPhoto(imageFile!.path);
    });
  }

  void openCamera() async {
    final picture = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 80);
    setState(() {
      imageFile = picture;
      updateStudentPhoto(imageFile!.path);
    });
  }

  void profile() async {
    try {
      if (mounted) {
        setState(() {
          showSpinner = true;
        });
      }
      String id = await config.getStringSharedPreferences("userID");
      StudentDetailResponse? response = await restApi.getStudent(id);
      if (response != null) {
        if (response.result == "success") {
          config.showToastSuccess(response.msg);
          studentData = response.data!;
        } else {
          config.showToastFailure(response.msg);
        }
      } else {
        config.showToastFailure(SERVICE_FAILURE);
      }
      if (mounted) {
        setState(() {
          showSpinner = false;
        });
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }

      if (mounted) {
        setState(() {
          showSpinner = false;
        });
      }
    }
  }

  ImageProvider loadImage() {
    if (studentData.studentImage!.isEmpty) {
      return const AssetImage("assets/i4.jpg");
    } else {
      return NetworkImage(IMAGE_BASE_URL + studentData.studentImage!);
    }
  }

  void updateStudentPhoto(String imagePath) async {
    try {
      if (mounted) {
        setState(() {
          showSpinner = true;
        });
      }

      String id = await config.getStringSharedPreferences("userID");
      CommonResponse? response =
          await restApi.updateStudentPhoto(id, imagePath);
      if (response != null) {
        if (response.result == "success") {
          config.showToastSuccess(response.msg);
          profile();
        } else {
          config.showToastFailure(response.msg);
        }
      } else {
        config.showToastFailure(SERVICE_FAILURE);
      }
      if (mounted) {
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (mounted) {
        setState(() {
          showSpinner = false;
        });
      }
    }
  }
}
