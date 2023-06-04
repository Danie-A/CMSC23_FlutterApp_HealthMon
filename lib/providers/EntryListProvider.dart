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

  fetchEntryDetails() {
    _entryStream = firebaseService.getAllEntries();
    notifyListeners();
  }

  setCurrentEntry(Entry entry) async {
    currentEntry = await entry;
    notifyListeners();
  }

  get getEntry => currentEntry;

  get entryId => _entryId;

  void addEntryDetail(Entry entry) async {
    String entryId = await firebaseService.addEntry(entry.entryToJson(entry));
    _entryId = entryId;
    print(entryId);
    print(currentEntry);
    notifyListeners();
  }

  // REMINDER: STILL NEED editEntry method

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
}
