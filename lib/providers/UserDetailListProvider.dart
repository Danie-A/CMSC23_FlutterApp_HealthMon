import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/UserDetail.dart';
import '../api/FirebaseUserDetailAPI.dart';

class UserDetailListProvider with ChangeNotifier {
  late FirebaseUserDetailAPI firebaseService;
  late Stream<QuerySnapshot> _userDetailStream;
  late Stream<QuerySnapshot> _userDetailStream2;

  late Stream<QuerySnapshot> _sortStudentNoStream;
  late Stream<QuerySnapshot> _sortDateStream;
  late Stream<QuerySnapshot> _sortCourseStream;
  late Stream<QuerySnapshot> _sortCollegeStream;

  String currentId = "";
  String _userType = "";
  UserDetail? _currentUser;

  UserDetailListProvider() {
    firebaseService = FirebaseUserDetailAPI();
    fetchUserDetails();
  }

  // getter
  UserDetail? get currentUser => _currentUser;
  String get getId => currentId;
  String get userType => _userType;

  Stream<QuerySnapshot> get userDetails => _userDetailStream;
  Stream<QuerySnapshot> get userDetails2 => _userDetailStream2;

  // for sorting/filtering students
  Stream<QuerySnapshot> get sortStudentNoStream => _sortStudentNoStream;
  Stream<QuerySnapshot> get sortDateStream => _sortDateStream;
  Stream<QuerySnapshot> get sortCourseStream => _sortCourseStream;
  Stream<QuerySnapshot> get sortCollegeStream => _sortCollegeStream;

  setCourseStream(String course) {
    this._sortCourseStream = firebaseService.getSortCourse(course);
    notifyListeners();
  }

  setCollegeStream(String college) {
    this._sortCollegeStream = firebaseService.getSortCollege(college);
    notifyListeners();
  }

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
    _sortStudentNoStream = firebaseService.getSortStudentNo();
    _sortDateStream = firebaseService.getSortDate();
    notifyListeners();
  }

  Stream<QuerySnapshot> getQuarantinedUsers() {
    Stream<QuerySnapshot> filteredStream =
        firebaseService.getQuarantinedUsers();
    return filteredStream;
  }

  Stream<QuerySnapshot> getUnderMonitoringUsers() {
    Stream<QuerySnapshot> filteredStream =
        firebaseService.getUnderMonitoringUsers();
    return filteredStream;
  }

  Stream<QuerySnapshot> getSortStudentNo() {
    Stream<QuerySnapshot> filteredStream = firebaseService.getSortStudentNo();
    return filteredStream;
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
    String message = await firebaseService.editUserType(id, userType);
    notifyListeners();
  }

  void addAdminUniqueProperties(
      String id, String empNo, String position, String homeUnit) async {
    String message = await firebaseService.addAdminUniqueProperties(
        id, empNo, position, homeUnit);
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

  void editEntryId(String id, String entryId) async {
    String message = await firebaseService.editEntryId(id, entryId);
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
