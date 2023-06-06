// class for entry
// dynamic fields

import 'dart:convert';
import 'Entry.dart';

class Request {
  List<dynamic>? entry;
  String? id;
  String? type;
  String? date;
  String? requester_name;
  String? entry_id;

  Request(
      {this.entry,
      this.id,
      required this.entry_id,
      required this.type,
      required this.date,
      required this.requester_name});

  // Factory constructor to instantiate object from json format
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        entry: json['entry'],
        type: json['type'],
        id: json['id'],
        date: json['date'],
        requester_name: json['requester_name'],
        entry_id: json['entry_id']);
  }

  static List<Request> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Request>((dynamic d) => Request.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Request request) {
    return {
      'entry': request.entry,
      'type': request.type,
      'date': request.date,
      'requester_name': request.requester_name,
      'entry_id': request.entry_id
    };
  }
}
