import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRequestAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllRequests() {
    return db.collection("requests").snapshots();
  }

  Future<String> addRequest(Map<String, dynamic> request) async {
    try {
      await db.collection("requests").add(request);

      return "Successfully added request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> deleteRequest(String? id) async {
    try {
      await db.collection("requests").doc(id).delete();

      return "Successfully deleted request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
