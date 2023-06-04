import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:health_monitoring_app/providers/RequestProvider.dart';
import 'package:health_monitoring_app/models/Request.dart';

class ViewRequests extends StatefulWidget {
  const ViewRequests({super.key});

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  List<String> requests = [
    "Danie Araez",
    "Sean Pogi 3000",
    "Marcie Luneza",
    "Laydon Dela Cruz",
    "Ski Concepcion",
    "LeBron James",
    "President Obama"
  ];

  List<bool> isDeleteRequest = [true, false, true, true, false, false, true];

  Future<void> _confirmDelete(BuildContext context, Request request) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // [] SHOW ENTRY DETAILS
          title: Text('Allow ${request.id} to delete his/her entry?'),
          content: Text('By confirming his/her request,\n'
              'you are allowing ${request.id} to delete his/her entry. \n\n'
              'Please be noted that your choice is irrevokable.\n'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {}, child: Text("Allow delete entry")),
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

  Future<void> _confirmEdit(BuildContext context, Request request) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Allow ${request.id} to edit his/her entry?'),
          content: Text('By confirming his/her request,\n'
              'you are allowing ${request.id} to edit his/her entry. \n\n'
              'Please be noted that your choice is irrevokable.\n'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {}, child: Text("Allow edit entry")),
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

  Future<void> _confirmReject(BuildContext context, Request request) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reject ${request.id}'s request?"),
          actions: <Widget>[
            ElevatedButton(onPressed: () => {}, child: Text("Reject request")),
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

  Widget viewAllRequests(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: context.watch<RequestProvider>().requestDetails,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No Requests Found"),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 7);
              },
              // displays friend names through multiple instances of List Tile
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                Request request = Request.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                bool isDelete = request.type == "delete" ? true : false;
                return isDelete
                    ? InkWell(
                        hoverColor: Color.fromARGB(255, 10, 41, 24),
                        // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                        splashColor: Colors
                            .teal, // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              tileColor: Color.fromARGB(255, 239, 224, 224),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 165, 85, 80)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Icon(Icons.delete,
                                  color: Color.fromARGB(255, 165, 85, 80)),
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${request.id}"),
                                    Text("Delete Request",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey))
                                  ]), // name
                              // subtitle: Text("${friend.nickname}"), // filter subtitle
                              trailing: Wrap(spacing: 5, children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.check_circle),
                                  color: Colors.teal,
                                  onPressed: () {
                                    _confirmDelete(context, request);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.cancel),
                                  color: Color.fromARGB(255, 165, 85, 80),
                                  onPressed: () {
                                    _confirmReject(context, request);
                                  },
                                ),
                              ]),
                            )))
                    : InkWell(
                        hoverColor: Color.fromARGB(255, 10, 41, 24),
                        // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                        splashColor: Colors
                            .teal, // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              tileColor: Colors.teal[50],
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Colors.teal),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading:
                                  Icon(Icons.edit_note, color: Colors.teal),
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${request.id}"),
                                    Text("Edit Request",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey))
                                  ]), // name
                              // subtitle: Text("${friend.nickname}"), // filter subtitle
                              trailing: Wrap(spacing: 5, children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.check_circle),
                                  color: Colors.teal,
                                  onPressed: () {
                                    _confirmEdit(context, request);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.cancel),
                                  color: Color.fromARGB(255, 165, 85, 80),
                                  onPressed: () {
                                    _confirmReject(context, request);
                                  },
                                ),
                              ]),
                            )));
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
          ),
          child: Text('\n\n\n\nHealthMon Admin'),
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
          title: const Text('View Quarantined Students'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/view-quarantined'); //scan qr
          },
        ),
        ListTile(
          title: const Text('View Under Monitoring Students'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(
                context, '/view-under-monitoring'); //go to searchlogs
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
          Icon(Icons.pending_actions, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("Student Requests",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 16),
          child: viewAllRequests(context)),
    );
  }
}
