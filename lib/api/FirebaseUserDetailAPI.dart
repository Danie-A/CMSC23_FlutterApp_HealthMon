import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserDetailAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // Query filteredQuery =
  //     db.collection('userDetails').where('studentNo', isEqualTo: studentNumber);

  Stream<QuerySnapshot> getSortStudentNo() {
    Stream<QuerySnapshot> filteredStream = db
        .collection('userDetails')
        .where('userType', isEqualTo: 'User')
        .orderBy('studentNo')
        .snapshots();
    return filteredStream;
  }

  Stream<QuerySnapshot> getSortDate() {
    Stream<QuerySnapshot> filteredStream = db
        .collection('userDetails')
        .where('userType', isEqualTo: 'User')
        .orderBy("latestEntry", descending: true)
        .snapshots();
    return filteredStream;
  }

  Stream<QuerySnapshot> getSortCourse(String course) {
    Stream<QuerySnapshot> filteredStream = db
        .collection('userDetails')
        .where('userType', isEqualTo: 'User')
        .where('course', isEqualTo: course)
        .snapshots();
    return filteredStream;
  }

  Stream<QuerySnapshot> getSortCollege(String college) {
    Stream<QuerySnapshot> filteredStream = db
        .collection('userDetails')
        .where('userType', isEqualTo: 'User')
        .where('college', isEqualTo: college)
        .snapshots();
    return filteredStream;
  }

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

  Future<String> editStatus(String uid, String newStatus) async {
    try {
      var userDetail =
          await db.collection("userDetails").where("uid", isEqualTo: uid).get();
      userDetail.docs.forEach((doc) {
        doc.reference.set(
          {
            'status': newStatus,
          },
          SetOptions(merge: true),
        );
      });

      return "Successfully edited user detail status!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editUserType(String uid, String newUserType) async {
    try {
      var userDetail =
          await db.collection("userDetails").where("uid", isEqualTo: uid).get();
      userDetail.docs.forEach((doc) {
        doc.reference.set(
          {
            'userType': newUserType,
          },
          SetOptions(merge: true),
        );
      });

      return "Successfully edited user type!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editLatestEntry(String uid, String newLatestEntry) async {
    try {
      var userDetail =
          await db.collection("userDetails").where("uid", isEqualTo: uid).get();
      userDetail.docs.forEach((doc) {
        doc.reference.set(
          {
            'latestEntry': newLatestEntry,
          },
          SetOptions(merge: true),
        );
      });

      return "Successfully edited user detail latest entry date to ${newLatestEntry}!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> getCurrentId(String uid) async {
    String id = "";

    try {
      var userDetail =
          await db.collection("userDetails").where("uid", isEqualTo: uid).get();

      userDetail.docs.forEach((doc) {
        id = doc.id;
        print("[API] id of userdetail is: $id");
      });
    } catch (e) {
      print("Error retrieving current ID: $e");
      // Handle the error or return a default value, if applicable
    }

    return id;
  }

  Future<String> getUserStatus(String uid) async {
    String status = "";

    try {
      var userDetail =
          await db.collection("userDetails").where("uid", isEqualTo: uid).get();

      userDetail.docs.forEach((doc) {
        status = doc.data()['status'];
        print("[API] user status is: $status");
      });
    } catch (e) {
      print("Error retrieving current ID: $e");
      // Handle the error or return a default value, if applicable
    }

    return status;
  }

  Stream<QuerySnapshot> getAllUserDetails() {
    return db.collection("userDetails").snapshots();
  }

  Stream<QuerySnapshot> getCurrentUserDetail(String uid) {
    return db
        .collection("userDetails")
        .where("uid", isEqualTo: uid)
        .limit(1)
        .snapshots();
  }

  DocumentReference getSpecificUser(String id) {
    print(FirebaseFirestore.instance.collection("userDetails").doc(id));
    return FirebaseFirestore.instance.collection("userDetails").doc(id);
  }

  Future<String> deleteUserDetail(String? id) async {
    try {
      await db.collection("userDetails").doc(id).delete();

      return "Successfully deleted user detail!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> addLocation(String uid, String location) async {
    try {
      var userDetail =
          await db.collection("userDetails").where("uid", isEqualTo: uid).get();
      userDetail.docs.forEach((doc) {
        doc.reference.set(
          {
            'location': location,
          },
          SetOptions(merge: true),
        );
      });

      return "Successfully added user detail location!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  // Future<String> editStatus(String? id, String status) async {
  //   try {
  //     await db.collection("userDetails").doc(id).update({"status": status});
  //     return "Successfully edited status of user!";
  //   } on FirebaseException catch (e) {
  //     return "Failed with error '${e.code}: ${e.message}";
  //   }
  // }
}
