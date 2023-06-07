/*
GROUP 2 MEMBERS (B7L) FirebaseEntryAPI.dart

Araez, Danielle Lei R.
Concepcion, Sean Kierby I.
Dela Cruz, Laydon Albert L.
Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
This is where the entrance monitor can add log.

*/

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/models/Log.dart';
import 'package:health_monitoring_app/models/UserDetail.dart';
import 'package:health_monitoring_app/providers/LogProvider.dart';
import 'package:health_monitoring_app/providers/UserDetailListProvider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddLog extends StatelessWidget {
  final String data;
  AddLog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> user = data.split('\n');
    UserDetail? entmon = context.read<UserDetailListProvider>().currentUser;
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String logDateTime = formatter.format(now);

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Icon(Icons.domain_rounded, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("Add Student Log",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[200],
      ),
      backgroundColor: Colors.teal[100],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.live_help, color: Color(0xFF004D40)),
                SizedBox(height: 20),
                Text(
                  'Are you sure you want to add a log for ${user[0]}?',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Student Number:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Status:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${user[0]}', style: TextStyle(fontSize: 18)),
                        Text('${user[1]}', style: TextStyle(fontSize: 18)),
                        Text('${user[2]}', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Log log = new Log(
                location: entmon!.location!,
                studentName: user[0],
                studentNo: int.parse(user[1]),
                status: user[2],
                logDate: logDateTime,
              );
              if (user[2] == 'Cleared') {
                // only add log if status is cleared
                context.read<LogProvider>().addLogDetail(log);
              }
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
