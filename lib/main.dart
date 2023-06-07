/*
GROUP 2 MEMBERS (ST6L)
>> Araez, Danielle Lei R.
>> Concepcion, Sean Kierby I.
>> Dela Cruz, Laydon Albert L.
>> Luñeza, Marcel Luiz G.

PROGRAM DESCRIPTION
>> This program simulates an OHMS-like application where users can monitor their health through daily health entries to be QR scanned by entrance monitor and managed by the application's admin.

>> This is the main file of the program. It contains the main function and the main widget of the program. It also contains the routes of the program's screens.
*/

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screens/Entrance%20Monitor/EntMonSearchLogs.dart';
import 'package:health_monitoring_app/screens/User/UserEditEntry.dart';
import 'package:provider/provider.dart';
import 'providers/TodoListProvider.dart';
import 'providers/AuthProvider.dart';
import 'screens/Entrance Monitor/QrScanPage.dart';
import 'screens/User/UserDetailsPage.dart';
import 'screens/SigninPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/UserDetailListProvider.dart';
import 'providers/LogProvider.dart';
import '../providers/EntryListProvider.dart';
import '../screens/User/UserAddEntry.dart';
import 'screens/User/QrCodePage.dart';
import 'screens/MyProfile.dart';
import 'screens/Admin/ViewRequests.dart';
import 'screens/Admin/AdminViewStudents.dart';
import 'screens/Admin/AdminViewQuarantined.dart';
import 'screens/Admin/AdminViewUnderMonitoring.dart';
import 'screens/Entrance Monitor/EntMonViewLogs.dart';
import 'providers/RequestProvider.dart';
import 'screens/User/UserDeleteEntry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => UserDetailListProvider())),
        ChangeNotifierProvider(create: ((context) => EntryListProvider())),
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
        ChangeNotifierProvider(create: ((context) => LogProvider())),
        ChangeNotifierProvider(create: ((context) => RequestProvider()))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMon App',
      initialRoute: '/',
      theme: ThemeData(
          useMaterial3: true,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Color(0xFF004D40), //<-- SEE HERE
                displayColor: Color(0xFF004D40),
              ), //<-- SEE HERE
          brightness: Brightness.light,
          colorSchemeSeed: Colors.teal),
      routes: {
        '/': (context) => const MyProfile(),
        '/login': (context) => const SigninPage(),
        '/user-profile': (context) => const SigninPage(),
        '/user-details': (context) => const UserDetailsPage(),
        '/user-add-entry': (context) => UserAddEntry(),
        '/user-edit-entry': (context) => UserEditEntry(),
        '/user-delete-entry': (context) => UserDeleteEntry(),
        '/show-qr': (context) => const QrCodePage(),
        '/scan-qr': (context) => QrScanPage(),
        //admin console
        '/view-students': (context) => AdminViewStudents(),
        '/view-quarantined': (context) => AdminViewQuarantined(),
        '/view-under-monitoring': (context) => AdminViewUnderMonitoring(),
        '/view-requests': (context) => ViewRequests(),
        //entmon console
        '/search-logs': (context) => const EntMonSearchLogs(),
        '/view-logs': (context) => const EntMonViewLogs(),
      },
    );
  }
}
