import 'package:flutter/material.dart';

class ViewRequests extends StatefulWidget {
  const ViewRequests({super.key});

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  List<String> requests = [
    "Danie Araez",
    "Sean Pogi 3000",
    "Marcie Luneza",
    "Laydon Dela Cruz",
    "Ski Concepcion",
    "LeBron James",
    "President Obama"
  ];

  List<bool> isDeleteRequest = [true, false, true, true, false, false, true];

  Future<void> _confirmDelete(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Allow ${name} to delete his/her entry?'),
          content: Text('By confirming his/her request,\n'
              'you are allowing ${name} to delete his/her entry. \n\n'
              'Please be noted that your choice is irrevokable.\n'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {}, child: Text("Allow delete entry")),
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

  Future<void> _confirmEdit(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Allow ${name} to edit his/her entry?'),
          content: Text('By confirming his/her request,\n'
              'you are allowing ${name} to edit his/her entry. \n\n'
              'Please be noted that your choice is irrevokable.\n'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {}, child: Text("Allow edit entry")),
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

  Future<void> _confirmReject(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reject ${name}'s request?"),
          actions: <Widget>[
            ElevatedButton(onPressed: () => {}, child: Text("Reject request")),
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

  ListView viewAllRequests() {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 7);
      },
      // displays friend names through multiple instances of List Tile
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return isDeleteRequest[index]
            ? InkWell(
                hoverColor: Color.fromARGB(255, 10, 41, 24),
                // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                splashColor: Colors
                    .teal, // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      tileColor: Color.fromARGB(255, 239, 224, 224),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1, color: Color.fromARGB(255, 165, 85, 80)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: Icon(Icons.delete,
                          color: Color.fromARGB(255, 165, 85, 80)),
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${requests[index]}"),
                            Text("Delete Request",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey))
                          ]), // name
                      // subtitle: Text("${friend.nickname}"), // filter subtitle
                      trailing: Wrap(spacing: 5, children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.check_circle),
                          color: Colors.teal,
                          onPressed: () {
                            _confirmDelete(context, requests[index]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          color: Color.fromARGB(255, 165, 85, 80),
                          onPressed: () {
                            _confirmReject(context, requests[index]);
                          },
                        ),
                      ]),
                    )))
            : InkWell(
                hoverColor: Color.fromARGB(255, 10, 41, 24),
                // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                splashColor: Colors
                    .teal, // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      tileColor: Colors.teal[50],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: Icon(Icons.edit_note, color: Colors.teal),
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${requests[index]}"),
                            Text("Edit Request",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey))
                          ]), // name
                      // subtitle: Text("${friend.nickname}"), // filter subtitle
                      trailing: Wrap(spacing: 5, children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.check_circle),
                          color: Colors.teal,
                          onPressed: () {
                            _confirmEdit(context, requests[index]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          color: Color.fromARGB(255, 165, 85, 80),
                          onPressed: () {
                            _confirmReject(context, requests[index]);
                          },
                        ),
                      ]),
                    )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          title: const Text('To Do List'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
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
          Icon(Icons.pending_actions, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("View Requests",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 16), child: viewAllRequests()),
    );
  }
}
