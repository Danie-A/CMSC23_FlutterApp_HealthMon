import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screens/MyProfile.dart';
import 'package:provider/provider.dart';
import '../models/Entry.dart';
import '../providers/EntryListProvider.dart';
import '../screens/myprofile.dart';
import 'package:intl/intl.dart';

class UserEditEntry extends StatefulWidget {
  @override

  _UserEditEntryState createState() => _UserEditEntryState();
}

class _UserEditEntryState extends State<UserEditEntry> {
  
  

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String entryDate = DateFormat('yMd').format(now);

    Entry entry = context.watch<EntryListProvider>().getCurrentEntry();

    bool fever = entry.fever;
    bool feverish = entry.feverish;
    bool muscle_joint_pain = entry.muscle_joint_pain;
    bool cough = entry.cough;
    bool cold = entry.cold;
    bool sore_throat = entry.sore_throat;
    bool difficulty_breathing = entry.difficulty_breathing;
    bool diarrhea = entry.diarrhea;
    bool loss_taste = entry.loss_taste;
    bool loss_smell = entry.loss_smell;
    bool has_symptoms = entry.has_symptoms;
    String had_contact = entry.had_contact;
    String status = entry.status;
    String user_key = entry.user_key;
    bool edit_request = entry.edit_request;
    bool delete_request = entry.delete_request;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Entry'),
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
                        user_key: user_key,
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
                      newEntry.status = "under_monitoring";
                    }

                    context.read<EntryListProvider>().addEntryDetail(newEntry);

                    Navigator.pop(context);

                    // Do something with the newEntry instance, like store it in a database or pass it to another screen
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          )),
    );
  }
}