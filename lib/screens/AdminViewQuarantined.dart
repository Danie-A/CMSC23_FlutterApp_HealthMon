import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Todo.dart';
import '../providers/TodoListProvider.dart';
import '../providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/UserDetailListProvider.dart';
import 'SigninPage.dart';
import 'UserDetailsPage.dart';

class AdminViewQuarantined extends StatefulWidget {
  const AdminViewQuarantined({super.key});

  @override
  State<AdminViewQuarantined> createState() => _ViewQuarantinedState();
}

class _ViewQuarantinedState extends State<AdminViewQuarantined> {
  List<String> quarantinedStudents = ["Danie", "Sean", "Marcie", "Laydon"];

  Expanded viewAllStudents() {
    return Expanded(
        child: ListView.builder(
      // displays friend names through multiple instances of List Tile
      itemCount: quarantinedStudents.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          // InkWell widget adds some hover effect to the ListTile
          hoverColor: Colors.teal[200],
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Colors.teal[
              100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
          child: ListTile(
              leading: Icon(Icons.person, color: Colors.teal[500]),
              title: Text("${quarantinedStudents[index]}"), // name
              // subtitle: Text("${friend.nickname}"), // filter subtitle
              trailing: IconButton(
                icon: const Icon(
                  Icons.remove_circle_outlined,
                ),
                onPressed: () {
                  setState(() {
                    quarantinedStudents.remove(quarantinedStudents[index]);
                  });
                },
              )),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> userDetailStream =
        context.watch<UserDetailListProvider>().userDetails;
    Stream<User?> userStream = context.watch<AuthProvider>().uStream;

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
            title: const Text('View All Students'),
            onTap: () {
              Navigator.pop(context); //back drawer
              Navigator.pop(context); //back to homepage
              Navigator.pushNamed(context, '/view-students'); //show qr
            },
          ),
          ListTile(
            title: const Text('View Under Monitoring Students'),
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
            Text("Quarantined Students",
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
              return Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                      "Quarantined Student Count: ${quarantinedStudents.length}"),
                  viewAllStudents()
                ],
              );
            }));
  }
}
