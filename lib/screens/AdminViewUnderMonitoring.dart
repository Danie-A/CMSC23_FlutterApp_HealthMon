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
          hoverColor: Color(0xFFFBC6A4),
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Colors.teal[
              200], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
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
        backgroundColor: Color.fromARGB(255, 255, 237, 226),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Details'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const UserDetailsPage()));
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // context.read<AuthProvider>().signOut();
              // Navigator.pop(context);
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
