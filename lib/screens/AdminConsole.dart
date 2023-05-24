import 'package:flutter/material.dart';

class AdminConsole extends StatelessWidget {
  const AdminConsole({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return (Container(
      height: screenWidth * .7,
      width: screenWidth * .7,
      margin: EdgeInsets.only(top: 10),
      child: GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              child: Center(
                  child:
                      Text("View All Students", textAlign: TextAlign.center))),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              child: Center(
                  child: Text("View Quarantined Students",
                      textAlign: TextAlign.center))),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              child: Center(
                  child: Text("Under Monitoring Students",
                      textAlign: TextAlign.center))),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              child: Center(
                  child:
                      Text("Student Requests", textAlign: TextAlign.center))),
        ],
      ),
    ));
  }
}
