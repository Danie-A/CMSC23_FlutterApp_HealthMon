/*
GROUP 2 MEMBERS (B7L)
>> Araez, Danielle Lei R.
>> Concepcion, Sean Kierby I.
>> Dela Cruz, Laydon Albert L.
>> Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
>> This page is where users can add their health entries. It is accessed through the My Profile page.

*/

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screens/MyProfile.dart';
import 'package:provider/provider.dart';
import '../../models/Entry.dart';
import '../../providers/EntryListProvider.dart';
import '../../screens/myprofile.dart';
import 'package:intl/intl.dart';
import '../../providers/UserDetailListProvider.dart';
import '../../providers/AuthProvider.dart';

class UserAddEntry extends StatefulWidget {
  @override
  _UserAddEntryState createState() => _UserAddEntryState();
}

class _UserAddEntryState extends State<UserAddEntry> {
  bool fever = false;
  bool feverish = false;
  bool muscle_joint_pain = false;
  bool cough = false;
  bool cold = false;
  bool sore_throat = false;
  bool difficulty_breathing = false;
  bool diarrhea = false;
  bool loss_taste = false;
  bool loss_smell = false;
  bool has_symptoms = false;
  String had_contact = "No";
  String status = "Cleared";
  String user_key = " ";
  bool edit_request = false;
  bool delete_request = false;

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String entryDate = DateFormat.yMMMMd('en_US').format(now);
    print('entrydate is' + entryDate);

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Icon(Icons.post_add_outlined, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("Add Entry",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[200],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please check the box for each symptom you are experiencing:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                CheckboxListTile(
                  value: fever,
                  onChanged: (value) {
                    setState(() {
                      fever = value ?? false;
                    });
                  },
                  title: Text('Fever (37.8 C and above)'),
                ),
                CheckboxListTile(
                  value: feverish,
                  onChanged: (value) {
                    setState(() {
                      feverish = value ?? false;
                    });
                  },
                  title: Text('Feeling feverish'),
                ),
                CheckboxListTile(
                  value: muscle_joint_pain,
                  onChanged: (value) {
                    setState(() {
                      muscle_joint_pain = value ?? false;
                    });
                  },
                  title: Text('Muscle or joint pains'),
                ),
                CheckboxListTile(
                  value: cough,
                  onChanged: (value) {
                    setState(() {
                      cough = value ?? false;
                    });
                  },
                  title: Text('Cough'),
                ),
                CheckboxListTile(
                  value: cold,
                  onChanged: (value) {
                    setState(() {
                      cold = value ?? false;
                    });
                  },
                  title: Text('Colds'),
                ),
                CheckboxListTile(
                  value: sore_throat,
                  onChanged: (value) {
                    setState(() {
                      sore_throat = value ?? false;
                    });
                  },
                  title: Text('Sore throat'),
                ),
                CheckboxListTile(
                  value: difficulty_breathing,
                  onChanged: (value) {
                    setState(() {
                      difficulty_breathing = value ?? false;
                    });
                  },
                  title: Text('Difficulty of breathing'),
                ),
                CheckboxListTile(
                  value: diarrhea,
                  onChanged: (value) {
                    setState(() {
                      diarrhea = value ?? false;
                    });
                  },
                  title: Text('Diarrhea'),
                ),
                CheckboxListTile(
                  value: loss_taste,
                  onChanged: (value) {
                    setState(() {
                      loss_taste = value ?? false;
                    });
                  },
                  title: Text('Loss of taste'),
                ),
                CheckboxListTile(
                  value: loss_smell,
                  onChanged: (value) {
                    setState(() {
                      loss_smell = value ?? false;
                    });
                  },
                  title: Text('Loss of smell'),
                ),
                SizedBox(height: 16),
                Text(
                  'Have you had a face-to-face encounter or contact with a confirmed COVID-19 case?',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Yes',
                      groupValue: had_contact,
                      onChanged: (value) {
                        setState(() {
                          had_contact = value!;
                        });
                      },
                    ),
                    Text('Yes'),
                    Radio<String>(
                      value: 'No',
                      groupValue: had_contact,
                      onChanged: (value) {
                        setState(() {
                          had_contact = value!;
                        });
                      },
                    ),
                    Text('No'),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Entry newEntry = new Entry(
                        fever: fever,
                        feverish: feverish,
                        muscle_joint_pain: muscle_joint_pain,
                        cough: cough,
                        cold: cold,
                        sore_throat: sore_throat,
                        difficulty_breathing: difficulty_breathing,
                        diarrhea: diarrhea,
                        loss_taste: loss_taste,
                        loss_smell: loss_smell,
                        has_symptoms: has_symptoms,
                        had_contact: had_contact,
                        status: status,
                        user_key: context.read<AuthProvider>().userId,
                        edit_request: edit_request,
                        delete_request: delete_request,
                        entry_date: entryDate);

                    if (newEntry.fever == true ||
                        newEntry.feverish == true ||
                        newEntry.muscle_joint_pain == true ||
                        newEntry.cough == true ||
                        newEntry.cold == true ||
                        newEntry.sore_throat == true ||
                        newEntry.difficulty_breathing == true ||
                        newEntry.diarrhea == true ||
                        newEntry.loss_taste == true ||
                        newEntry.loss_smell == true) {
                      newEntry.has_symptoms = true;
                      newEntry.status = "Under Monitoring";
                    }
                    if (newEntry.had_contact == "Yes") {
                      newEntry.status = "Under Monitoring";
                    }
                    context
                        .read<EntryListProvider>()
                        .addEntryDetail(newEntry)
                        .then((fetchedEntryId) {
                      print("[SCREEN] ENTRY ID IS: ${fetchedEntryId}");
                      context.read<UserDetailListProvider>().editEntryId(
                          context.read<AuthProvider>().userId, fetchedEntryId);

                      context.read<UserDetailListProvider>().editStatus(
                          context.read<AuthProvider>().userId, newEntry.status);

                      context.read<UserDetailListProvider>().editLatestEntry(
                          context.read<AuthProvider>().userId,
                          newEntry.entry_date);

                      Navigator.pop(context);
                    });
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          )),
    );
  }
}
