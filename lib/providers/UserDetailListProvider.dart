import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/UserDetail.dart';
import '../api/FirebaseUserDetailAPI.dart';

class UserDetailListProvider with ChangeNotifier {
  late FirebaseUserDetailAPI firebaseService;
  late Stream<QuerySnapshot> _userDetailStream;
  late Stream<QuerySnapshot> _userDetailStream2;

  String currentId = "";
  String _userType = "";
  UserDetail? _currentUser;

  UserDetailListProvider() {
    firebaseService = FirebaseUserDetailAPI();
    fetchUserDetails();
  }

  // getter
  Stream<QuerySnapshot> get userDetails => _userDetailStream;
  Stream<QuerySnapshot> get userDetails2 => _userDetailStream2;

  UserDetail? get currentUser => _currentUser;

  String get getId => currentId;

  String get userType => _userType;
  setUserType(String userType) {
    this._userType = userType;
  }

  setCurrentId(String id) {
    this.currentId = id;
  }

  setCurrentUser(UserDetail user) {
    this._currentUser = user;
  }

  fetchUserDetails() {
    _userDetailStream = firebaseService.getAllUserDetails();
    _userDetailStream2 = firebaseService.getAllUserDetails();
    notifyListeners();
  }

  Future<Stream<QuerySnapshot>> getCurrentUserDetail(String uid) async {
    return await firebaseService.getCurrentUserDetail(uid);
  }

  void addStudentDetail(UserDetail user) async {
    String message =
        await firebaseService.addUserDetail(user.studentToJson(user));
    print(message);

    notifyListeners();
  }

  void addAdminMonitorDetail(UserDetail user) async {
    String message =
        await firebaseService.addUserDetail(user.adminMonitorToJson(user));
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

  void changeUserType(String id, String userType) async {
    String message = await firebaseService.editStatus(id, userType);
    notifyListeners();
  }

  void editStatus(String id, String status) async {
    String message = await firebaseService.editStatus(id, status);
    notifyListeners();
  }

  void addLocation(String id, String location) async {
    String message = await firebaseService.addLocation(id, location);
    notifyListeners();
  }

  void editLatestEntry(String id, String latestEntry) async {
    String message = await firebaseService.editLatestEntry(id, latestEntry);
    notifyListeners();
  }

  Future<String> getCurrentId(String uid) async {
    String message = await firebaseService.getCurrentId(uid);
    setCurrentId(message);
    notifyListeners();
    return message;
  }

  Future<String> getUserStatus(String uid) async {
    String status = await firebaseService.getUserStatus(uid);
    notifyListeners();
    return status;
  }
}
