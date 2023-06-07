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
