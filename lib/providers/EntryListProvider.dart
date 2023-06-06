import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Entry.dart';
import '../api/FirebaseEntryAPI.dart';

class EntryListProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _entryStream;
  Entry? currentEntry;
  String? _entryId;

  EntryListProvider() {
    firebaseService = FirebaseEntryAPI();
    fetchEntryDetails();
  }

  // getter
  Stream<QuerySnapshot> get entryDetails => _entryStream;

  get getEntry => currentEntry;
  get entryId => _entryId;

// setter
  fetchEntryDetails() {
    _entryStream = firebaseService.getAllEntries();
    notifyListeners();
  }

  setCurrentEntry(Entry entry) async {
    currentEntry = await entry;
    // setEntryId(entry.id!);
    notifyListeners();
  }

  setEntryId(String entryId) async {
    _entryId = await entryId;
    notifyListeners();
  }

  Future<String> addEntryDetail(Entry entry) async {
    String entryId = await firebaseService.addEntry(entry.entryToJson(entry));
    setEntryId(entryId);
    print("[PROVIDER] Entry Id is:" + entryId);
    notifyListeners();
    return entryId;
  }

  void editEntry(Entry entry) async {
    String message = await firebaseService.editEntry(entry);
    print(message);
    notifyListeners();
  }

  void deleteEntry(String id) async {
    String message = await firebaseService.deleteEntry(id);
    print(message);
    notifyListeners();
  }

// change edit request
  void changeEditRequest(String id, bool editBool) async {
    String message = await firebaseService.changeEditRequest(id, editBool);
    print("Edit Request: " + message);
    notifyListeners();
  }

// change delete request
  void changeDeleteRequest(String id, bool deleteBool) async {
    String message = await firebaseService.changeDeleteRequest(id, deleteBool);
    print("Delete Request: " + message);
    notifyListeners();
  }
}
