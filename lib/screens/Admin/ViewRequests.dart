import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:health_monitoring_app/providers/RequestProvider.dart';
import 'package:health_monitoring_app/models/Request.dart';
import 'package:health_monitoring_app/providers/EntryListProvider.dart';
import 'package:health_monitoring_app/models/Entry.dart';
import 'package:intl/intl.dart';
import 'package:health_monitoring_app/providers/UserDetailListProvider.dart';

import '../../providers/AuthProvider.dart';

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

  var today = new DateTime.now();
  var dateToday;

  List<bool> isDeleteRequest = [true, false, true, true, false, false, true];

  Future<void> _confirmDelete(BuildContext context, Request request) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('Allow ${request.requester_name} to delete his/her entry?'),
          content: Text('By confirming his/her request,\n'
              'you are allowing ${request.requester_name} to delete his/her entry. \n\n'
              'Please be noted that your choice is irrevokable.\n'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
                      context
                          .read<EntryListProvider>()
                          .deleteEntry(request.entry_id!),
                      context
                          .read<RequestProvider>()
                          .deleteRequest(request.id!),
                      context
                          .read<UserDetailListProvider>()
                          .editStatus(request.entry![13], "No Health Entry"),
                      context.read<UserDetailListProvider>().editLatestEntry(
                          context.read<AuthProvider>().userId, ""),
                      Navigator.of(context).pop()
                    },
                child: Text("Allow delete entry")),
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
          title: Text('Allow ${request.requester_name} to edit his/her entry?'),
          content: Text('By confirming his/her request,\n'
              'you are allowing ${request.requester_name} to edit his/her entry. \n\n'
              'Please be noted that your choice is irrevokable.\n'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close")),
            const SizedBox(height: 10),
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Edit Entry'),
              onPressed: () {
                // get request.entry details and place it in Entry entry form
                Entry editedEntry = new Entry(
                  fever: request.entry![0],
                  feverish: request.entry![1],
                  muscle_joint_pain: request.entry![2],
                  cough: request.entry![3],
                  cold: request.entry![4],
                  sore_throat: request.entry![5],
                  difficulty_breathing: request.entry![6],
                  diarrhea: request.entry![7],
                  loss_taste: request.entry![8],
                  loss_smell: request.entry![9],
                  has_symptoms: request.entry![10],
                  had_contact: request.entry![11],
                  status: request.entry![12],
                  user_key: request.entry![13],
                  edit_request: request.entry![14],
                  delete_request: request.entry![15],
                  entry_date: request.entry![16],
                  id: request.entry_id,
                );
                context.read<EntryListProvider>().editEntry(editedEntry);
                // remove from request list
                context.read<RequestProvider>().deleteRequest(request.id!);

                if (dateToday == editedEntry.entry_date) {
                  // change user detail status to edited status in entry
                  context
                      .read<UserDetailListProvider>()
                      .editStatus(editedEntry.user_key, editedEntry.status);
                }

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
          title: Text("Reject ${request.requester_name}'s request?"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Entry editedEntry = new Entry(
                    fever: request.entry![0],
                    feverish: request.entry![1],
                    muscle_joint_pain: request.entry![2],
                    cough: request.entry![3],
                    cold: request.entry![4],
                    sore_throat: request.entry![5],
                    difficulty_breathing: request.entry![6],
                    diarrhea: request.entry![7],
                    loss_taste: request.entry![8],
                    loss_smell: request.entry![9],
                    has_symptoms: request.entry![10],
                    had_contact: request.entry![11],
                    status: request.entry![12],
                    user_key: request.entry![13],
                    edit_request: false,
                    delete_request: false,
                    entry_date: request.entry![16],
                    id: request.entry_id,
                  );
                  context.read<EntryListProvider>().editEntry(editedEntry);
                  context.read<RequestProvider>().deleteRequest(request.id!);
                  Navigator.pop(context);
                  // set entry's edit_request or delete_request to false
                },
                child: Text("Reject request")),
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

                if (request.date != dateToday) {
                  context.read<RequestProvider>().deleteRequest(request.id!);
                  return Container();
                } else {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${request.requester_name}"),
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
                                  side:
                                      BorderSide(width: 1, color: Colors.teal),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading:
                                    Icon(Icons.edit_note, color: Colors.teal),
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${request.requester_name}"),
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
                }
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    dateToday = DateFormat.yMMMMd('en_US').format(today);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: const [
          Icon(Icons.pending_actions, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("Entry Requests",
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
