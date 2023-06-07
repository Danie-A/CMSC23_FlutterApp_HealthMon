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
>> This page contains the providers for the Log API. This makes the screens be able to do functions defined in the API.
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Log.dart';
import '../api/FirebaseLogAPI.dart';

class LogProvider with ChangeNotifier {
  late FirebaseLogAPI firebaseService;
  late Stream<QuerySnapshot> _logStream;
  late Stream<QuerySnapshot> _searchedLogStream;

  Log? currentLog;

  LogProvider() {
    firebaseService = FirebaseLogAPI();
    fetchLogDetails();
  }

  // getter
  Stream<QuerySnapshot> get logDetails => _logStream;
  Stream<QuerySnapshot> get searchedLogStream => _searchedLogStream;

  fetchLogDetails() {
    _logStream = firebaseService.getAllLogs();
    _searchedLogStream = firebaseService.getSearchedLogs();
    notifyListeners();
  }

  setCurrentLog(Log log) {
    currentLog = log;
    notifyListeners();
  }

  getCurrentLog() {
    return currentLog;
  }

  void addLogDetail(Log log) async {
    String message = await firebaseService.addLog(log.logToJson(log));
    setCurrentLog(log);
    print(message);
    print(currentLog);
    notifyListeners();
  }

  void deleteLog(String id) async {
    String message = await firebaseService.deleteLog(id);
    print(message);
    notifyListeners();
  }
}
