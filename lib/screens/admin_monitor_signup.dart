import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/userdetail_provider.dart';
import '../models/UserDetail.dart';

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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input employtee number';
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
            } else if (message == '') {
              UserDetail userDetail = UserDetail(
                  email: emailController.text,
                  firstName: fnameController.text,
                  lastName: lnameController.text,
                  empNo: int.parse(empNoController.text),
                  position: positionController.text,
                  homeUnit: homeUnitController.text,
                  status: 'No Health Entry',
                  userType: 'Admin');
              addAdminMonitorDetail(userDetail);
              if (context.mounted) Navigator.pop(context);
            }

            _formKey.currentState?.save();
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
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
        backgroundColor: Color.fromARGB(255, 10, 41, 24),
        title: Row(children: const [
          Icon(Icons.edit_square, color: Colors.green),
          SizedBox(width: 14),
          Text(
            "To Do List",
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
