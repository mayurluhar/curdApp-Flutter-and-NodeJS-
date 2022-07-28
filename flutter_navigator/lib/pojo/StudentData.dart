class StudentData {
  String? sId;
  String? rollNo;
  String? studentName;
  String? email;
  String? studentImage;
  String? studentDOB;
  String? contactNo;
  String? gender;
  String? password;
  String? language;
  String? addedOn;
  bool? isActive;
  int? iV;

  StudentData(
      {this.sId,
      this.rollNo,
      this.studentName,
      this.email,
      this.studentImage,
      this.studentDOB,
      this.contactNo,
      this.gender,
      this.password,
      this.language,
      this.addedOn,
      this.isActive,
      this.iV});

  StudentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rollNo = json['rollNo'];
    studentName = json['studentName'];
    email = json['email'];
    studentImage = json['studentImage'];
    studentDOB = json['studentDOB'];
    contactNo = json['contactNo'];
    gender = json['gender'];
    password = json['password'];
    language = json['language'];
    addedOn = json['addedOn'];
    isActive = json['isActive'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rollNo'] = this.rollNo;
    data['studentName'] = this.studentName;
    data['email'] = this.email;
    data['studentImage'] = this.studentImage;
    data['studentDOB'] = this.studentDOB;
    data['contactNo'] = this.contactNo;
    data['gender'] = this.gender;
    data['password'] = this.password;
    data['language'] = this.language;
    data['addedOn'] = this.addedOn;
    data['isActive'] = this.isActive;
    data['__v'] = this.iV;
    return data;
  }
}
