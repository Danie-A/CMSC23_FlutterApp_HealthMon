import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Sample"),
      ),
      backgroundColor: Colors.grey.shade600,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: QrImage(
                data: data,
                backgroundColor: Colors.white,
                size: 300.0,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: 300.0,
              child: TextField(
                //we will generate a new qr code when the input value change
                onChanged: (value) {
                  setState(() {
                    data = value;
                  });
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Type the Data",
                  filled: true,
                  fillColor: Colors.black54,
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              fillColor: Colors.amber.shade100,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(
                horizontal: 36.0,
                vertical: 16.0,
              ),
              child: Text(
                "Back",
              ),
            )
          ],
        ),
      ),
    );
  }
}
