import 'package:flutter/material.dart';

class EntMonSearchLogs extends StatefulWidget {
  const EntMonSearchLogs({super.key});

  @override
  State<EntMonSearchLogs> createState() => _EntMonSearchLogsState();
}

class _EntMonSearchLogsState extends State<EntMonSearchLogs> {
  List<String> students = ["Danie", "Sean", "Marcie", "Laydon"];
  List<int> studentNum = [1, 2, 3, 4];

  ListView viewAllStudents() {
    return ListView.builder(
      // displays friend names through multiple instances of List Tile
      itemCount: students.length,
      itemBuilder: (context, index) {
        return InkWell(
          // InkWell widget adds some hover effect to the ListTile
          onTap: () {},
          hoverColor: Colors.teal[100],
          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
          splashColor: Colors.teal[
              100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.teal),
            title: Text("${students[index]}"), // name
            // subtitle: Text("${friend.nickname}"), // filter subtitle
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchLogsController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Row(children: const [
            Icon(Icons.screen_search_desktop_outlined,
                color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("Search Logs",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[100],
        ),
        body: Column(children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchLogsController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Color(0xFF004D40))),
                ),
              ),
            ),
          ),
          Expanded(child: viewAllStudents()),
        ]));
  }
}
