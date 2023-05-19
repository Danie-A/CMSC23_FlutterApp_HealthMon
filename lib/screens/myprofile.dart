import 'package:flutter/material.dart';
import 'healthEntries.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String data = "";
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Health Monitor"),
        ),
        drawer: const Drawer(),
        backgroundColor: Colors.grey.shade600,
        floatingActionButton: FloatingActionButton(
            onPressed: () {/* add entry route */},
            child: const Icon(
              Icons.medical_information_outlined,
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(0, 40, 40, 0),
              child: const Text(
                "Welcome,",
                style: TextStyle(
                  color: Colors.blue,
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
                  color: Colors.blue,
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
                      color: Color.fromARGB(255, 74, 210, 251),
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Cleared",
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 255, 75),
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
                "Generate building pass",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/qr-code');
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
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
                height: screenHeight * .25,
                width: screenWidth * .9,
                child: ListView.builder(
                    itemCount: healthEntries.length,
                    itemBuilder: (context, index) {
                      return const HealthEntry();
                    })),
          ],
        ));
  }
}
