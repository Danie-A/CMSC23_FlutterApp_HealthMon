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
>> This page contains the model as well as the details for the request object to convert to or from JSON when communicating with the Firestore database.

 */
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
