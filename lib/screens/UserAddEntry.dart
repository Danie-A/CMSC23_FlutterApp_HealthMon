import 'package:flutter/material.dart';

class UserAddEntry extends StatefulWidget {
  @override
  _UserAddEntryState createState() => _UserAddEntryState();
}

class _UserAddEntryState extends State<UserAddEntry> {
  static final List<String> _symptoms = [
    "Fever(37.8 C and above)",
    "Feeling feverish",
    "Muscle or joint pains",
    "Cough",
    "Sore throat",
    "Difficulty of breathing",
    "Diarrhea",
    "Loss of taste",
    "Loss of smell"
  ];

  List<bool> isCheckedList = List.generate(_symptoms.length, (index) => false);
  String? encounterAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Entry'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please check the box for each symptom you are experiencing:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              CheckboxListWidget(),
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
                    groupValue: encounterAnswer,
                    onChanged: (value) {
                      setState(() {
                        encounterAnswer = value;
                      });
                    },
                  ),
                  Text('Yes'),
                  Radio<String>(
                    value: 'No',
                    groupValue: encounterAnswer,
                    onChanged: (value) {
                      setState(() {
                        encounterAnswer = value;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  //ADD SUBMIT BUTTON FUNCTIONALITY
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

class CheckboxListWidget extends StatefulWidget {
  @override
  _CheckboxListWidgetState createState() => _CheckboxListWidgetState();
}

class _CheckboxListWidgetState extends State<CheckboxListWidget> {
  static final List<String> _symptoms = [
    "Fever(37.8 C and above)",
    "Feeling feverish",
    "Muscle or joint pains",
    "Cough",
    "Sore throat",
    "Difficulty of breathing",
    "Diarrhea",
    "Loss of taste",
    "Loss of smell"
  ];

  List<bool> isCheckedList = List.generate(_symptoms.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _symptoms.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          value: isCheckedList[index],
          onChanged: (bool? value) {
            setState(() {
              isCheckedList[index] = value!;
            });
          },
          title: Text(_symptoms[index]),
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }
}
