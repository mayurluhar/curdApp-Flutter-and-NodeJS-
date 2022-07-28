import 'package:flutter_navigator/pojo/StudentData.dart';

class LoginResponse {
  String? result;
  String? msg;
  StudentData? data;

  LoginResponse({this.result, this.msg, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null ? new StudentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
