import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/userdetail_model.dart';
import '../api/firebase_userdetail_api.dart';

class UserDetailListProvider with ChangeNotifier {
  late FirebaseUserDetailAPI firebaseService;
  late Stream<QuerySnapshot> _userDetailStream;

  UserDetailListProvider() {
    firebaseService = FirebaseUserDetailAPI();
    fetchUserDetails();
  }

  // getter
  Stream<QuerySnapshot> get userDetails => _userDetailStream;

  fetchUserDetails() {
    _userDetailStream = firebaseService.getAllUserDetails();
    notifyListeners();
  }

  void addUserDetail(UserDetail user) async {
    String message = await firebaseService.addUserDetail(user.toJson(user));
    print(message);

    notifyListeners();
  }

  // void editUserDetail(String id, String newTitle) async {
  //   String message = await firebaseService.editUserDetail(id, newTitle);
  //   print(message);
  //   notifyListeners();
  // }

  void deleteUserDetail(String id) async {
    String message = await firebaseService.deleteUserDetail(id);
    print(message);
    notifyListeners();
  }
}
