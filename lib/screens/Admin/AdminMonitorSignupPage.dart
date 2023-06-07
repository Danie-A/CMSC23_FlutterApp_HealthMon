/*
GROUP 2 MEMBERS (B7L) FirebaseEntryAPI.dart

Araez, Danielle Lei R.
Concepcion, Sean Kierby I.
Dela Cruz, Laydon Albert L.
Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through 
daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

PAGE DESCRIPTION
This is where admin or entrance monitor can sign up using the required details.

*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_monitoring_app/providers/AuthProvider.dart';
import 'package:health_monitoring_app/providers/UserDetailListProvider.dart';
import 'package:health_monitoring_app/models/UserDetail.dart';
import 'package:flutter/services.dart';

class AdminMonitorSignupPage extends StatefulWidget {
  const AdminMonitorSignupPage({super.key});
  @override
  _AdminMonitorSignupPageState createState() => _AdminMonitorSignupPageState();
}

class _AdminMonitorSignupPageState extends State<AdminMonitorSignupPage> {
  @override
  Widget build(BuildContext context) {
    void showErrorDialog(String string) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(string,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            content: const Text("Please try again."),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  // Use the local variable to dismiss the dialog
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void addAdminMonitorDetail(UserDetail userDetail) {
      context.read<UserDetailListProvider>().addAdminMonitorDetail(userDetail);
    }

    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fnameController = TextEditingController();
    TextEditingController lnameController = TextEditingController();
    TextEditingController empNoController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController homeUnitController = TextEditingController();

    final email = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Email",
        // labelText: "Email",
      ),
      controller: emailController,
      validator: (value) {
        final bool emailValid = RegExp(
                // from https://stackoverflow.com/questions/16800540/how-should-i-check-if-the-input-is-an-email-address-in-flutter
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value.toString());
        if (!emailValid) {
          return 'Invalid email.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        if (value.toString().length < 6) {
          return 'Password must be at least 6 characters.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final fname = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "First Name",
        // labelText: "First Name",
      ),
      controller: fnameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input first name.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final lname = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Last Name",
        // labelText: "First Name",
      ),
      controller: lnameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input last name.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final empNo = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Employee Number",
        // labelText: "Last Name",
      ),
      controller: empNoController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (value) {
        if (value.toString().length != 9) {
          return 'Employee number must be 9 numbers.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final position = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Position",
        // labelText: "Last Name",
      ),
      controller: positionController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input position.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final homeUnit = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Home Unit",
        // labelText: "Last Name",
      ),
      controller: homeUnitController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input home unit.';
        }
        return null;
      }, // adds a validator in the form field
    );

    var signUpButton = Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            String message = await context
                .read<AuthProvider>()
                .signUp(emailController.text, passwordController.text);

            if (message == 'email-already-in-use') {
              showErrorDialog("Email Already In Use");
            } else {
              String userType = context.read<UserDetailListProvider>().userType;
              if (userType == 'Entrance Monitor') {
                UserDetail userDetail = UserDetail(
                    email: emailController.text,
                    firstName: fnameController.text,
                    lastName: lnameController.text,
                    empNo: int.parse(empNoController.text),
                    position: positionController.text,
                    homeUnit: homeUnitController.text,
                    status: 'No Health Entry',
                    userType: userType,
                    uid: message,
                    latestEntry: "",
                    location: "PhySci Entrance");
                addAdminMonitorDetail(userDetail);
              } else {
                UserDetail userDetail = UserDetail(
                    email: emailController.text,
                    firstName: fnameController.text,
                    lastName: lnameController.text,
                    empNo: int.parse(empNoController.text),
                    position: positionController.text,
                    homeUnit: homeUnitController.text,
                    status: 'No Health Entry',
                    userType: userType,
                    uid: message,
                    latestEntry: "");
                addAdminMonitorDetail(userDetail);
              }

              if (context.mounted) Navigator.pop(context);
            }

            _formKey.currentState?.save();
          }
        },
        child: const Text('Sign up'),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back'),
      ),
    );

    Widget showForm(BuildContext context) {
      return Form(
          key: _formKey,
          child: Column(children: [
            email,
            password,
            fname,
            lname,
            empNo,
            position,
            homeUnit,
            signUpButton,
            backButton
          ]));
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset('icon/HealthMonLogo.png', height: 20, width: 20),
          SizedBox(width: 14),
          Text("HealthMon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ))
        ]),
        backgroundColor: Colors.teal[100],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            showForm(context),
          ],
        ),
      ),
    );
  }
}
