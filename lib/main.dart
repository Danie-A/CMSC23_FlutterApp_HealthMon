import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/TodoListProvider.dart';
import 'providers/AuthProvider.dart';
import 'screens/TodoPage.dart';
import 'screens/UserDetailsPage.dart';
import 'screens/SigninPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/UserDetailListProvider.dart';
import '../screens/UserAddEntry.dart';
import '../screens/QrCodePage.dart';
import 'screens/MyProfile.dart';
import 'screens/AdminViewStudents.dart';

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
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.green),
      routes: {
        '/': (context) => const MyProfile(),
        '/login': (context) => const SigninPage(),
        '/user-profile': (context) => const SigninPage(),
        '/user-details': (context) => const UserDetailsPage(),
        '/user-add-entry': (context) => UserAddEntry(),
        '/show-qr': (context) => const QrCodePage(),
        '/admin-view-students': (context) => AdminViewStudents()
      },
    );
  }
}
