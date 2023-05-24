import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screens/EntMonSearchLogs.dart';
import 'package:provider/provider.dart';
import 'providers/TodoListProvider.dart';
import 'providers/AuthProvider.dart';
import 'screens/UserDetailsPage.dart';
import 'screens/SigninPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/UserDetailListProvider.dart';
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
        '/show-qr': (context) => const QrCodePage(),
        '/admin-view-requests': (context) => ViewRequests(),
        '/admin-view-students': (context) => AdminViewStudents(),
        '/admin-view-under-monitoring': (context) => AdminViewUnderMonitoring(),
        '/view-quarantined': (context) => AdminViewQuarantined(),
        '/search-logs': (context) => const EntMonSearchLogs()
      },
    );
  }
}
