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
