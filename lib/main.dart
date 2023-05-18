import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/todo_page.dart';
import '../screens/user_details.dart';
import '../screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '../providers/userdetail_provider.dart';

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
        '/': (context) => const TodoPage(),
        '/login': (context) => const SigninPage(),
        '/todo': (context) => const SigninPage(),
        '/user_details': (context) => const UserDetailsPage(),
      },
    );
  }
}
