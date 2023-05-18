import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/signin.dart';
import 'user_details.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  List<String> students = ["Danie", "Sean", "Marcie", "Laydon"];

  ListView viewAllStudents() {
    return ListView.builder(
      // displays friend names through multiple instances of List Tile
      itemCount: students.length,
      itemBuilder: (context, index) {
        return InkWell(
          // InkWell widget adds some hover effect to the ListTile
          onTap: () {
            // handles the tap event
            // Navigator.pushNamed(context, '/friendDetails', arguments: friend);
          },
          hoverColor: Color.fromARGB(255, 10, 41, 24),
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Colors
              .green, // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.green),
            title: Text("${students[index]}"), // name
            // subtitle: Text("${friend.nickname}"), // filter subtitle
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
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
        backgroundColor: Color.fromARGB(255, 10, 41, 24),
        title: Row(children: const [
          Icon(Icons.contact_mail_outlined, color: Colors.green),
          SizedBox(width: 14),
          Text(
            "View Students",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 16), child: viewAllStudents()),
    );
  }
}
