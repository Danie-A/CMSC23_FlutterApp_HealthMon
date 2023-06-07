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
>> This page is the main homepage of all users.

>> It shows the consoles for admin and entrance monitor if that is their user type, respectively.

*/

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/models/Entry.dart';
import 'package:health_monitoring_app/models/UserDetail.dart';
import 'package:health_monitoring_app/providers/EntryListProvider.dart';
import 'package:health_monitoring_app/providers/UserDetailListProvider.dart';
import 'package:health_monitoring_app/screens/admin/AdminConsole.dart';
import 'package:health_monitoring_app/screens/Entrance Monitor/EntranceMonitorConsole.dart';
import 'package:intl/intl.dart';
import 'SigninPage.dart';
import '../providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User/HealthEntry.dart';
import '../providers/RequestProvider.dart';
import '../models/Request.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String uid = "";
  String id = "";
  String data = "";
  var today;
  String dateToday = "";
  String currentEntryId = "";
  String fullName = '';
  bool isRequestPending = false; // Variable to track if a request is pending

  Future<void> _alreadySubmittedRequestPrompt(BuildContext context) {
    final now = DateTime.now();
    String curDate = DateFormat.yMMMMd('en_US').format(now);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You have already submitted a request."),
          content: Text(
              'You can only submit one request until the admin approves your request.'),
          actions: <Widget>[
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

  Future<void> _alreadySubmittedPrompt(BuildContext context) {
    final now = DateTime.now();
    String curDate = DateFormat.yMMMMd('en_US').format(now);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You have already submitted."),
          content: Text('You can only submit one entry per day.\n\n'
              'The next submission of entry should be done tomorrow again.\n\n'
              'However, you can still choose to edit or delete your entry for today.\n'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, '/user-edit-entry')},
                child: Text("Edit Entry")),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/user-delete-entry');
                },
                child: Text("Delete Entry")),
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

  Widget _buildScrollView(BuildContext context, final screenWidth,
      final screenHeight, UserDetail userDetail) {
    bool generateQRCode = true;
// generate QR code if user status is cleared and has submitted an entry for the day
    if (dateToday != userDetail.latestEntry && userDetail.status == 'Cleared') {
      context.read<UserDetailListProvider>().editStatus(uid, 'No Health Entry');
    } // set status of user to no health entry if user status is cleared but has not submitted any entries for the day yet
    if (userDetail.latestEntry == dateToday &&
        userDetail.status == 'No Health Entry') {
      context.read<UserDetailListProvider>().editStatus(uid, 'Cleared');
    }
    if (userDetail.status != 'Cleared' || dateToday != userDetail.latestEntry) {
      generateQRCode = false;
    } // fail to generate QR code if user status is not cleared

    String status = userDetail.status;
    return (SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ADMIN OR HEALTH MONITOR CONTROLLER PART
          if (userDetail.userType == 'Admin') AdminConsole(),
          if (userDetail.userType == 'Entrance Monitor')
            EntranceMonitorConsole(),

          //WELCOME
          Container(
              margin: const EdgeInsets.only(top: 40, bottom: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.waving_hand_outlined, color: Colors.teal),
                Text(
                  "Welcome,   ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF004D40),
                    fontSize: 20,
                  ),
                ),
                Text(
                  "${userDetail.firstName}!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D40),
                    fontSize: 20,
                  ),
                )
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Status: ",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.teal[100], // Background color
                ),
                onPressed: null,
                child: Text(
                  "${status}",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(30),
            width: screenWidth,
            child: Column(children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Generate Building Pass",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                        iconSize: 17,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        icon: Icon(Icons.help_outline_outlined),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("I can't generate my QR!"),
                              content: Text(
                                  "To generate your QR code, you must complete your daily health entry and experience no symptoms.\n\n"
                                  "You must also not be quarantined.\n\n"
                                  "If you are marked as cleared, you may still need to request edit entry to change your daily entry status."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Continue"))
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (generateQRCode)
                      ? () {
                          Navigator.pushNamed(context, '/show-qr');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      // Background color
                      fixedSize: Size(150, 20),
                      shape: StadiumBorder()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_outlined,
                      ),
                      const Text(
                        "Show QR",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            ]),
          ),

          const Divider(
            thickness: 1,
            color: Colors.white,
          ),

          SizedBox(height: 20),

          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monitor_heart_outlined,
                    color: Color(0xFF004D40),
                  ),
                  SizedBox(width: 10),
                  const Text(
                    "Health Entries List",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  FloatingActionButton.extended(
                      //Add Entry Button

                      backgroundColor: Colors.teal[200],
                      onPressed: () {
                        if (userDetail.latestEntry == dateToday) {
                          if (isRequestPending) {
                            _alreadySubmittedRequestPrompt(context);
                          } else {
                            _alreadySubmittedPrompt(context);
                          }
                        } else {
                          Navigator.pushNamed(context, '/user-add-entry');
                        }
                      },
                      icon: const Icon(Icons.library_add_outlined,
                          color: Color(0xFF004D40)),
                      label: const Text("Add Entry")),
                ],
              )),
          SizedBox(
              height: 240,
              width: screenWidth * .8,
              child: StreamBuilder<QuerySnapshot>(
                stream: context.watch<EntryListProvider>().entryDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    // get entries of current user only
                    return (ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Entry entry = Entry.entryFromJson(
                              snapshot.data?.docs[index].data()
                                  as Map<String, dynamic>);

                          if (entry.user_key == uid) {
                            if (entry.entry_date == dateToday) {
                              if (entry.edit_request == true ||
                                  entry.delete_request == true) {
                                isRequestPending = true;
                                print(isRequestPending);
                              } else {
                                isRequestPending = false;
                              }
                              currentEntryId = entry.id!;
                              context
                                  .read<EntryListProvider>()
                                  .setCurrentEntry(entry);
                              fullName = userDetail.firstName +
                                  " " +
                                  userDetail.lastName;
                            }
                            return (HealthEntry(entry: entry));
                          } else {
                            return Container();
                          }
                        }));
                  }
                  return Center(
                    child: Text("No User Details Found"),
                  );
                },
              )),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<AuthProvider>().uStream;
    Stream<QuerySnapshot> userDetailStream =
        context.watch<UserDetailListProvider>().userDetails;

    userStream.listen((User? user) async {
      if (user != null) {
        uid = user.uid;
        context.read<AuthProvider>().setUid(uid);
        print("User ID: $uid");

        // set the currentId in the UserDetailListProvider by comparing uid with the uid field in the userdetail document
        id = await context.read<UserDetailListProvider>().getCurrentId(uid);
        print("User id is $id");

        // Do something with the user ID
      } else {
        // Handle the case when the user is null
        print("User is null");
      }
    }, onError: (error) {
      // Handle any errors that occur while listening to the stream
      print("Error: $error");
    }, onDone: () {
      // Stream has completed
      print("Stream completed");
    });

    return StreamBuilder(
        stream: userStream,
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
            return const SigninPage();
          }
          // if user is logged in, display the scaffold containing the streambuilder for the todos
          return displayScaffold(context, userDetailStream);
        });
  }

  Scaffold displayScaffold(
      BuildContext context, Stream<QuerySnapshot>? userDetailStream) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    today = new DateTime.now();
    dateToday = DateFormat.yMMMMd('en_US').format(today);

    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Row(children: [
            Icon(Icons.medical_information_outlined, color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("My Profile ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[200],
        ),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          Container(
            height: 250,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('icon/HealthMonLogo.png',
                          height: 35, width: 35),
                      Text('HealthMon',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004D40))),
                      SizedBox(height: 10),
                      Text(
                          'CMSC 23 Group 2\nAraez Dela Cruz\nLuñeza Concepcion'),
                      SizedBox(height: 20)
                    ])),
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
            },
          ),
        ])),
        body: StreamBuilder<QuerySnapshot>(
          stream: userDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('MyProfile Error: ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return (ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    UserDetail userDetail = UserDetail.userFromJson(
                        snapshot.data?.docs[index].data()
                            as Map<String, dynamic>);

                    if (userDetail.uid == uid) {
                      context.read<UserDetailListProvider>().setCurrentUser(
                          userDetail); // get current user details in provider to be accessed by other pages
                      return (_buildScrollView(
                          context, screenWidth, screenHeight, userDetail));
                      // return Container(child: Text(userDetail.firstName));
                    } else {
                      return Container();
                    }
                  }));
            }
            return Center(
              child: Text("No User Details Found"),
            );
          },
        ));
  }
}
