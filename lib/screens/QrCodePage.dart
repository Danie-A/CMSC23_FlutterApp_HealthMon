import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  Map data = {
    "firstName": "Marcel Luiz",
    "lastName": "Luneza",
    "id": "2U2n8QuGQpFz7pE2NzWp",
    "date": "December 01, 2002",
    "studentNo": "2021-00000"
  };

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code"),
      ),
      backgroundColor: Colors.grey.shade600,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * .1),
            Center(
              child: QrImage(
                data: data['id'],
                backgroundColor: Colors.white,
                size: screenWidth * .65,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(5.0),
              child: Center(
                  child: Text("${data["firstName"]} ${data["lastName"]}")),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Center(child: Text("${data["studentNo"]}")),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Center(child: Text("${data["date"]}")),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text("INSERT MORE EME")),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back")),
          ],
        ),
      ),
    );
  }
}
