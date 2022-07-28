import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_navigator/pojo/CommonResponse.dart';
import 'package:flutter_navigator/pojo/LoginResponse.dart';
import 'package:flutter_navigator/pojo/StudentDetailResponse.dart';
import 'package:flutter_navigator/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
//import 'package:student_demo/utils/constant.dart';

class RestApi {
  //Login User
  /*Future<UserLoginResponse?> loginUser(
      String userName, String userPassword, String deviceToken) async {
    String url = BASE_URL + 'Client/login';

    var map = <String, dynamic>{};
    map["userName"] = userName.trim();
    map["userPassword"] = userPassword.trim();
    map["deviceToken"] = deviceToken.trim();

    http.Response response = await http.post(Uri.parse(url), body: map);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      return UserLoginResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }*/

  Future<CommonResponse?> register(
      String rollNo,
      String studentName,
      String studentDOB,
      String gender,
      String contactNo,
      String email,
      String password,
      String language) async {
    String url = BASE_URL + 'register';
    var map = <String, dynamic>{};
    map["rollNo"] = rollNo.trim();
    map["studentName"] = studentName.trim();
    map["studentDOB"] = studentDOB.trim();
    map["gender"] = gender.trim();
    map["contactNo"] = contactNo.trim();
    map["email"] = email.trim();
    map["password"] = password.trim();
    map["language"] = language.trim();
    http.Response response = await http.post(Uri.parse(url), body: map);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      return CommonResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<LoginResponse?> login(String email, String password) async {
    String url = BASE_URL + 'login';
    var map = <String, dynamic>{};
    map["email"] = email.trim();
    map["password"] = password.trim();
    http.Response response = await http.post(Uri.parse(url), body: map);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<StudentDetailResponse?> getStudent(String id) async {
    String url = BASE_URL + 'getStudent';
    var map = <String, dynamic>{};
    map["id"] = id.trim();
    http.Response response = await http.post(Uri.parse(url), body: map);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      return StudentDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Future<CommonResponse?> register(
  //     String rollNo,
  //     String studentName,
  //     String studentDOB,
  //     String gender,
  //     String contactNo,
  //     String email,
  //     String password,
  //     String language) async {
  //   String url = BASE_URL + 'register';
  //   var map = <String, dynamic>{};
  //   map["rollNo"] = rollNo.trim();
  //   map["studentName"] = studentName.trim();
  //   map["studentDOB"] = studentDOB.trim();
  //   map["gender"] = gender.trim();
  //   map["contactNo"] = contactNo.trim();
  //   map["email"] = email.trim();
  //   map["password"] = password.trim();
  //   map["language"] = language.trim();
  //   http.Response response = await http.post(Uri.parse(url), body: map);
  //   if (kDebugMode) {
  //     print(response.body);
  //   }
  //   if (response.statusCode == 200) {
  //     return CommonResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     return null;
  //   }
  // }

  Future<CommonResponse?> updateStudent(
    String id,
    String rollno,
    String studentname,
    String studentDob,
    String gender,
    String contactNo,
    String password,
    String email,
    String language,
  ) async {
    String url = BASE_URL + 'updateStudent';
    var map = <String, dynamic>{};
    map["id"] = id.trim();
    map["rollNo"] = rollno.trim();
    map["studentName"] = studentname.trim();
    map["studentDOB"] = studentDob.trim();
    map["gender"] = gender.trim();
    map["contactNo"] = contactNo.trim();
    map["password"] = password.trim();
    map["email"] = email.trim();

    http.Response response = await http.post(Uri.parse(url), body: map);

    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      return CommonResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<CommonResponse?> updateStudentPhoto(
      String id, String imagePath) async {
    String url = BASE_URL + 'updateStudentPhoto';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(await http.MultipartFile.fromPath(
        'studentImage', imagePath,
        contentType: MediaType("image", imagePath.split(".").last)));

    request.fields['id'] = id.trim();
    //request.fields['user_type'] = userType.trim();

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    if (response.statusCode == 200) {
      return CommonResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
