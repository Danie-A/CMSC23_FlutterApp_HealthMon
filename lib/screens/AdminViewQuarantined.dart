import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Todo.dart';
import '../providers/TodoListProvider.dart';
import '../providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Details'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const UserDetailsPage()));
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // context.read<AuthProvider>().signOut();
              // Navigator.pop(context);
            },
          ),
        ])),
        appBar: AppBar(
          title: Row(children: const [
            Icon(Icons.local_hospital_rounded, color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("View Quarantined Students",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[100],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Text("Quarantined Student count: ${quarantinedStudents.length}"),
            viewAllStudents()
          ],
        ));
  }
}