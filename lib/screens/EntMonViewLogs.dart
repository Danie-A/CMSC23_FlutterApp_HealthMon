import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Todo.dart';
import '../providers/TodoListProvider.dart';
import '../providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SigninPage.dart';
import 'UserDetailsPage.dart';

class EntMonViewLogs extends StatefulWidget {
  const EntMonViewLogs({super.key});

  @override
  State<EntMonViewLogs> createState() => _ViewStudentsState();
}

// MAKE LISTTILES OF DETAILS W TRAILING ICON FOR EDIT
class _ViewStudentsState extends State<EntMonViewLogs> {
  List<Map<String, String>> dataArray = [
    {
      'location': 'New York',
      'name': 'John Doe',
      'studentNo': '123456789',
      'date': '2023-05-25',
      'time': '12:30 PM',
      'status': 'completed',
    },
    {
      'location': 'London',
      'name': 'Jane Smith',
      'studentNo': '987654321',
      'date': '2023-05-26',
      'time': '09:45 AM',
      'status': 'under monitoring',
    },
    {
      'location': 'Paris',
      'name': 'David Johnson',
      'studentNo': '456789123',
      'date': '2023-05-27',
      'time': '02:15 PM',
      'status': 'quarantined',
    },
    {
      'location': 'Tokyo',
      'name': 'Emily Brown',
      'studentNo': '789123456',
      'date': '2023-05-28',
      'time': '07:00 AM',
      'status': 'completed',
    },
    {
      'location': 'Sydney',
      'name': 'Michael Wilson',
      'studentNo': '654321987',
      'date': '2023-05-29',
      'time': '04:30 PM',
      'status': 'under monitoring',
    },
    // Add more elements as needed...
  ];

  Future<void> _showStudent(BuildContext context, Map datum) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${datum['name']}'),

          // ANG LAKI NG CONTENT !!!! BAKIT ?
          content: Column(
            children: [
              Text("${datum["name"]}"),
              Text("${datum["studentNo"]}"),
              Text("${datum["date"]}"),
              Text("${datum["time"]}"),
              Text("${datum["status"]}"),
            ],
          ),
          actions: [
            TextButton(
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

  ListView viewAllLogs() {
    return ListView.builder(
      // displays friend names through multiple instances of List Tile
      itemCount: dataArray.length,
      itemBuilder: (context, index) {
        return InkWell(
          // InkWell widget adds some hover effect to the ListTile
          onTap: () {
            _showStudent(context, dataArray[index]);
          },
          hoverColor: Colors.teal[200],
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Colors.teal[
              100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
          child: ListTile(
            leading: Icon(
              Icons.folder_shared_outlined,
              color: Colors.teal,
            ),
            title: Text(
                "${dataArray[index]["name"]}: ${dataArray[index]["location"]}, ${dataArray[index]["date"]}"), // name
            // subtitle: Text("${friend.nickname}"), // filter subtitle
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var dateToday = DateTime.now();

    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
          ),
          child: Text('${dateToday} Sample Drawer Header'),
        ),
        ListTile(
          title: const Text('Show QR'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/show-qr'); //show qr
          },
        ),
        ListTile(
          title: const Text('Scan QR'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/scan-qr'); //scan qr
          },
        ),
        ListTile(
          title: const Text('Search Logs'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/search-logs'); //go to searchlogs
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
          Text("View Logs",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 16), child: viewAllLogs()),
    );
  }
}
