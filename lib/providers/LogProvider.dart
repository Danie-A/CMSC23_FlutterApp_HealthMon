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
