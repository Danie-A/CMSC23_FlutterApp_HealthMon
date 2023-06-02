import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/UserDetail.dart';
import '../../providers/UserDetailListProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/AuthProvider.dart';

class AdminViewStudents extends StatefulWidget {
  const AdminViewStudents({super.key});

  @override
  State<AdminViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<AdminViewStudents> {
  Widget _showAdminForm(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController empNoController,
      TextEditingController positionController,
      TextEditingController homeUnitController) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.all(16),
            // border: OutlineInputBorder(),
            hintText: "Employee Number",
            // labelText: "Last Name",
          ),
          controller: empNoController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input employee number.';
            }
            return null;
          }, // adds a validator in the form field
        ),
        TextFormField(
          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.all(16),
            // border: OutlineInputBorder(),
            hintText: "Position",
            // labelText: "Last Name",
          ),
          controller: positionController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input position.';
            }
            return null;
          }, // adds a validator in the form field
        ),
        TextFormField(
          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.all(16),
            // border: OutlineInputBorder(),
            hintText: "Home Unit",
            // labelText: "Last Name",
          ),
          controller: homeUnitController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input home unit.';
            }
            return null;
          }, // adds a validator in the form field
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (context.mounted) Navigator.pop(context);
              }

              formKey.currentState?.save();
            },
            child: const Text('Sign up'),
          ),
        )
      ],
    ));
  }

  Future<void> _showStudent(BuildContext context, UserDetail userDetail) {
    final formKey = GlobalKey<FormState>();
    TextEditingController empNoController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController homeUnitController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${userDetail.firstName} ${userDetail.lastName}'),
          content: Text(
            'Email: ${userDetail.email}\n'
            'Username: ${userDetail.username}\n'
            'College: ${userDetail.college}\n'
            'Course: ${userDetail.course}\n'
            'Student No: ${userDetail.studentNo}\n'
            'Pre-Existing Illness: ${userDetail.preExistingIllness}\n'
            'Latest Entry Date: ${userDetail.latestEntry}\n',
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
                      context
                          .watch<UserDetailListProvider>()
                          .changeUserType(userDetail.uid, "Admin"),
                      _showAdminForm(context, formKey, empNoController,
                          positionController, homeUnitController)
                    },
                child: const Text("Make Admin")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {
                      context
                          .watch<UserDetailListProvider>()
                          .changeUserType(userDetail.uid, "Entrance Monitor"),
                    },
                child: const Text("Make Entrance Monitor")),
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

  Future<void> _showAddToQuarantine(
      BuildContext context, UserDetail userDetail) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${userDetail.firstName}'),
          content: const Text(
            'Are you sure you want to add this student to quarantine?',
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => {
                      context
                          .watch<UserDetailListProvider>()
                          .editStatus(userDetail.uid, "Quarantined"),
                      Navigator.of(context).pop()
                    },
                child: const Text("Add to Quarantine")),
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
    Stream<QuerySnapshot> userDetailStream =
        context.watch<UserDetailListProvider>().userDetails2;
    return displayScaffold(context, userDetailStream);
  }

  Scaffold displayScaffold(
      BuildContext context, Stream<QuerySnapshot<Object?>> userDetailStream) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
          ),
          child: Text('Sample Drawer Header'),
        ),
        ListTile(
          title: const Text('View Quarantined Students'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/view-quarantined'); //show qr
          },
        ),
        ListTile(
          title: const Text('View Under Monitoring'),
          onTap: () {
            Navigator.pop(context); //back drawer
            Navigator.pop(context); //back to homepage
            Navigator.pushNamed(context, '/view-under-monitoring'); //scan qr
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
          Icon(Icons.local_hospital_rounded, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("All Students",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: StreamBuilder(
            stream: userDetailStream,
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
                return const Center(
                  child: Text("No Todos Found"),
                );
              }

              //just get all users
              return ListView.builder(
                // displays friend names through multiple instances of List Tile
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  UserDetail userDetail = UserDetail.studentFromJson(
                      snapshot.data?.docs[index].data()
                          as Map<String, dynamic>);
                  return (userDetail.userType != "User")

                      //if user is not a regular "User" (meaning student) dont render
                      ? Container()
                      : InkWell(
                          // InkWell widget adds some hover effect to the ListTile
                          onTap: () {
                            _showStudent(context, userDetail);
                          },
                          hoverColor: Colors.teal[200],
                          // Color.fromARGB(15, 233, 30, 98), // hover color set to pink
                          splashColor: Colors.teal[
                              100], // sets the splash color (circle splash effect when user taps and holds the ListTile) to pink
                          child: ListTile(
                              leading: Icon(Icons.person, color: Colors.teal),
                              title: Text("${userDetail.firstName}"), // name
                              // subtitle: Text("${friend.nickname}"), // filter subtitle
                              trailing: IconButton(
                                icon: const Icon(Icons.coronavirus_rounded),
                                onPressed: () {
                                  _showAddToQuarantine(context, userDetail);
                                },
                              )),
                        );
                },
              );
            }),
      ),
    );
  }
}
