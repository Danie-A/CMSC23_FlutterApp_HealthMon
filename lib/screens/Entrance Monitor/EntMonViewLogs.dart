import 'package:flutter/material.dart';
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
  Future<void> _showLog(BuildContext context, String location) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${location}'),
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
          Text("All Logs",
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
            stream: logStream,
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
                  Log log = Log.logFromJson(snapshot.data?.docs[index].data()
                      as Map<String, dynamic>);
                  return InkWell(
                      // InkWell widget adds some hover effect to the ListTile
                      onTap: () {
                        _showLog(context, log.location);
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
                            Text('${log.location}'),
                            SizedBox(width: 15),
                            Text('${log.studentNo}'),
                            SizedBox(width: 15),
                            Text('Janaury 31, 2024'),
                          ]), // name
                          title: Row(children: [
                            Text(
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                '${log.studentName}'),
                          ]),
                          trailing: Text(
                              style: TextStyle(
                                  fontSize: 17, fontStyle: FontStyle.italic),
                              '${log.status}'),
                        ),
                      ));
                },
              );
            }),
      ),
    );
  }
}
