import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/studying.png'),
              radius: 90,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome to Studo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.purple,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Studying is a lot of fun. But becomes messy without proper coaching and without maintaining tasks. This app is your ultimate guide to maintain tasks and give coaching institutes. The tasks are saved on a database so you can still see the tasks if you change your phone :) ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.purple),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(
                Icons.arrow_right_alt_outlined,
                size: 45,
              ),
              label: Text(''),
              color: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
