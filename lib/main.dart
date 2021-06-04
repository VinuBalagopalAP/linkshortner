import 'package:flutter/material.dart';
import 'package:linkshortner/screens/create_account.dart';
import 'package:linkshortner/screens/homepage.dart';
import 'package:linkshortner/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home': (context) => HomeScreen(),
        'create': (context) => CreateAccount(),
        'login': (context) => LoginPage(),
      },
      initialRoute: 'login',
      debugShowCheckedModeBanner: false,
    );
  }
}
