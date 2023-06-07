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
>> This page contains the providers for the Request API. This makes the screens be able to do functions defined in the API.
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/FirebaseRequestAPI.dart';
import '../models/Request.dart';
import '../providers/RequestProvider.dart';

class RequestProvider with ChangeNotifier {
  late FirebaseRequestAPI firebaseService;
  late Stream<QuerySnapshot> _requestStream;
  Request? currentRequest;

  RequestProvider() {
    firebaseService = FirebaseRequestAPI();
    fetchRequestDetails();
  }

  // getter
  Stream<QuerySnapshot> get requestDetails => _requestStream;

  fetchRequestDetails() {
    _requestStream = firebaseService.getAllRequests();
    notifyListeners();
  }

  setCurrentRequest(Request request) {
    currentRequest = request;
    notifyListeners();
  }

  getCurrentRequest() {
    return currentRequest;
  }

  void addRequest(Request request) async {
    String message = await firebaseService.addRequest(request.toJson(request));
    setCurrentRequest(request);
    print(message);
    print(currentRequest);
    notifyListeners();
  }

  void deleteRequest(String id) async {
    String message = await firebaseService.deleteRequest(id);
    print(message);
    notifyListeners();
  }
}
