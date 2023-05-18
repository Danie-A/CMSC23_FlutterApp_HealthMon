// class for user detail (for students, admin, entrance monitor)
// dynamic fields

import 'dart:convert';

class UserDetail {
  String? id;
  String firstName;
  String lastName;
  String email;
  String status;
  String userType; // "student", "admin", "monitor"

  // for student (user)
  String? username;
  String? college;
  String? course;
  int? studentNo;
  List<String>? preExistingIllness;

  // for admin or entrance monitor
  int? empNo;
  String? position;
  String? homeUnit;

  UserDetail(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.status,
      required this.userType,
      this.username,
      this.college,
      this.course,
      this.studentNo,
      this.preExistingIllness,
      this.empNo,
      this.position,
      this.homeUnit});

  // Factory constructor to instantiate object from json format
  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      status: json['status'],
      userType: json['userType'],
      username: json['username'],
      college: json['college'],
      course: json['course'],
      studentNo: json['studentNo'],
      preExistingIllness: json['preExistingIllness'],
      empNo: json['empNo'],
    );
  }

  static List<UserDetail> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserDetail>((dynamic d) => UserDetail.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(UserDetail userDetail) {
    return {
      'firstName': userDetail.firstName,
      'lastName': userDetail.lastName,
      'email': userDetail.email,
    };
  }
}
