import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_app/providers/LogProvider.dart';
import 'package:provider/provider.dart';

import '../../models/Log.dart';

class EntMonSearchLogs extends StatefulWidget {
  const EntMonSearchLogs({super.key});

  @override
  State<EntMonSearchLogs> createState() => _EntMonSearchLogsState();
}

class _EntMonSearchLogsState extends State<EntMonSearchLogs> {
  TextEditingController _searchLogsController = TextEditingController();
  var text = "";

  @override
  void initState() {
    // Perform setup tasks or side effects
    super.initState();
    _searchLogsController.addListener(() {
      _handleSearchChange();
    });
  }

  @override
  void dispose() {
    // Clean up resources or cancel any subscriptions
    super.dispose();
    _searchLogsController.removeListener(() {
      _handleSearchChange();
    });
    _searchLogsController.dispose();
  }

  _handleSearchChange() {
    setState(() {
      text = _searchLogsController.text;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot>? searchedLogStream =
        context.watch<LogProvider>().searchedLogStream;
    return Scaffold(
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
        body: StreamBuilder(
            stream: searchedLogStream,
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
              return Column(children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _searchLogsController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search, color: Color(0xFF004D40))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  // displays friend names through multiple instances of List Tile
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Log log = Log.logFromJson(snapshot.data?.docs[index].data()
                        as Map<String, dynamic>);
                    return ((!log.studentName
                            .toString()
                            .toLowerCase()
                            .contains(text))
                        ? Container()
                        : InkWell(
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
                                  Text('${log.studentNo}'),
                                  SizedBox(width: 15),
                                  Text('Janaury 31, 2024'),
                                ]), // name
                                title: Row(children: [
                                  Text(
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      '${log.studentName}'),
                                ]),
                                trailing: Text(
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.italic),
                                    '${log.status}'),
                              ),
                            )));
                  },
                )),
              ]);
            }));
  }
}
