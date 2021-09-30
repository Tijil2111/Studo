import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studo/models/user.dart';
import 'package:studo/screens/authenticate/authenticate.dart';
import 'package:studo/screens/home/home.dart';
import 'package:studo/screens/main%20screens/welcome.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return WelcomePage();
    } else {
      return Home();
    }
  }
}
