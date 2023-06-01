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
  String uid;

  // for student (user)
  String? username;
  String? college;
  String? course;
  int? studentNo;
  List<dynamic>? preExistingIllness;

  // for admin or entrance monitor
  int? empNo;
  String? position;
  String? homeUnit;
  String latestEntry;

  UserDetail({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    required this.userType,
    required this.uid,
    required this.latestEntry,
    this.username,
    this.college,
    this.course,
    this.studentNo,
    this.preExistingIllness,
    this.empNo,
    this.position,
    this.homeUnit,
  });

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
        uid: json['uid'],
        username: json['username'],
        college: json['college'],
        course: json['course'],
        studentNo: json['studentNo'],
        preExistingIllness: json['preExistingIllness'],
        latestEntry: json['latestEntry']);
  }

  factory UserDetail.userFromJson(Map<String, dynamic> json) {
    return UserDetail(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        status: json['status'],
        userType: json['userType'],
        uid: json['uid'],
        username: json['username'],
        college: json['college'],
        latestEntry: json['latestEntry']);
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
        uid: json['uid'],
        empNo: json['empNo'],
        position: json['position'],
        homeUnit: json['homeUnit'],
        latestEntry: json['latestEntry']);
  }

// list of users
  static List<UserDetail> usersList(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<UserDetail>((dynamic d) => UserDetail.studentFromJson(d))
        .toList();
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
      'uid': student.uid,
      'username': student.username,
      'college': student.college,
      'course': student.course,
      'studentNo': student.studentNo,
      'preExistingIllness': student.preExistingIllness,
      'latestEntry': student.latestEntry,
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
      'uid': adminMonitor.uid,
      'empNo': adminMonitor.empNo,
      'position': adminMonitor.position,
      'homeUnit': adminMonitor.homeUnit,
      'latestEntry': adminMonitor.latestEntry,
    };
  }
}
