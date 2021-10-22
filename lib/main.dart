import 'package:flutter/material.dart';
import 'package:studo/pages/institutes.dart';
import 'package:studo/pages/login.dart';
import 'package:studo/pages/sign_up.dart';
import 'package:studo/pages/start.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
        "home": (BuildContext context) => HomePage(),
        "page1": (BuildContext context) => Institutes(),
      },
    );
  }
}
