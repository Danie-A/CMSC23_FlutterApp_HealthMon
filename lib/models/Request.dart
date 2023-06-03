
// class for entry
// dynamic fields

import 'dart:convert';
import 'Entry.dart';

class Request {
  List<dynamic>? entry;
  String? id;
  String? type;
  String? date;

  Request({
    this.entry,
    required this.id,
    required this.type,
    required this.date,
  });

  // Factory constructor to instantiate object from json format
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        entry: json['entry'],
        type: json['type'],
        id: json['id'],
        date: json['date']);
  }

  static List<Request> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Request>((dynamic d) => Request.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Request request) {
    return {
      'entry': request.entry,
      'type': request.type,
      'id': request.id,
      'date': request.date
    };
  }
}
