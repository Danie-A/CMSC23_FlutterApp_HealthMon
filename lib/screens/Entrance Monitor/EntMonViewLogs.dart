/*
GROUP 2 MEMBERS (B7L)
>> Araez, Danielle Lei R.
>> Concepcion, Sean Kierby I.
>> Dela Cruz, Laydon Albert L.
>> Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
>> This page is unique to entrance monitor accounts as this allows viewing of logs registered in the firebase.
*/

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/models/UserDetail.dart';
import 'package:health_monitoring_app/providers/UserDetailListProvider.dart';
import 'package:provider/provider.dart';
import '../../models/Log.dart';
import '../../providers/LogProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntMonViewLogs extends StatefulWidget {
  const EntMonViewLogs({super.key});

  @override
  State<EntMonViewLogs> createState() => _EntMonViewLogsState();
}

class _EntMonViewLogsState extends State<EntMonViewLogs> {
  Future<void> _showLog(BuildContext context, Log log) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${log.studentName}'),
          content: Text('Name: ${log.studentName} \n'
              'Number: ${log.studentNo}\n'
              'Location: ${log.location}\n'
              'DateTime: ${log.logDate}\n'),
          actions: <Widget>[
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

  /*
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
  */

  // ListView viewAllStudents(Stream<QuerySnapshot<Object?>> userDetailStream,
  //     AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {

  // }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> logStream = context.watch<LogProvider>().logDetails;
    return displayScaffold(context, logStream);
  }

  Scaffold displayScaffold(
      BuildContext context, Stream<QuerySnapshot> logStream) {
    UserDetail? entmon = context.read<UserDetailListProvider>().currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Row(children: const [
            Icon(Icons.domain_rounded, color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("All Logs",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[100],
        ),
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOCATION: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text('${entmon?.location}'),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: StreamBuilder(
                  stream: logStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error encountered! ${snapshot.error}"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
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
                        Log log = Log.logFromJson(snapshot.data?.docs[index]
                            .data() as Map<String, dynamic>);
                        if (log.location == entmon?.location) {
                          // only show those who have entered the building where entrance monitor is located
                          return InkWell(
                              // InkWell widget adds some hover effect to the ListTile
                              onTap: () {
                                _showLog(context, log);
                              },
                              hoverColor: Colors.teal[200],
                              // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                              splashColor: Colors.teal[
                                  100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                child: ListTile(
                                  leading: Icon(Icons.folder_shared_outlined,
                                      color: Colors.teal),
                                  subtitle: Row(children: [
                                    SizedBox(width: 3),
                                    Text('${log.logDate}',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ]), // name
                                  title: Row(children: [
                                    Text(
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                        '${log.studentName}'),
                                    SizedBox(width: 3),
                                    Text(
                                      '${log.studentNo}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ]),
                                  trailing: Text(
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontStyle: FontStyle.italic),
                                      '${log.status}'),
                                ),
                              ));
                        } else {
                          return Container();
                        }
                      },
                    );
                  }),
            ),
          )
        ]));
  }
}
