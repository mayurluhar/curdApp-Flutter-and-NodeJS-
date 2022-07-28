// ignore_for_file: sized_box_for_whitespace, import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_navigator/utils/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Config {
  Future<bool> setStringSharedPreferences(String? key, String? value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(key!, value!);
  }

  Future<String> getStringSharedPreferences(String? key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key!) ?? "";
  }

  Future<bool> setIntSharedPreferences(String? key, int? value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(key!, value!);
  }

  Future<int> getIntSharedPreferences(String? key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key!)!;
  }

  Future<bool?> setBooleanSharedPreferences(String? key, bool? value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(key!, value!);
  }

  Future<bool?> getBooleanSharedPreferences(String? key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key!);
  }

  void showToastFailure(String? message) {
    Fluttertoast.showToast(
        msg: message!, backgroundColor: Colors.red, textColor: Colors.white);
  }

  void showToastSuccess(String? message) {
    Fluttertoast.showToast(
        msg: message!, backgroundColor: Colors.green, textColor: Colors.white);
  }

  String convertDate(String? date) {
    var newDateTimeObj2 = DateFormat("yyyy-MM-dd").parse(date!);
    return DateFormat("dd-MMM-yyyy").format(newDateTimeObj2);
  }

  String convertDateToString(String? date) {
    var newDateTimeObj2 = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date!);
    return DateFormat.yMMMd().add_jm().format(newDateTimeObj2);
  }

  Future<DateTime?> pickDate(BuildContext context, DateTime pickedDate) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    return date;
  }

  // Progress indicator widget to show loading.
  Widget loadingView() => Center(
        child: Container(
          height: 50,
          width: 50,
          child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [kAppBarColor],
          ),
        ),
      );

  // View to empty data message
  Widget noDataView(String? msg) => Center(
        child: Text(
          msg!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      );

  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      await [
        Permission.camera,
        Permission.storage,
      ].request();
    } else {
      await [
        Permission.camera,
        Permission.accessMediaLocation,
        Permission.photos
      ].request();
    }
  }

  void infoDialog(BuildContext context, String? content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text("Information"),
          content: Text(content!),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            MaterialButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showCustomDialog(BuildContext context, Widget content) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          child: content,
        );
      },
    );
  }

  void logoutDialog(BuildContext context, Function onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text("Logout"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            MaterialButton(
              child: Text("Yes"),
              onPressed: () {
                onPressed();
              },
            ),
            MaterialButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void clearDialog(BuildContext context, Function onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text("Clear"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            MaterialButton(
              child: Text("Yes"),
              onPressed: () {
                onPressed();
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void imageChoiceDialog(
      BuildContext context, Function openGallery, Function openCamera) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            "Select Image",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // usually buttons at the bottom of the dialog
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gallery",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const Icon(FontAwesomeIcons.photoFilm),
                    ],
                  ),
                  onTap: () {
                    openGallery();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Camera",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const Icon(FontAwesomeIcons.camera),
                      ],
                    ),
                    onTap: () {
                      openCamera();
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
              ),
            ),
          ],
        );
      },
    );
  }
}
