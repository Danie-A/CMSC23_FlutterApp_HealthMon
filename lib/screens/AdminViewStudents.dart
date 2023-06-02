import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/UserDetail.dart';
import '../providers/AuthProvider.dart';
import '../providers/UserDetailListProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SigninPage.dart';
import 'UserDetailsPage.dart';

class AdminViewStudents extends StatefulWidget {
  const AdminViewStudents({super.key});

  @override
  State<AdminViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<AdminViewStudents> {
  Future<void> _showStudent(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${name}'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {}, child: const Text("Make Admin")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {},
                child: const Text("Make Entrance Monitor")),
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

  Future<void> _showAddToQuarantine(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${name}'),
          content: const Text(
            'Are you sure you want to add this student to quarantine?',
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {}, child: const Text("Add to Quarantine")),
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

  // ListView viewAllStudents(Stream<QuerySnapshot<Object?>> userDetailStream,
  //     AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {

  // }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> userDetailStream =
        context.watch<UserDetailListProvider>().userDetails1;
    return displayScaffold(context, userDetailStream);
  }

  Scaffold displayScaffold(
      BuildContext context, Stream<QuerySnapshot<Object?>> userDetailStream) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
          ),
          child: Text('Sample Drawer Header'),
        ),
        ListTile(
          title: const Text('View Quarantined Students'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/view-quarantined'); //show qr
          },
        ),
        ListTile(
          title: const Text('View Under Monitoring'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/view-under-monitoring'); //scan qr
          },
        ),
        ListTile(
          title: const Text('Student Requests'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/view-requests'); //go to searchlogs
          },
        ),
        ListTile(
          title: const Text('Back'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
          },
        ),
      ])),
      appBar: AppBar(
        title: Row(children: const [
          Icon(Icons.local_hospital_rounded, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("All Students",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: StreamBuilder(
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

              //just get all users
              return ListView.builder(
                // displays friend names through multiple instances of List Tile
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  UserDetail userDetail = UserDetail.studentFromJson(
                      snapshot.data?.docs[index].data()
                          as Map<String, dynamic>);
                  return (userDetail.userType != "User")

                      //if user is not a regular "User" (meaning student) dont render
                      ? Container()
                      : InkWell(
                          // InkWell widget adds some hover effect to the ListTile
                          onTap: () {
                            _showStudent(context, userDetail.firstName);
                          },
                          hoverColor: Colors.teal[200],
                          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                          splashColor: Colors.teal[
                              100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                          child: ListTile(
                              leading: Icon(Icons.person, color: Colors.teal),
                              title: Text("${userDetail.firstName}"), // name
                              // subtitle: Text("${friend.nickname}"), // filter subtitle
                              trailing: IconButton(
                                icon: const Icon(Icons.coronavirus_rounded),
                                onPressed: () {
                                  _showAddToQuarantine(
                                      context, userDetail.firstName);
                                },
                              )),
                        );
                },
              );
            }),
      ),
    );
  }
}
