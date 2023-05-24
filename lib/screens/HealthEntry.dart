import "package:flutter/material.dart";

class HealthEntry extends StatelessWidget {
  const HealthEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          height: 50,
          color: Colors.teal,
        ));
  }
}
