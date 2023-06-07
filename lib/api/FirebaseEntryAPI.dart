/*
GROUP 2 MEMBERS (B7L) FirebaseEntryAPI.dart

Araez, Danielle Lei R.
Concepcion, Sean Kierby I.
Dela Cruz, Laydon Albert L.
Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
This will get the stream for "entries". Additionally relative functions such as setting, deleting and updating the "entries".

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Entry.dart';

class FirebaseEntryAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addEntry(Map<String, dynamic> entry) async {
    try {
      final docRef = await db.collection("entries").add(entry);
      await db.collection("entries").doc(docRef.id).update({'id': docRef.id});
      return "${docRef.id}"; // return id of entry
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllEntries() {
    return db
        .collection("entries")
        .orderBy("entry_date", descending: true)
        .snapshots();
  }

  Future<List> getEntriesList() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await db.collection("entries").get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  // Replace with the actual document ID of the entry

  Future<Map<String, dynamic>?> getEntry(String entryId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await db.collection("entries").doc(entryId).get();

      if (snapshot.exists) {
        // Entry found
        Map<String, dynamic> entryData = snapshot.data()!;

        return entryData;

        // Process the entry data as needed
        // For example, access specific fields like entryData['field_name']
      } else {
        // Entry does not exist
        print('Entry not found');
        return null;
      }
    } catch (e) {
      // Error occurred
      print('Error retrieving entry: $e');
      return null;
    }
  }

  Future<String> deleteEntry(String? id) async {
    try {
      await db.collection("entries").doc(id).delete();

      return "Successfully deleted entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editEntry(Entry entry) async {
    try {
      await db.collection("entries").doc(entry.id).update({
        'fever': entry.fever,
        'feverish': entry.feverish,
        'muscle_joint_pain': entry.muscle_joint_pain,
        'cough': entry.cough,
        'cold': entry.cold,
        'sore_throat': entry.sore_throat,
        'difficulty_breathing': entry.difficulty_breathing,
        'diarrhea': entry.diarrhea,
        'loss_taste': entry.loss_taste,
        'loss_smell': entry.loss_smell,
        'has_symptoms': entry.has_symptoms,
        'had_contact': entry.had_contact,
        'status': entry.status,
        'user_key': entry.user_key,
        'edit_request': false, // set the edit request to false after editing
        'delete_request': false,
        'entry_date': entry.entry_date
      });

      return "Successfully edited entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> changeEditRequest(String eid, bool editBool) async {
    try {
      var entry =
          await db.collection("entries").where("id", isEqualTo: eid).get();
      entry.docs.forEach((doc) {
        doc.reference.set(
          {
            'edit_request': editBool,
          },
          SetOptions(merge: true),
        );
      });

      return "Successfully edited edit_request to ${editBool}!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> changeDeleteRequest(String eid, bool deleteBool) async {
    try {
      var entry =
          await db.collection("entries").where("id", isEqualTo: eid).get();
      entry.docs.forEach((doc) {
        doc.reference.set(
          {
            'delete_request': deleteBool,
          },
          SetOptions(merge: true),
        );
      });

      return "Successfully edited edit_request to ${deleteBool}!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
