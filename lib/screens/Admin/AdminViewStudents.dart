/*
ViewStudents

GROUP 2 MEMBERS (B7L)
>> Araez, Danielle Lei R.
>> Concepcion, Sean Kierby I.
>> Dela Cruz, Laydon Albert L.
>> Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
>> This page is unique to admin accounts wherein it provides the feature of viewing all students registered in the firebase.
*/

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
  Widget _showForm(
      BuildContext context, UserDetail userDetail, String userType) {
    final formKey = GlobalKey<FormState>();
    TextEditingController empNoController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController homeUnitController = TextEditingController();

    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    context
                        .read<UserDetailListProvider>()
                        .addAdminUniqueProperties(
                            userDetail.uid,
                            empNoController.text.toString(),
                            positionController.text.toString(),
                            homeUnitController.text.toString());
                    context
                        .read<UserDetailListProvider>()
                        .changeUserType(userDetail.uid, userType);
                    if (context.mounted) Navigator.pop(context);
                  }

                  formKey.currentState?.save();
                },
                child: Text('Make ${userType}'),
              ),
            )
          ],
        ));
  }

  Future<void> _showStudent(BuildContext context, UserDetail userDetail) {
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Admin Form",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        content: _showForm(context, userDetail, "Admin"),
                        actions: [
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              // Use the local variable to dismiss the dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Make Admin")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Entrance Monitor Form",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            content: _showForm(
                                context, userDetail, "Entrance Monitor"),
                            actions: [
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  // Use the local variable to dismiss the dialog
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      ),
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

  List<String> filterBy = ['Student Number', 'Date', 'College', 'Course'];
  List<String> colleges = [
    'CAS',
    'CDC',
    'CFNR',
    'CEAT',
    'CEM',
    'CHE',
    'CAFS',
    'CVM'
  ];
  List<String> courses = [
    'BS Computer Science',
    'BA Communication Arts',
    'BS Applied Physics',
    'BS Biology',
    'BS Chemistry',
    'BS Statistics',
    'BS Agricultural Chemistry',
    'Doctor of Veterinary Medicine',
    'BS Accountancy',
    'BS Economics',
    'BS Agribusiness Management',
    'BS Communication',
    'BS Civil Engineering',
    'BS Chemical Engineering',
    'BS Electrical Engineering',
    'BS Forestry',
    'BS Nutrition',
    'BS Human Ecology'
  ];

  String filterValue = '';
  String collegeValue = '';
  String courseValue = '';

  bool courseDropdownIsVisible = false;
  bool collegeDropdownIsVisible = false;

  void allNotVisible() {
    setState(() {
      courseDropdownIsVisible = false;
      collegeDropdownIsVisible = false;
    });
  }

  void courseVisible() {
    setState(() {
      courseDropdownIsVisible = true;
      collegeDropdownIsVisible = false;
    });
  }

  void collegeVisible() {
    setState(() {
      collegeDropdownIsVisible = true;
      courseDropdownIsVisible = false;
    });
  }

  void toggleCollegeVisibility() {
    setState(() {
      collegeDropdownIsVisible = !collegeDropdownIsVisible;
    });
  }

  void toggleCourseVisibility() {
    setState(() {
      courseDropdownIsVisible = !courseDropdownIsVisible;
    });
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
                          .read<UserDetailListProvider>()
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

  Widget _showSorted(BuildContext context, String filterValue) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (filterValue == 'Student Number') {
      Stream<QuerySnapshot> sortStudentNo =
          context.watch<UserDetailListProvider>().sortStudentNoStream;
      return SizedBox(
          height: 240,
          width: screenWidth * .99,
          child: StreamBuilder<QuerySnapshot>(
            stream: sortStudentNo,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // get entries of current user only
                return (ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      UserDetail userDetail = UserDetail.studentFromJson(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>);

                      return InkWell(
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
                            title: Text(
                                "${userDetail.studentNo} - ${userDetail.firstName}"), // name
                            // subtitle: Text("${friend.nickname}"), // filter subtitle
                            trailing: IconButton(
                              icon: const Icon(Icons.coronavirus_rounded),
                              onPressed: () {
                                _showAddToQuarantine(context, userDetail);
                              },
                            )),
                      );
                    }));
              }
              return Center(
                child: Text("No Students Found"),
              );
            },
          )
          // child: ListView.builder(
          //     itemCount: healthEntries.length,
          //     itemBuilder: (context, index) {
          //       return const HealthEntry();
          //     })

          );
    } else if (filterValue == 'Course') {
      context.read<UserDetailListProvider>().setCourseStream(courseValue);
      Stream<QuerySnapshot> sortCourse =
          context.watch<UserDetailListProvider>().sortCourseStream;

      return SizedBox(
          height: 240,
          width: screenWidth * .99,
          child: StreamBuilder<QuerySnapshot>(
            stream: sortCourse,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // get entries of current user only
                return (ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      UserDetail userDetail = UserDetail.studentFromJson(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>);

                      return InkWell(
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
                            title: Text(
                                "${userDetail.course} - ${userDetail.firstName}"), // name
                            // subtitle: Text("${friend.nickname}"), // filter subtitle
                            trailing: IconButton(
                              icon: const Icon(Icons.coronavirus_rounded),
                              onPressed: () {
                                _showAddToQuarantine(context, userDetail);
                              },
                            )),
                      );
                    }));
              }
              return Center(
                child: Text("No Students Found"),
              );
            },
          ));
    } else if (filterValue == 'College') {
      context.read<UserDetailListProvider>().setCollegeStream(collegeValue);
      Stream<QuerySnapshot> sortCollege =
          context.watch<UserDetailListProvider>().sortCollegeStream;
      return SizedBox(
          height: 240,
          width: screenWidth * .99,
          child: StreamBuilder<QuerySnapshot>(
            stream: sortCollege,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('avs Error: ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // get entries of current user only
                return (ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      UserDetail userDetail = UserDetail.studentFromJson(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>);

                      return InkWell(
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
                            title: Text(
                                "${userDetail.college} - ${userDetail.firstName}"), // name
                            // subtitle: Text("${friend.nickname}"), // filter subtitle
                            trailing: IconButton(
                              icon: const Icon(Icons.coronavirus_rounded),
                              onPressed: () {
                                _showAddToQuarantine(context, userDetail);
                              },
                            )),
                      );
                    }));
              }
              return Center(
                child: Text("No Students Found"),
              );
            },
          ));
    } else {
      Stream<QuerySnapshot> sortDate =
          context.watch<UserDetailListProvider>().sortDateStream;

      return SizedBox(
          height: 240,
          width: screenWidth * .99,
          child: StreamBuilder<QuerySnapshot>(
            stream: sortDate,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('avs Error: ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // get entries of current user only
                return (ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      UserDetail userDetail = UserDetail.studentFromJson(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>);

                      return InkWell(
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
                            title: Text(
                                "${userDetail.latestEntry} - ${userDetail.firstName}"), // name
                            // subtitle: Text("${friend.nickname}"), // filter subtitle
                            trailing: IconButton(
                              icon: const Icon(Icons.coronavirus_rounded),
                              onPressed: () {
                                _showAddToQuarantine(context, userDetail);
                              },
                            )),
                      );
                    }));
              }
              return Center(
                child: Text("No Students Found"),
              );
            },
          )
          // child: ListView.builder(
          //     itemCount: healthEntries.length,
          //     itemBuilder: (context, index) {
          //       return const HealthEntry();
          //     })

          );
    }
  }

  Widget _showStream(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Filter By: "),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownColor: Colors.teal[100],
                    underline: SizedBox.shrink(),
                    value: filterValue,
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.teal),
                    onChanged: (String? newValue) {
                      setState(() {
                        filterValue = newValue!;
                        if (filterValue == 'College') {
                          collegeDropdownIsVisible = true;
                          courseDropdownIsVisible = false;
                        } else if (filterValue == 'Course') {
                          courseDropdownIsVisible = true;
                          collegeDropdownIsVisible = false;
                        } else {
                          collegeDropdownIsVisible = false;
                          courseDropdownIsVisible = false;
                        }
                      });
                    },
                    items:
                        filterBy.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('  $value'),
                      );
                    }).toList(),
                  ),
                  Visibility(
                    visible: collegeDropdownIsVisible,
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.teal[100],
                      underline: SizedBox.shrink(),
                      value: collegeValue,
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.teal),
                      onChanged: (String? newValue) {
                        setState(() {
                          collegeValue = newValue!;
                        });
                      },
                      items: colleges
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('  $value'),
                        );
                      }).toList(),
                    ),
                  ),
                  Visibility(
                    visible: courseDropdownIsVisible,
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.teal[100],
                      underline: SizedBox.shrink(),
                      value: courseValue,
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.teal),
                      onChanged: (String? newValue) {
                        setState(() {
                          courseValue = newValue!;
                        });
                      },
                      items:
                          courses.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('  $value'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          _showSorted(context, filterValue),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    filterValue = filterBy.first;
    collegeValue = colleges.first;
    courseValue = courses.first;
  }

  @override
  Widget build(BuildContext context) {
    return displayScaffold(context);
  }

  Scaffold displayScaffold(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: const [
            Icon(Icons.people_outline_rounded, color: Color(0xFF004D40)),
            SizedBox(width: 14),
            Text("All Students",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ))
          ]),
          backgroundColor: Colors.teal[100],
        ),
        body: Column(
          children: [
            SizedBox(height: 8),
            Expanded(
              child: _showStream(context),
            )
          ],
        ));
  }
}
