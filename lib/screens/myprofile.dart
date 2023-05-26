import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screens/AdminConsole.dart';
import 'package:health_monitoring_app/screens/EntranceMonitorConsole.dart';
import 'package:health_monitoring_app/screens/UserAddEntry.dart';
import 'HealthEntry.dart';
import 'SigninPage.dart';
import 'UserDetailsPage.dart';
import 'AdminViewStudents.dart';
import '../providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AdminViewUnderMonitoring.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String data = "";
  String accountType = "admin";
  bool unableToGenerateQRCode = false;

  String todayEntry = "";
  DateTime dateToday = DateTime.now();

  static List healthEntries = [
    "a",
    "b",
    "c",
    "a",
    "b",
    "c",
    "a",
    "b",
    "c",
    "a",
    "b",
    "c",
    "a",
    "b",
    "c",
    "a",
    "b",
    "c",
  ];

  Future<void> _alreadySubmittedPrompt(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You have already submitted"),
          content: Text('You can only submit one entry per day,\n'
              'next submission of entry should be done tomorrow again.\n\n'
              'However you can choose to edit or delete your entry for today.\n'),
          actions: <Widget>[
            ElevatedButton(onPressed: () => {}, child: Text("Edit Entry")),
            ElevatedButton(onPressed: () => {}, child: Text("Delete Entry")),
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
    Stream<User?> userStream = context.watch<AuthProvider>().uStream;

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
          return displayScaffold(context);
        });
  }

  Scaffold displayScaffold(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Row(children: const [
            Icon(Icons.medical_information_outlined, color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("My Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[200],
        ),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
            ),
            child: Text('${dateToday}\n Sample Drawer Header'),
          ),
          ListTile(
            title: const Text('Add Entry'),
            onTap: () {
              Navigator.pushNamed(context, '/user-add-entry');
            },
          ),
          ListTile(
            title: const Text('Show QR'),
            onTap: () {
              Navigator.pushNamed(context, '/show-qr');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
            },
          ),
        ])),
        floatingActionButton: FloatingActionButton(
            //Add Entry Button
            backgroundColor: Colors.teal[200],
            onPressed: () {
              String date =
                  "${dateToday.day}-${dateToday.month}-${dateToday.year}";

              if (todayEntry == date) {
                _alreadySubmittedPrompt(context);
              } else {
                todayEntry = date;
                Navigator.pushNamed(context, '/user-add-entry');
              }
            },
            child: const Icon(Icons.library_add_outlined,
                color: Color(0xFF004D40))),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ADMIN OR HEALTH MONITOR CONTROLLER PART
              if (accountType == 'admin') AdminConsole(),
              if (accountType == 'entrance monitor') EntranceMonitorConsole(),

              //WELCOME
              Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          "{username}!",
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
                      disabledBackgroundColor:
                          Colors.teal[100], // Background color
                    ),
                    onPressed: null,
                    child: const Text(
                      "Cleared",
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
                                        "To be able to generate your QR code, you must complete your daily health entry, and have no symptoms"),
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
                        onPressed: (unableToGenerateQRCode)
                            ? null
                            : () {
                                Navigator.pushNamed(context, '/show-qr');
                              },
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
                  ])),

              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
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
                    ],
                  )),
              SizedBox(
                  height: 800,
                  width: screenWidth * .8,
                  child: ListView.builder(
                      itemCount: healthEntries.length,
                      itemBuilder: (context, index) {
                        return const HealthEntry();
                      })),
            ],
          ),
        ));
  }
}
