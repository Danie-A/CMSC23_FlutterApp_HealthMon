
import 'dart:convert';

class Log {
  String location;
  String status;
  int studentNo;
  //String studentUID;
  String studentName;

  Log(
      {required this.location,
      required this.status,
      required this.studentNo,
      //required this.studentUID,
      required this.studentName}); 

  factory Log.logFromJson(Map<String, dynamic> json) {
    return Log(
        location: json['location'],
        status: json['status'],
        studentNo: json['studentNo'],
        //studentUID: json['studentUID'],
        studentName: json['studentName']);

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
      //'studentUID': log.studentUID,
      'studentName': log.studentName,
    };
  }
}
