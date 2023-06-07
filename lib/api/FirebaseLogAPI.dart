/*
GROUP 2 MEMBERS (B7L)

Araez, Danielle Lei R.
Concepcion, Sean Kierby I.
Dela Cruz, Laydon Albert L.
Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
This will get the stream for "logs". Additionally relative functions such as setting, deleting and updating the "logs".
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLogAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addLog(Map<String, dynamic> log) async {
    try {
      await db.collection("logs").add(log);

      return "Successfully added log!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllLogs() {
    return db
        .collection("logs")
        .orderBy("logDate", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getSearchedLogs() {
    Stream<QuerySnapshot> searchedStream =
        db.collection('logs').where('status', isEqualTo: "Cleared").snapshots();
    return searchedStream;
  }

  Future<List> getLogsList() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await db.collection("logs").get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<String> deleteLog(String? id) async {
    try {
      await db.collection("logs").doc(id).delete();

      return "Successfully deleted log!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  /*
  Future<String> editLog(String? id, String title) async {
    try {
      print("New String: $title");
      await db.collection("logs").doc(id).update({"title": title});

      return "Successfully edited log!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
  */
}
