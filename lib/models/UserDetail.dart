/*

GROUP 2 MEMBERS (B7L)
>> Araez, Danielle Lei R.
>> Concepcion, Sean Kierby I.
>> Dela Cruz, Laydon Albert L.
>> Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
>> This page contains the model as well as the details for the userdetails object to convert to or from JSON when communicating with the Firestore database.

 */
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

  String? allergy;
  String? location;

  UserDetail(
      {this.id,
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
      this.allergy,
      this.location});

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
        allergy: json['allergy'],
        latestEntry: json['latestEntry'],
        location: json['location']);
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
        allergy: json['allergy'],
        preExistingIllness: json['preExistingIllness'],
        latestEntry: json['latestEntry'],
        location: json['location'],
        empNo: json['empNo'],
        studentNo: json['studentNo']);
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
        allergy: json['allergy'],
        preExistingIllness: json['preExistingIllness'],
        latestEntry: json['latestEntry'],
        location: json['location']);
  }

// get entmon details from json with location
  factory UserDetail.entmonFromJson(Map<String, dynamic> json) {
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
        allergy: json['allergy'],
        preExistingIllness: json['preExistingIllness'],
        latestEntry: json['latestEntry'],
        location: json['location']);
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
      'allergy': student.allergy,
      'latestEntry': student.latestEntry,
      'location': student.location
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
      'preExistingIllness': adminMonitor.preExistingIllness,
      'allergy': adminMonitor.allergy,
    };
  }

// entmon to JSON
  Map<String, dynamic> entmonToJson(UserDetail adminMonitor) {
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
      'preExistingIllness': adminMonitor.preExistingIllness,
      'allergy': adminMonitor.allergy,
      'location': adminMonitor.location,
    };
  }
}
