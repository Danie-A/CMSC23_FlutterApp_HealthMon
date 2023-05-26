import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screens/EntMonViewLogs.dart';

class EntranceMonitorConsole extends StatelessWidget {
  const EntranceMonitorConsole({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text("Authorized Personnel Console",
                style: TextStyle(
                    fontSize: 16,
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
                    Navigator.pushNamed(context, '/view-logs');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Center(
                      child: Text("View Logs", textAlign: TextAlign.center))),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/scan-qr');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Center(
                      child: Text("Read QR", textAlign: TextAlign.center))),
              ElevatedButton.icon(
                  icon: Icon(Icons.access_time_filled_sharp),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search-logs');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  label: Center(
                      child: Text("Search Logs", textAlign: TextAlign.center))),
            ],
          ),
        )),
      ],
    );
  }
}
