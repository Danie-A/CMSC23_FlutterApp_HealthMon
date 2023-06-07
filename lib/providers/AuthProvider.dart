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
>> This page contains the providers for the Auth API. This makes the screens be able to do functions defined in the API.
*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/FirebaseAuthAPI.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;
  String uid = "";

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;

  String get userId => uid;
  setUid(String uid) {
    this.uid = uid;
    notifyListeners();
  }

  void fetchAuthentication() {
    uStream = authService.getUser();

    notifyListeners();
  }

  Future<String> signUp(String email, String password) async {
    String message = await authService.signUp(email, password);
    notifyListeners();
    return message;
  }

  Future<String> signIn(String email, String password) async {
    String message = await authService.signIn(email, password);
    notifyListeners();
    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
