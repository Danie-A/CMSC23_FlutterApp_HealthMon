import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Entry.dart';
import '../api/FirebaseEntryAPI.dart';

class EntryListProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _entryStream;
  Entry ?currentEntry;

  EntryListProvider() {
    firebaseService = FirebaseEntryAPI();
    fetchEntryDetails();
  }

  // getter
  Stream<QuerySnapshot> get userDetails => _entryStream;

  fetchEntryDetails() {
    _entryStream = firebaseService.getAllEntries();
    notifyListeners();
  }

  setCurrentEntry(Entry entry){
    currentEntry = entry;
    notifyListeners();
  }

  getCurrentEntry(){
    return currentEntry;
  }



  void addEntryDetail(Entry entry) async {
    String message = await firebaseService.addEntry(entry.entryToJson(entry));
    setCurrentEntry(entry);
    print(message);
    print(currentEntry);
    notifyListeners();
  }

  // REMINDER: STILL NEED editEntry method

  void editEntry(String id, String newTitle) async {
     String message = await firebaseService.editEntry(id, newTitle);
     print(message);
     notifyListeners();
  }

  void deleteEntry(String id) async {
    String message = await firebaseService.deleteEntry(id);
    print(message);
    notifyListeners();
  }
}
