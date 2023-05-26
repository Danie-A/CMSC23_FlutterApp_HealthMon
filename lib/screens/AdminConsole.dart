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
            child: Text("AUTHORIZED PERSONNEL CONSOLE",
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
                    Navigator.pushNamed(context, '/admin-view-students');
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
                        Icon(Icons.local_hospital_rounded,
                            size: screenWidth * 0.20),
                        Text("View Quarantined Students",
                            textAlign: TextAlign.center)
                      ])),

              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/admin-view-under-monitoring');
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
                    Navigator.pushNamed(context, '/admin-view-requests');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.pending_actions, size: screenWidth * 0.20),
                        Text("Student Requests", textAlign: TextAlign.center)
                      ])),
            ],
          ),
        )),
      ],
    );
  }
}
