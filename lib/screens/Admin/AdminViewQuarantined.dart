/*
GROUP 2 MEMBERS (B7L)
>> Araez, Danielle Lei R.
>> Concepcion, Sean Kierby I.
>> Dela Cruz, Laydon Albert L.
>> Luñeza, Marcel Luiz G.

PAGE DESCRIPTION
>> This page is shows the users that have a status of "Quarantined". The Admin can mark the said users as cleared
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/UserDetail.dart';
import '../../providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/UserDetailListProvider.dart';
import '../User/UserDetailsPage.dart';

class AdminViewQuarantined extends StatefulWidget {
  const AdminViewQuarantined({super.key});

  @override
  State<AdminViewQuarantined> createState() => _ViewQuarantinedState();
}

class _ViewQuarantinedState extends State<AdminViewQuarantined> {
  Future<void> _showMovetoCleared(BuildContext context, UserDetail userDetail) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${userDetail.firstName}'),
          content:
              const Text('Are you sure you want to mark this user as cleared?'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
                      context
                          .read<UserDetailListProvider>()
                          .editStatus(userDetail.uid, "Cleared"),
                      Navigator.of(context).pop()
                    },
                child: const Text("Mark as Cleared")),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> userDetailStream =
        context.watch<UserDetailListProvider>().getQuarantinedUsers();
    return displayScaffold(context, userDetailStream);
  }

  Scaffold displayScaffold(
      BuildContext context, Stream<QuerySnapshot<Object?>> userDetailStream) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: const [
            Icon(Icons.local_hospital_rounded, color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("Quarantined Users",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[100],
        ),
        body: StreamBuilder(
            stream: userDetailStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Todos Found"),
                );
              }

              return Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Quarantined Users Count: ${snapshot.data?.docs.length}",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                    // displays friend names through multiple instances of List Tile
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      UserDetail userDetail = UserDetail.studentFromJson(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>);
                      return InkWell(
                        onTap: () {},
                        // InkWell widget adds some hover effect to the ListTile
                        hoverColor: Colors.teal[200],
                        // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                        splashColor: Colors.teal[
                            100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                        child: ListTile(
                            hoverColor: Colors.teal[200],
                            // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                            splashColor: Color(
                                0xFFFBC6A4), // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                            leading:
                                Icon(Icons.person, color: Color(0xFFBE7575)),
                            title: Text("${userDetail.firstName}"), // name
                            // subtitle: Text("${friend.nickname}"), // filter subtitle
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showMovetoCleared(context, userDetail);
                                });
                              },
                            )),
                      );
                    },
                  ))
                ],
              );
            }));
  }
}
