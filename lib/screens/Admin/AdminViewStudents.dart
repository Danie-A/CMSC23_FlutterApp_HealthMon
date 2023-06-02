import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/UserDetail.dart';
import '../../providers/UserDetailListProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/AuthProvider.dart';

class AdminViewStudents extends StatefulWidget {
  const AdminViewStudents({super.key});

  @override
  State<AdminViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<AdminViewStudents> {
  Future<void> _showStudent(BuildContext context, UserDetail userDetail) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${userDetail.firstName} ${userDetail.lastName}'),
          content: Text(
            'Email: ${userDetail.email}\n'
            'Username: ${userDetail.username}\n'
            'College: ${userDetail.college}\n'
            'Course: ${userDetail.course}\n'
            'Student No: ${userDetail.studentNo}\n'
            'Pre-Existing Illness: ${userDetail.preExistingIllness}\n'
            'Latest Entry Date: ${userDetail.latestEntry}\n',
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
                      context
                          .watch<UserDetailListProvider>()
                          .changeUserType(userDetail.uid, "Admin"),
                      Navigator.of(context).pop()
                    },
                child: const Text("Make Admin")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {
                      context
                          .watch<UserDetailListProvider>()
                          .changeUserType(userDetail.uid, "Entrance Monitor"),
                      Navigator.of(context).pop()
                    },
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

  List<String> filterBy = [
    'Student Number',
    'Date',
    'Course',
    'College',
  ];

  String filterValue = '';

  Future<void> _showAddToQuarantine(
      BuildContext context, UserDetail userDetail) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${userDetail.firstName}'),
          content: const Text(
            'Are you sure you want to add this student to quarantine?',
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
                      context
                          .watch<UserDetailListProvider>()
                          .editStatus(userDetail.uid, "Quarantined"),
                      Navigator.of(context).pop()
                    },
                child: const Text("Add to Quarantine")),
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

  Widget _showStream(
      BuildContext context, Stream<QuerySnapshot> userDetailStream) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: StreamBuilder(
        stream: userDetailStream,
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
              child: Text("No User Details Found"),
            );
          }

          List<UserDetail> userDetailsList =
              []; // Declare an empty list of user details

          int? numUsersNull = snapshot.data?.docs.length;
          int numUsers = 0;
          if (numUsersNull != null) {
            numUsers = numUsersNull;
            for (int i = 0; i < numUsers; i++) {
              UserDetail userDetail = UserDetail.studentFromJson(
                snapshot.data?.docs[i].data() as Map<String, dynamic>,
              );
              // Add userDetail to the list
              if (userDetail.userType != "User") {
                userDetailsList.add(userDetail);
              }

              // click filter by student number
              // rebuild listview builder
            }
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Filter By: "),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownColor: Colors.teal[100],
                    underline: SizedBox.shrink(),
                    value: filterValue,
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.teal),
                    onChanged: (String? newValue) {
                      setState(() {
                        filterValue = newValue!;
                        if (filterValue == 'Student Number') {
                          userDetailsList.sort(
                              (a, b) => a.studentNo!.compareTo(b.studentNo!));
                        }
                      });
                    },
                    items:
                        filterBy.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('  $value'),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  // displays friend names through multiple instances of List Tile
                  itemCount: userDetailsList.length,
                  itemBuilder: (context, index) {
                    UserDetail userDetail = userDetailsList[index];
                    return InkWell(
                      // InkWell widget adds some hover effect to the ListTile
                      onTap: () {
                        _showStudent(context, userDetail);
                      },
                      hoverColor: Colors.teal[200],
                      // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                      splashColor: Colors.teal[
                          100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                      child: ListTile(
                        leading: Icon(Icons.person, color: Colors.teal),
                        title: Text(
                            "${userDetail.studentNo} - ${userDetail.username}"), // name
                        // subtitle: Text("${friend.nickname}"), // filter subtitle
                        trailing: IconButton(
                          icon: const Icon(Icons.coronavirus_rounded),
                          onPressed: () {
                            _showAddToQuarantine(context, userDetail);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void initState() {
    super.initState();
    filterValue = filterBy.first;
  }

  @override
  Widget build(BuildContext context) {
    var filter = DropdownButton<String>(
        borderRadius: BorderRadius.circular(20),
        value: filterValue,
        icon: const Icon(Icons.arrow_drop_down),
        dropdownColor: Colors.teal[100],
        underline: SizedBox.shrink(),
        onChanged: (newValue) {
          // This is called when the user selects an item.
          setState(() {
            filterValue = newValue.toString();
          });
        },
        items: filterBy.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '$value',
                  style: const TextStyle(fontSize: 14),
                ),
              ));
        }).toList());

    Stream<QuerySnapshot> userDetailStream =
        context.watch<UserDetailListProvider>().userDetails2;
    return displayScaffold(context, userDetailStream);
  }

  Scaffold displayScaffold(
      BuildContext context, Stream<QuerySnapshot<Object?>> userDetailStream) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
            ),
            child: Text('HealthMon'),
          ),
          ListTile(
            title: const Text('View Quarantined Students'),
            onTap: () {
              Navigator.pop(context); //back drawer
              Navigator.pop(context); //back to homepage
              Navigator.pushNamed(context, '/view-quarantined'); //show qr
            },
          ),
          ListTile(
            title: const Text('View Under Monitoring'),
            onTap: () {
              Navigator.pop(context); //back drawer
              Navigator.pop(context); //back to homepage
              Navigator.pushNamed(context, '/view-under-monitoring'); //scan qr
            },
          ),
          ListTile(
            title: const Text('Student Requests'),
            onTap: () {
              Navigator.pop(context); //back drawer
              Navigator.pop(context); //back to homepage
              Navigator.pushNamed(context, '/view-requests'); //go to searchlogs
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
            Icon(Icons.people_outline_rounded, color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("All Students",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[100],
        ),
        body: Column(
          children: [
            SizedBox(height: 8),
            // ElevatedButton(
            //     onPressed: () => {}, child: Text("Filter by Student Number")),
            // SizedBox(height: 18),
            // ElevatedButton(onPressed: () => {}, child: Text("Filter by Date")),
            // SizedBox(height: 18),
            // ElevatedButton(
            //     onPressed: () => {}, child: Text("Filter by Course")),
            // SizedBox(height: 18),
            // ElevatedButton(
            //     onPressed: () => {}, child: Text("Filter by College")),
            // SizedBox(height: 18),
            Expanded(
              child: _showStream(context, userDetailStream),
            )
          ],
        ));
  }
}
