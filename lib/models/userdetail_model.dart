// // only for reference (from to do app)
// // wazzup

// import 'dart:convert';

// class UserDetail {
//   String? id;
//   String firstName;
//   String lastName;
//   String email;

//   UserDetail(
//       {this.id,
//       required this.firstName,
//       required this.lastName,
//       required this.email});

//   // Factory constructor to instantiate object from json format
//   factory UserDetail.fromJson(Map<String, dynamic> json) {
//     return UserDetail(
//       firstName: json['firstName'],
//       id: json['id'],
//       lastName: json['lastName'],
//       email: json['email'],
//     );
//   }

//   static List<UserDetail> fromJsonArray(String jsonData) {
//     final Iterable<dynamic> data = jsonDecode(jsonData);
//     return data.map<UserDetail>((dynamic d) => UserDetail.fromJson(d)).toList();
//   }

//   Map<String, dynamic> toJson(UserDetail userDetail) {
//     return {
//       'firstName': userDetail.firstName,
//       'lastName': userDetail.lastName,
//       'email': userDetail.email,
//     };
//   }
// }
