import "package:flutter/material.dart";
import 'package:health_monitoring_app/models/Entry.dart';

class HealthEntry extends StatelessWidget {
  // this shows the health entry details list
  Entry entry;
  HealthEntry({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
            alignment: Alignment.center,
            height: 50,
            color: Colors.teal,
            child: Text("${entry.entry_date} - ${entry.status}")));
  }
}
