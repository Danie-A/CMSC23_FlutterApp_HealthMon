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
>> This page contains the model as well as the details for the log object to convert to or from JSON when communicating with the Firestore database.

 */

import 'dart:convert';

class Log {
  String location;
  String status;
  int studentNo;
  String studentName;
  String logDate;

  Log(
      {required this.location,
      required this.status,
      required this.studentNo,
      required this.studentName,
      required this.logDate});

  factory Log.logFromJson(Map<String, dynamic> json) {
    return Log(
        location: json['location'],
        status: json['status'],
        studentNo: json['studentNo'],
        studentName: json['studentName'],
        logDate: json['logDate']);
  }

  static List<Log> logFromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Log>((dynamic d) => Log.logFromJson(d)).toList();
  }

  Map<String, dynamic> logToJson(Log log) {
    return {
      'location': log.location,
      'status': log.status,
      'studentNo': log.studentNo,
      'studentName': log.studentName,
      'logDate': log.logDate
    };
  }
}
