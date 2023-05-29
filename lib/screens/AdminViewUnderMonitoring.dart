import 'package:flutter/material.dart';

class AdminViewUnderMonitoring extends StatefulWidget {
  const AdminViewUnderMonitoring({super.key});

  @override
  State<AdminViewUnderMonitoring> createState() =>
      _AdminViewUnderMonitoringState();
}

class _AdminViewUnderMonitoringState extends State<AdminViewUnderMonitoring> {
  List<String> underMonitoringStudents = ["Danie", "Sean", "Marcie", "Laydon"];

  Future<void> _showMovetoQuarantine(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${name}'),
          content: const Text(
            'Are you sure you want to move this student to quarantine?',
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {}, child: const Text("Move to Quarantine")),
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

  Expanded viewAllStudents() {
    return Expanded(
        child: ListView.builder(
      // displays friend names through multiple instances of List Tile
      itemCount: underMonitoringStudents.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          // InkWell widget adds some hover effect to the ListTile
          hoverColor: Colors.teal[200],
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Color(
              0xFFFBC6A4), // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
          child: ListTile(
            leading: Icon(Icons.person, color: Color(0xFFBE7575)),
            title: Text("${underMonitoringStudents[index]}"), // name
            // subtitle: Text("${friend.nickname}"), // filter subtitle
            trailing: Wrap(spacing: 5, children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.coronavirus_outlined,
                ),
                color: Color(0xFFBE7575),
                onPressed: () {
                  _showMovetoQuarantine(
                      context, underMonitoringStudents[index]);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.remove_circle_outlined,
                ),
                onPressed: () {
                  setState(() {
                    underMonitoringStudents
                        .remove(underMonitoringStudents[index]);
                  });
                },
              )
            ]),
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[50],
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
            ),
            child: Text('Sample Drawer Header'),
          ),
          ListTile(
            title: const Text('View All Students'),
            onTap: () {
              Navigator.pop(context); //back drawer
              Navigator.pop(context); //back to homepage
              Navigator.pushNamed(context, '/view-students'); //show qr
            },
          ),
          ListTile(
            title: const Text('View Quarantined'),
            onTap: () {
              Navigator.pop(context); //back drawer
              Navigator.pop(context); //back to homepage
              Navigator.pushNamed(context, '/view-quarantined'); //scan qr
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
            Icon(Icons.medication_outlined,
                color: Color.fromRGBO(0, 77, 64, 1)),
            SizedBox(width: 2),
            Text("Under Monitoring Students",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(0, 77, 64, 1)))
          ]),
          backgroundColor: Colors.teal[200],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Under Monitoring Student Count: ${underMonitoringStudents.length}",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            viewAllStudents()
          ],
        ));
  }
}
