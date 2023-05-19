import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/user_signup.dart';
import '../screens/admin_monitor_signup.dart';

var identities = ['User', 'Admin', 'Entrance Monitor'];
String identityValue = identities.first;

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
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

    final _formSigninKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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

    final identity = DropdownButton<String>(
      value: identityValue,
      icon: const Icon(Icons.arrow_drop_down),
      underline: SizedBox.shrink(),
      onChanged: (String? newValue) {
        // This is called when the user selects an item.
        setState(() {
          identityValue = newValue!;
        });
        print(identityValue);
      },
      items: identities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            'As $value',
            style: const TextStyle(fontSize: 14),
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
                emailController.text.trim(), passwordController.text.trim());
            if (message == 'user-not-found') {
              showErrorDialog("User Not Found");
            } else if (message == 'wrong-password') {
              showErrorDialog("Wrong Password");
            }
          }
        },
        child: const Text('Sign In', style: TextStyle(color: Colors.white)),
      ),
    );

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.only(top: 16.0),
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
        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    Widget showSigninForm(BuildContext context) {
      return Form(
          key: _formSigninKey,
          child: Column(children: [
            email,
            password,
            signinButton,
            const SizedBox(height: 50),
            const Text("Don't have an account?"),
            Row(children: [signUpButton, identity])
          ]));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 41, 24),
        title: Row(children: const [
          Icon(Icons.local_hospital_rounded, color: Colors.green),
          SizedBox(width: 14),
          Text(
            "HealthMon",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            showSigninForm(context)
          ],
        ),
      ),
    );
  }
}
