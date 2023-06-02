import 'package:flutter/material.dart';
import 'package:health_monitoring_app/providers/AuthProvider.dart';
import 'package:health_monitoring_app/screens/EntMonViewLogs.dart';
import 'package:provider/provider.dart';
import '../providers/UserDetailListProvider.dart';

class EntranceMonitorConsole extends StatelessWidget {
  EntranceMonitorConsole({super.key});
  TextEditingController _locationController = TextEditingController();

  Future<void> _showSetLocation(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Location'),
          content: Column(children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Enter Location",
              ),
            )
          ]),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
// set location in firebase
                      context.read<UserDetailListProvider>().addLocation(
                          context.read<AuthProvider>().uid,
                          _locationController.text.toString()),
                      _locationController.clear(),
                      Navigator.of(context).pop(),
                    },
                child: const Text("Set Location")),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text("ENTRANCE MONITOR CONSOLE",
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
                    Navigator.pushNamed(context, '/view-logs');
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
                        Text("View Logs", textAlign: TextAlign.center)
                      ])),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/scan-qr');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code, size: screenWidth * 0.20),
                        Text("Read QR", textAlign: TextAlign.center)
                      ])),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search-logs');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.screen_search_desktop_outlined,
                            size: screenWidth * 0.20),
                        Text("Search Logs", textAlign: TextAlign.center)
                      ])),
              ElevatedButton(
                  onPressed: () {
                    _showSetLocation(context);
                    //Navigator.pushNamed(context, '/view-requests');
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: screenWidth * 0.20),
                        Text("Add Location", textAlign: TextAlign.center)
                      ])),
            ],
          ),
        )),
      ],
    );
  }
}
