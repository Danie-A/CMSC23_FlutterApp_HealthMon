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
This will get the stream for "requests". Additionally relative functions such as setting, deleting and updating the "requests".
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRequestAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllRequests() {
    return db
        .collection("requests")
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<String> addRequest(Map<String, dynamic> request) async {
    try {
      final docRef = await db.collection("requests").add(request);
      await db.collection("requests").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added request with id: ${docRef.id}";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> deleteRequest(String? id) async {
    try {
      await db.collection("requests").doc(id).delete();

      return "Successfully deleted request! Request ID: ${id}";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
