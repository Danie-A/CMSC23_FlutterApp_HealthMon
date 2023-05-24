import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Todo.dart';
import '../providers/TodoListProvider.dart';
import '../providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SigninPage.dart';
import 'UserDetailsPage.dart';

class AdminViewUnderMonitoring extends StatefulWidget {
  const AdminViewUnderMonitoring({super.key});

  @override
  State<AdminViewUnderMonitoring> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<AdminViewUnderMonitoring> {
  List<String> students = ["Danie", "Sean", "Marcie", "Laydon"];

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

  ListView viewAllStudents() {
    return ListView.builder(
      // displays friend names through multiple instances of List Tile
      itemCount: students.length,
      itemBuilder: (context, index) {
        return InkWell(
          // InkWell widget adds some hover effect to the ListTile
          onTap: () {
            _showStudent(context, students[index]);
          },
          hoverColor: Color.fromARGB(255, 10, 41, 24),
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Colors
              .green, // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
          child: ListTile(
              leading: Icon(Icons.person, color: Colors.green),
              title: Text("${students[index]}"), // name
              // subtitle: Text("${friend.nickname}"), // filter subtitle
              trailing: IconButton(
                icon: const Icon(Icons.medication),
                onPressed: () {},
              )),
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
