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
>> This page is the sign In Page where users can sign in to the application.

>> It shows the Sign Up Button where the user can choose whether to go to the User, Entrance Monitor, or
Admin Sign Up Page.
*/

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/api/GoogleAuth.dart';
import 'package:health_monitoring_app/providers/UserDetailListProvider.dart';
import 'package:provider/provider.dart';
import '../providers/AuthProvider.dart';
import 'User/UserSignupPage.dart';
import 'Admin/AdminMonitorSignupPage.dart';

var identities = ['User', 'Admin', 'Entrance Monitor'];
String identityValue = identities.first;

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    void showErrorDialog(String string) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              string,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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

    final _formSigninKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final email = TextFormField(
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      controller: emailController,
      validator: (value) {
        final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value.toString());
        if (!emailValid) {
          return 'Invalid email.';
        }
        return null;
      },
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
      },
    );

    final identity = DropdownButton<String>(
      borderRadius: BorderRadius.circular(20),
      value: identityValue,
      icon: const Icon(Icons.arrow_drop_down),
      dropdownColor: Colors.teal[100],
      underline: SizedBox.shrink(),
      onChanged: (String? newValue) {
        setState(() {
          identityValue = newValue!;
        });
        print(identityValue);
        context.read<UserDetailListProvider>().setUserType(identityValue);
      },
      items: identities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'As $value',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        );
      }).toList(),
    );

    final signinButton = Padding(
      key: const Key('signinButton'),
      padding: const EdgeInsets.only(top: 30.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formSigninKey.currentState!.validate()) {
            String message = await context.read<AuthProvider>().signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );

            if (message == 'user-not-found') {
              showErrorDialog("User Not Found");
            } else if (message == 'wrong-password') {
              showErrorDialog("Wrong Password");
            }
          }
        },
        child: const Text('Sign In'),
      ),
    );

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        onPressed: () async {
          if (identityValue == 'User') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserSignupPage(),
              ),
            );
          } else if (identityValue == 'Admin' ||
              identityValue == 'Entrance Monitor') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AdminMonitorSignupPage(),
              ),
            );
          }
        },
        child: const Text('Sign Up'),
      ),
    );

    Widget showSigninForm(BuildContext context) {
      return Form(
        key: _formSigninKey,
        child: Column(
          children: [
            email,
            password,
            signinButton,
            const SizedBox(height: 28),
            const Text("Don't have an account?"),
            Wrap(
              spacing: 20,
              children: [
                signUpButton,
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: identity,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('icon/HealthMonLogo.png', height: 20, width: 20),
            SizedBox(width: 14),
            Text(
              "HealthMon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal[100],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            Image.asset('icon/HealthMonLogo.png', height: 100, width: 100),
            SizedBox(height: 20),
            const Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            showSigninForm(context),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 16.0),
              child: IconButton(
                icon: const Icon(Icons.language_outlined),
                onPressed: () {
                  GoogleAuth().signInWithGoogle();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
