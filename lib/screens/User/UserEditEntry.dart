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
>> This page is where the user can edit their health entry. This page is only accessible if the user
has already submitted an entry for the day. The user can edit their entry by checking the symptoms
they have and choosing "Yes" if they had a F2F contact with a COVID-19 positive person.

>> The user will need to wait for the admin to approve their edit entry before the changes would show.

*/

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/providers/AuthProvider.dart';
import 'package:health_monitoring_app/screens/MyProfile.dart';
import 'package:provider/provider.dart';
import '../../models/Entry.dart';
import '../../providers/EntryListProvider.dart';
import '../../screens/myprofile.dart';
import 'package:intl/intl.dart';
import '../../models/Request.dart';
import '../../api/FirebaseRequestAPI.dart';
import '../../providers/RequestProvider.dart';
import '../../providers/EntryListProvider.dart';
import '../../providers/UserDetailListProvider.dart';
import '../../models/UserDetail.dart';

class UserEditEntry extends StatefulWidget {
  @override
  _UserEditEntryState createState() => _UserEditEntryState();
}

class _UserEditEntryState extends State<UserEditEntry> {
  late bool fever = false;
  late bool feverish = false;
  late bool muscle_joint_pain = false;
  late bool cough = false;
  late bool cold = false;
  late bool sore_throat = false;
  late bool difficulty_breathing = false;
  late bool diarrhea = false;
  late bool loss_taste = false;
  late bool loss_smell = false;
  late bool has_symptoms = false;
  late String had_contact = "";
  late String status = "";
  late String user_key = "";
  late bool edit_request = false;
  late bool delete_request = false;
  late String? entry_id = "";

  @override
  void initState() {
    super.initState();
    getEntry();
  }

  void getEntry() async {
    Entry? entry = await context.read<EntryListProvider>().getEntry;

    if (entry != null) {
      setState(() {
        fever = entry.fever;
        feverish = entry.feverish;
        muscle_joint_pain = entry.muscle_joint_pain;
        cough = entry.cough;
        cold = entry.cold;
        sore_throat = entry.sore_throat;
        difficulty_breathing = entry.difficulty_breathing;
        diarrhea = entry.diarrhea;
        loss_taste = entry.loss_taste;
        loss_smell = entry.loss_smell;
        has_symptoms = entry.has_symptoms;
        had_contact = entry.had_contact;
        status = entry.status;
        user_key = entry.user_key;
        edit_request = entry.edit_request;
        delete_request = entry.delete_request;
        entry_id = entry.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String entryDate = DateFormat.yMMMMd('en_US').format(now);
    String editDate = DateFormat.yMMMMd('en_US').format(now);
    UserDetail? user = context.read<UserDetailListProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Icon(Icons.edit_note_rounded, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("Edit Today's Entry",
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
                onChanged: (bool? value) {
                  setState(() {
                    fever = value!;
                  });
                },
                title: Text('Fever (37.8 C and above)'),
              ),
              CheckboxListTile(
                value: feverish,
                onChanged: (bool? value) {
                  setState(() {
                    feverish = value!;
                  });
                },
                title: Text('Feeling feverish'),
              ),
              CheckboxListTile(
                value: muscle_joint_pain,
                onChanged: (bool? value) {
                  setState(() {
                    muscle_joint_pain = value!;
                  });
                },
                title: Text('Muscle or joint pains'),
              ),
              CheckboxListTile(
                value: cough,
                onChanged: (bool? value) {
                  setState(() {
                    cough = value!;
                  });
                },
                title: Text('Cough'),
              ),
              CheckboxListTile(
                value: cold,
                onChanged: (bool? value) {
                  setState(() {
                    cold = value!;
                  });
                },
                title: Text('Colds'),
              ),
              CheckboxListTile(
                value: sore_throat,
                onChanged: (bool? value) {
                  setState(() {
                    sore_throat = value!;
                  });
                },
                title: Text('Sore throat'),
              ),
              CheckboxListTile(
                value: difficulty_breathing,
                onChanged: (bool? value) {
                  setState(() {
                    difficulty_breathing = value!;
                  });
                },
                title: Text('Difficulty of breathing'),
              ),
              CheckboxListTile(
                value: diarrhea,
                onChanged: (bool? value) {
                  setState(() {
                    diarrhea = value!;
                  });
                },
                title: Text('Diarrhea'),
              ),
              CheckboxListTile(
                value: loss_taste,
                onChanged: (bool? value) {
                  setState(() {
                    loss_taste = value!;
                  });
                },
                title: Text('Loss of taste'),
              ),
              CheckboxListTile(
                value: loss_smell,
                onChanged: (bool? value) {
                  setState(() {
                    loss_smell = value!;
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
                  Entry newEntry = Entry(
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
                    user_key: user_key,
                    edit_request: edit_request,
                    delete_request: delete_request,
                    entry_date: entryDate,
                  );

                  if (newEntry.fever ||
                      newEntry.feverish ||
                      newEntry.muscle_joint_pain ||
                      newEntry.cough ||
                      newEntry.cold ||
                      newEntry.sore_throat ||
                      newEntry.difficulty_breathing ||
                      newEntry.diarrhea ||
                      newEntry.loss_taste ||
                      newEntry.loss_smell) {
                    newEntry.has_symptoms = true;
                    newEntry.status = 'Under Monitoring';
                  } else if (newEntry.had_contact == "Yes") {
                    newEntry.status = 'Under Monitoring';
                    newEntry.has_symptoms = false;
                  } else {
                    newEntry.status = 'Cleared';
                    newEntry.has_symptoms = false;
                  }
                  List<dynamic> entryList = [
                    newEntry.fever,
                    newEntry.feverish,
                    newEntry.muscle_joint_pain,
                    newEntry.cough,
                    newEntry.cold,
                    newEntry.sore_throat,
                    newEntry.difficulty_breathing,
                    newEntry.diarrhea,
                    newEntry.loss_taste,
                    newEntry.loss_smell,
                    newEntry.has_symptoms,
                    newEntry.had_contact,
                    newEntry.status,
                    newEntry.user_key,
                    newEntry.edit_request,
                    newEntry.delete_request,
                    newEntry.entry_date,
                  ];
                  var fullName = user!.firstName + ' ' + user.lastName;
                  Request newReq = new Request(
                      entry: entryList,
                      entry_id: entry_id,
                      type: 'edit',
                      date: editDate,
                      requester_name: fullName);

                  context.read<RequestProvider>().addRequest(newReq);

                  context
                      .read<EntryListProvider>()
                      .changeEditRequest(entry_id!, true);

                  Navigator.pop(context);
                  Navigator.pop(context);

                  // Do something with the newEntry instance, like store it in a database or pass it to another screen
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
