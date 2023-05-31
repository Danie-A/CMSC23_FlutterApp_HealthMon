import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/UserDetail.dart';
import '../api/FirebaseUserDetailAPI.dart';

class UserDetailListProvider with ChangeNotifier {
  late FirebaseUserDetailAPI firebaseService;
  late Stream<QuerySnapshot> _userDetailStream;
  Stream<DocumentSnapshot<Object?>>? _userStream;

  String currentId = "";
  String _userType = "";
  UserDetail? _currentUser;
  Map<UserDetail, String>? _studentUsers;

  UserDetailListProvider() {
    firebaseService = FirebaseUserDetailAPI();
    fetchUserDetails();
  }

  // getter
  Stream<QuerySnapshot> get userDetails => _userDetailStream;
  Stream<DocumentSnapshot<Object?>> get user => _userStream!;
  Map<UserDetail, String>? get studentUsers => _studentUsers;
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

  setStudentUsers(Map<UserDetail, String>? students) {
    this._studentUsers = students;
  }

  fetchUserDetails() {
    _userDetailStream = firebaseService.getAllUserDetails();
    notifyListeners();
  }

  Future<Stream<QuerySnapshot>> getStudentDetails(String userType) async {
    return await firebaseService.getStudentDetails(userType);
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

  void editStatus(String id, String status) async {
    String message = await firebaseService.editStatus(id, status);
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

  void fetchUserDetail(String id) async {
    _userStream = await firebaseService.getSpecificUser(id).snapshots();
    notifyListeners();
  }
}
