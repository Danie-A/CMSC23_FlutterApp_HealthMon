/*
GROUP 2 MEMBERS (B7L) FirebaseEntryAPI.dart

Araez, Danielle Lei R.
Concepcion, Sean Kierby I.
Dela Cruz, Laydon Albert L.
Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
This will show the console for admin so that they can manage the application.
*/

import 'package:flutter/material.dart';

class AdminConsole extends StatelessWidget {
  const AdminConsole({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text("AUTHORIZED ADMIN CONSOLE",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[900]))),
        (Container(
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/view-students');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.groups_rounded, size: screenWidth * 0.20),
                        Text("View All Students", textAlign: TextAlign.center)
                      ])),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/view-quarantined');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.coronavirus_rounded,
                            size: screenWidth * 0.20),
                        Text("View Quarantined Students",
                            textAlign: TextAlign.center)
                      ])),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/view-under-monitoring');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.medication_outlined,
                            size: screenWidth * 0.20),
                        Text("Under Monitoring Students",
                            textAlign: TextAlign.center)
                      ])),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/view-requests');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.pending_actions, size: screenWidth * 0.20),
                        Text("Entry Requests", textAlign: TextAlign.center)
                      ])),
            ],
          ),
        )),
      ],
    );
  }
}
