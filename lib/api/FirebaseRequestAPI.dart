import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRequestAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllRequests() {
    return db.collection("requests").snapshots();
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
