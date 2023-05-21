import 'dart:math';

import 'package:flutter/material.dart';
import 'HealthEntry.dart';
import 'SigninPage.dart';
import 'UserDetailsPage.dart';
import 'AdminViewStudents.dart';
import '../providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String data = "";
  String accountType = "admin";
  bool unableToGenerateQRCode = false;

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
        appBar: AppBar(
          title: const Text("My Profile"),
        ),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
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
            title: const Text('View Students'),
            onTap: () {
              Navigator.pushNamed(context, '/admin-view-students');
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
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
            onPressed: () {/* add entry route */},
            child: const Icon(
              Icons.medical_information_outlined,
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ADMIN OR HEALTH MONITOR CONTROLLER PART
              Text("Authorized Personnel Console"),
              (accountType == 'admin' || accountType == 'entrance monitor')
                  ? Container(
                      height: screenWidth * .7,
                      width: screenWidth * .7,
                      margin: EdgeInsets.only(top: 10),
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Text("View All Students")),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Text("View Quarantined Students")),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Text("Under Monitoring Students")),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              child: Text("Student Requests")),
                        ],
                      ),
                    )
                  : Container(),

              //WELCOME
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(0, 40, 40, 0),
                child: const Text(
                  "Welcome,",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 60),
                child: const Text(
                  "Username !",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Status: ",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Cleared",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  "Generate Building Pass",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: (unableToGenerateQRCode)
                      ? null
                      : () {
                          Navigator.pushNamed(context, '/show-qr');
                        },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 20), shape: StadiumBorder()),
                  child: const Text("Show QR")),
              const SizedBox(
                height: 30,
                width: 10,
              ),
              const Divider(thickness: 3),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Health Entries List",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                  height: screenHeight * .25,
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
