import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/AuthProvider.dart';
import '../providers/UserDetailListProvider.dart';
import '../models/UserDetail.dart';
import 'package:flutter/services.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});
  @override
  _UserSignupPageState createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  bool hypertension = false;
  bool diabetes = false;
  bool tuberculosis = false;
  bool cancer = false;
  bool kidneyDisease = false;
  bool cardiacDisease = false;
  bool autoimmuneDisease = false;
  bool asthma = false;
  bool allergy = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController studentNoController = TextEditingController();

  TextEditingController allergyController = TextEditingController();

  List<String> preExistingIllnessList = [];

  bool _passwordHide = true;

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

    void addStudentDetail(UserDetail userDetail) {
      context.read<UserDetailListProvider>().addStudentDetail(userDetail);
    }

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

    void _toggle() {
      setState(() {
        _passwordHide = !_passwordHide;
      });
    }

    final passwordToggle = IconButton(
        icon: Icon(_passwordHide ? Icons.visibility : Icons.visibility_off),
        onPressed: _toggle);

    final password = TextFormField(
      controller: passwordController,
      obscureText: _passwordHide,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: passwordToggle,
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

    final username = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Username",
        // labelText: "Last Name",
      ),
      controller: usernameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input username.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final college = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "College",
        // labelText: "Last Name",
      ),
      controller: collegeController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input college.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final course = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Course",
        // labelText: "Last Name",
      ),
      controller: courseController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please input course.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final studentNo = TextFormField(
      decoration: const InputDecoration(
        hintText: "Student Number",
      ),
      controller: studentNoController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (value) {
        if (value.toString().length != 9) {
          return 'Student number must be 9 numbers.';
        }
        return null;
      }, // adds a validator in the form field
    );

    final allergyTextField = TextFormField(
      decoration: const InputDecoration(
        // contentPadding: EdgeInsets.all(16),
        // border: OutlineInputBorder(),
        hintText: "Allergy (Enumerate all allergies seperated by a comma)",
        // labelText: "Last Name",
      ),
      controller: allergyController,
    );

    

    final preExistingIllness = Text(
        'Please check the box if you have the following pre existing illness:');

    final hypertensionCheckbox = CheckboxListTile(
      value: hypertension,
      onChanged: (value) {
        setState(() {
          hypertension = value ?? false;
        });
      },
      title: Text('Hypertension'),
    );

    final diabetesCheckbox = CheckboxListTile(
      value: diabetes,
      onChanged: (value) {
        setState(() {
          diabetes = value ?? false;
        });
      },
      title: Text('Diabetes'),
    );

    final tuberculosisCheckbox = CheckboxListTile(
      value: tuberculosis,
      onChanged: (value) {
        setState(() {
          tuberculosis = value ?? false;
        });
      },
      title: Text('Tuberculosis'),
    );

    final cancerCheckbox = CheckboxListTile(
      value: cancer,
      onChanged: (value) {
        setState(() {
          cancer = value ?? false;
        });
      },
      title: Text('Cancer'),
    );

    final kindeyDiseaseCheckbox = CheckboxListTile(
      value: kidneyDisease,
      onChanged: (value) {
        setState(() {
          kidneyDisease = value ?? false;
        });
      },
      title: Text('Kidney Disease'),
    );

    final cardiacDiseaseCheckbox = CheckboxListTile(
      value: cardiacDisease,
      onChanged: (value) {
        setState(() {
          cardiacDisease = value ?? false;
        });
      },
      title: Text('Cardiac Disease'),
    );

    final autoimmuneDiseaseCheckbox = CheckboxListTile(
      value: autoimmuneDisease,
      onChanged: (value) {
        setState(() {
          autoimmuneDisease = value ?? false;
        });
      },
      title: Text('Autoimmune disease'),
    );

    final asthmaCheckbox = CheckboxListTile(
      value: asthma,
      onChanged: (value) {
        setState(() {
          asthma = value ?? false;
        });
      },
      title: Text('Asthma'),
    );

    final allergyCheckbox = CheckboxListTile(
      value: allergy,
      onChanged: (value) {
        setState(() {
          allergy = value ?? false;
        });
      },
      title: Text('Allergy'),
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
              if (hypertension == true) {
                preExistingIllnessList.add("Hypertension");
              }

              if (diabetes == true) {
                preExistingIllnessList.add("Diabetes");
              }

              if (tuberculosis == true) {
                preExistingIllnessList.add("Tuberculosis");
              }

              if (cancer == true) {
                preExistingIllnessList.add("Cancer");
              }

              if (kidneyDisease == true) {
                preExistingIllnessList.add("Kidney Disease");
              }

              if (cardiacDisease == true) {
                preExistingIllnessList.add("Cardiac Disease");
              }

              if (autoimmuneDisease == true) {
                preExistingIllnessList.add("Autoimmune Disease");
              }

              if (asthma == true) {
                preExistingIllnessList.add("Asthma");
              }

              UserDetail userDetail = UserDetail(
                  email: emailController.text,
                  firstName: fnameController.text,
                  lastName: lnameController.text,
                  username: usernameController.text,
                  college: collegeController.text,
                  course: courseController.text,
                  allergy: allergyController.text,
                  studentNo: int.parse(studentNoController.text),
                  preExistingIllness: preExistingIllnessList,
                  status: 'No Health Entry',
                  userType: 'User',
                  uid: message,
                  latestEntry: "");
              addStudentDetail(userDetail);
              if (context.mounted) Navigator.pop(context);
            }

            _formKey.currentState?.save();
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.black)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.black)),
      ),
    );

    Widget showForm(BuildContext context) {
      return Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(height: 60, child: email),
            SizedBox(height: 60, child: password),
            SizedBox(height: 60, child: fname),
            SizedBox(height: 60, child: lname),
            SizedBox(height: 60, child: username),
            SizedBox(height: 60, child: college),
            SizedBox(height: 60, child: course),
            SizedBox(height: 90, child: studentNo),
            SizedBox(height: 30, child: preExistingIllness),
            Transform.scale(scale: 0.9, child: hypertensionCheckbox),
            Transform.scale(scale: 0.9, child: diabetesCheckbox),
            Transform.scale(scale: 0.9, child: tuberculosisCheckbox),
            Transform.scale(scale: 0.9, child: cancerCheckbox),
            Transform.scale(scale: 0.9, child: kindeyDiseaseCheckbox),
            Transform.scale(scale: 0.9, child: cardiacDiseaseCheckbox),
            Transform.scale(scale: 0.9, child: autoimmuneDiseaseCheckbox),
            Transform.scale(scale: 0.9, child: asthmaCheckbox),
            Transform.scale(scale: 0.9, child: allergyCheckbox),
            allergy ? allergyTextField : const SizedBox(), 
            signUpButton,
            backButton
          ]));
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(children: const [
          Icon(Icons.local_hospital_rounded, color: Color(0xFF004D40)),
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
