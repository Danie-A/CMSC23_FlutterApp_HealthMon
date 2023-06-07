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
>> This shows the QR code of the user's health entry to be scanned by the entrance monitor.

*/

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../providers/UserDetailListProvider.dart';
import '../../models/UserDetail.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  Future<String> saveImage(Uint8List image) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = "screenshot-$time";
    final result = await ImageGallerySaver.saveImage(image, name: name);
    Navigator.of(context).pop();
    return result['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    UserDetail? user = context.read<UserDetailListProvider>().currentUser;
    String name = "${user?.firstName} ${user?.lastName}";
    String studentNo = '';
    if (user?.userType == 'User') {
      studentNo = "${user?.studentNo}";
    } else {
      studentNo = "${user?.empNo}";
    }

    String status = "${user?.status}";
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Icon(Icons.qr_code_2_rounded, color: Color(0xFF004D40)),
          SizedBox(width: 14),
          Text("QR Code",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[200],
      ),
      backgroundColor: Colors.teal[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _screenshotController
              .capture(delay: Duration(milliseconds: 10))
              .then((capturedImage) async {
            await saveImage(capturedImage!);
            // ShowCapturedWidget(context, capturedImage!);
          }).catchError((onError) {
            print(onError);
          });
        },
        child: Icon(Icons.file_download_outlined),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * .1),
            Screenshot(
              controller: _screenshotController,
              child: Container(
                color: Colors.teal[100],
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        child: QrImageView(
                          data: "$name\n$studentNo\n$status",
                          backgroundColor: Color.fromRGBO(128, 203, 196, 1),
                          // ignore: deprecated_member_use
                          foregroundColor: Color.fromRGBO(0, 77, 64, 1),
                          size: screenWidth * .5,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: Text(
                              "Name: ${user?.firstName} ${user?.lastName}")),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(child: Text("Status: ${user?.status}")),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: Text("Entry Date: ${user?.latestEntry}")),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back", style: TextStyle(color: Colors.teal[900]))),
          ],
        ),
      ),
    );
  }
}
