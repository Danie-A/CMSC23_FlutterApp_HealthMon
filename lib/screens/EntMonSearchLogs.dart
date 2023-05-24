import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Todo.dart';
import '../providers/TodoListProvider.dart';
import '../providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SigninPage.dart';
import 'UserDetailsPage.dart';

class EntMonSearchLogs extends StatefulWidget {
  const EntMonSearchLogs({super.key});

  @override
  State<EntMonSearchLogs> createState() => _EntMonSearchLogsState();
}

class _EntMonSearchLogsState extends State<EntMonSearchLogs> {
  List<String> students = ["Danie", "Sean", "Marcie", "Laydon"];
  List<int> studentNum = [1, 2, 3, 4];

  ListView viewAllStudents() {
    return ListView.builder(
      // displays friend names through multiple instances of List Tile
      itemCount: students.length,
      itemBuilder: (context, index) {
        return InkWell(
          // InkWell widget adds some hover effect to the ListTile
          onTap: () {},
          hoverColor: Colors.teal[100],
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Colors.teal[
              100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.teal),
            title: Text("${students[index]}"), // name
            // subtitle: Text("${friend.nickname}"), // filter subtitle
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchLogsController = TextEditingController();

    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
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
            Icon(Icons.screen_search_desktop_outlined,
                color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("Search Logs",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[100],
        ),
        body: Column(children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _searchLogsController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Expanded(child: viewAllStudents()),
        ]));
  }
}
