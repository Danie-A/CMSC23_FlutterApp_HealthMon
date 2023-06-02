import 'dart:js';

import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screens/EntMonSearchLogs.dart';
import 'package:health_monitoring_app/screens/UserEditEntry.dart';
import 'package:provider/provider.dart';
import 'providers/TodoListProvider.dart';
import 'providers/AuthProvider.dart';
import 'screens/QrScanPage.dart';
import 'screens/TodoPage.dart';
import 'screens/UserDetailsPage.dart';
import 'screens/SigninPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/UserDetailListProvider.dart';
import 'providers/LogProvider.dart';
import '../providers/EntryListProvider.dart';
import '../screens/UserAddEntry.dart';
import '../screens/QrCodePage.dart';
import 'screens/MyProfile.dart';
import 'screens/ViewRequests.dart';
import 'screens/AdminViewStudents.dart';
import 'screens/ViewRequests.dart';
import 'screens/AdminViewQuarantined.dart';
import 'screens/AdminViewUnderMonitoring.dart';
import 'screens/EntMonSearchLogs.dart';
import 'screens/EntMonViewLogs.dart';
import 'providers/RequestProvider.dart';

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
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case '/': // route for homepage
      //       return MaterialPageRoute(
      //         builder: (context) => MyProfile(),
      //       );
      //     case '/login': // route for sign in
      //       return MaterialPageRoute(
      //         builder: (context) => SigninPage(),
      //       );
      //     case '/user-profile': // route for sign in
      //       return MaterialPageRoute(
      //         builder: (context) => SigninPage(),
      //       );
      //     case '/user-details': // route for sign in
      //       return MaterialPageRoute(
      //         builder: (context) => UserDetailsPage(),
      //       );
      //     case '/user-profile': // route for info of a specific friend
      //       final args = settings.arguments as Friend;
      //       return MaterialPageRoute(
      //         builder: (context) => FriendDetails(friend: args),
      //       );
      //     default:
      //       return null;
      //   }
      // },
      routes: {
        '/': (context) => const MyProfile(),
        '/login': (context) => const SigninPage(),
        '/user-profile': (context) => const SigninPage(),
        '/user-details': (context) => const UserDetailsPage(),
        '/user-add-entry': (context) => UserAddEntry(),
        '/user-edit-entry': (context) => UserEditEntry(),
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
