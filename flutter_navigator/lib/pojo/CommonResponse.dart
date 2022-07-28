class CommonResponse {
  String? result;
  String? msg;
  int? data;

  CommonResponse({this.result, this.msg, this.data});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}
