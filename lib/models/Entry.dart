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
>> This page contains the model as well as the details (or attributes) for the entry object.

 */
import 'dart:convert';

class Entry {
  bool fever;
  bool feverish;
  bool muscle_joint_pain;
  bool cough;
  bool cold;
  bool sore_throat;
  bool difficulty_breathing;
  bool diarrhea;
  bool loss_taste;
  bool loss_smell;
  bool has_symptoms;
  String had_contact;
  String status;
  String user_key;
  bool edit_request;
  bool delete_request;
  String entry_date;
  String? id;

  Entry(
      {required this.fever,
      required this.feverish,
      required this.muscle_joint_pain,
      required this.cough,
      required this.cold,
      required this.sore_throat,
      required this.difficulty_breathing,
      required this.diarrhea,
      required this.loss_taste,
      required this.loss_smell,
      required this.has_symptoms,
      required this.had_contact,
      required this.status,
      required this.user_key,
      required this.edit_request,
      required this.delete_request,
      required this.entry_date,
      this.id});

// get ENTRY from JSON
  // Factory constructor to instantiate object from json format
  factory Entry.entryFromJson(Map<String, dynamic> json) {
    return Entry(
        fever: json['fever'],
        feverish: json['feverish'],
        muscle_joint_pain: json['muscle_joint_pain'],
        cough: json['cough'],
        cold: json['cold'],
        sore_throat: json['sore_throat'],
        difficulty_breathing: json['difficulty_breathing'],
        diarrhea: json['diarrhea'],
        loss_taste: json['loss_taste'],
        loss_smell: json['loss_smell'],
        has_symptoms: json['has_symptoms'],
        had_contact: json['had_contact'],
        status: json['status'],
        user_key: json['user_key'],
        edit_request: json['edit_request'],
        delete_request: json['delete_request'],
        entry_date: json['entry_date'],
        id: json['id']);
  }

  factory Entry.simpleEntryFromJson(Map<String, dynamic> json) {
    return Entry(
        fever: false,
        feverish: false,
        muscle_joint_pain: false,
        cough: false,
        cold: false,
        sore_throat: false,
        difficulty_breathing: false,
        diarrhea: false,
        loss_taste: false,
        loss_smell: false,
        has_symptoms: false,
        had_contact: json['had_contact'],
        status: json['status'],
        user_key: json['user_key'],
        edit_request: false,
        delete_request: false,
        entry_date: json['entry_date'],
        id: json['id']);
  }

// list of entries
  static List<Entry> entryFromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Entry>((dynamic d) => Entry.entryFromJson(d)).toList();
  }

// entry to JSON
  Map<String, dynamic> entryToJson(Entry entry) {
    return {
      'fever': entry.fever,
      'feverish': entry.feverish,
      'muscle_joint_pain': entry.muscle_joint_pain,
      'cough': entry.cough,
      'cold': entry.cold,
      'sore_throat': entry.sore_throat,
      'difficulty_breathing': entry.difficulty_breathing,
      'diarrhea': entry.diarrhea,
      'loss_taste': entry.loss_taste,
      'loss_smell': entry.loss_smell,
      'has_symptoms': entry.has_symptoms,
      'had_contact': entry.had_contact,
      'status': entry.status,
      'user_key': entry.user_key,
      'edit_request': entry.edit_request,
      'delete_request': entry.delete_request,
      'entry_date': entry.entry_date
    };
  }
}
