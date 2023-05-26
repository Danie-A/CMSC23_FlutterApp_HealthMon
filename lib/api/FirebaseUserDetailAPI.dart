
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserDetailAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addUserDetail(Map<String, dynamic> userDetail) async {
    try {
      final docRef = await db.collection("userDetails").add(userDetail);
      await db
          .collection("userDetails")
          .doc(docRef.id)
          .update({'id': docRef.id});

      return "Successfully added user detail!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllUserDetails() {
    return db.collection("userDetails").snapshots();
  }

  

  Future<String> deleteUserDetail(String? id) async {
    try {
      await db.collection("userDetails").doc(id).delete();

      return "Successfully deleted user detail!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
