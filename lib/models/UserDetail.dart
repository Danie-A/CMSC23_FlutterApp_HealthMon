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

// get STUDENT from JSON
  // Factory constructor to instantiate object from json format
  factory UserDetail.studentFromJson(Map<String, dynamic> json) {
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
        preExistingIllness: json['preExistingIllness']);
  }

// get ADMIN or MONITOR from JSON
  factory UserDetail.adminMonitorFromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      status: json['status'],
      userType: json['userType'],
      empNo: json['empNo'],
      position: json['position'],
      homeUnit: json['homeUnit'],
    );
  }

// list of students
  static List<UserDetail> studentsFromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<UserDetail>((dynamic d) => UserDetail.studentFromJson(d))
        .toList();
  }

// list of admins or entrance monitors
  static List<UserDetail> adminMonitorsFromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<UserDetail>((dynamic d) => UserDetail.adminMonitorFromJson(d))
        .toList();
  }

// student to JSON
  Map<String, dynamic> studentToJson(UserDetail student) {
    return {
      'firstName': student.firstName,
      'lastName': student.lastName,
      'email': student.email,
      'status': student.status,
      'userType': student.userType,
      'username': student.username,
      'college': student.college,
      'course': student.course,
      'studentNo': student.studentNo,
      'preExistingIllness': student.preExistingIllness
    };
  }

// admin or monitor to JSON
  Map<String, dynamic> adminMonitorToJson(UserDetail adminMonitor) {
    return {
      'firstName': adminMonitor.firstName,
      'lastName': adminMonitor.lastName,
      'email': adminMonitor.email,
      'status': adminMonitor.status,
      'userType': adminMonitor.userType,
      'empNo': adminMonitor.empNo,
      'position': adminMonitor.position,
      'homeUnit': adminMonitor.homeUnit
    };
  }
}
