import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studo/models/user.dart';
import 'package:studo/screens/authenticate/register.dart';
import 'package:studo/screens/authenticate/sign_in.dart';
import 'package:studo/screens/wrapper.dart';
import 'package:studo/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/login': (context) => SignIn(),
          '/register': (context) => Register(),
        },
      ),
    );
  }
}
