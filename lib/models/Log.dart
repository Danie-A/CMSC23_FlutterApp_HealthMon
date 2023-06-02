import 'dart:convert';

class Log {
  String location;
  String status;
  String studentNo;

  Log(
      {required this.location,
      required this.status,
      required this.studentNo}); 

// get LOG from JSON
  // Factory constructor to instantiate object from json format
  factory Log.logFromJson(Map<String, dynamic> json) {
    return Log(
        location: json['location'],
        status: json['status'],
        studentNo: json['studentNo'],);
  }

// list of logs
  static List<Log> logFromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Log>((dynamic d) => Log.logFromJson(d)).toList();
  }

// log to JSON
  Map<String, dynamic> logToJson(Log log) {
    return {
      'location': log.location,
      'status': log.status,
      'studentNo': log.studentNo,
    };
  }
}
