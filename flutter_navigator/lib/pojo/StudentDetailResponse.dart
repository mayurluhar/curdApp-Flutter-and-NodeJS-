import 'package:flutter_navigator/pojo/StudentData.dart';

class StudentDetailResponse {
  String? result;
  String? msg;
  StudentData? data;

  StudentDetailResponse({this.result, this.msg, this.data});

  StudentDetailResponse.fromJson(Map<String, dynamic> json) {
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
