import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Institutes extends StatefulWidget {
  @override
  _InstitutesState createState() => _InstitutesState();
}

class _InstitutesState extends State<Institutes> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, "home");
            },
            child: Icon(Icons.arrow_back_rounded)),
        title: const Text("Institutes"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [Text('data')],
                    );
                  });
            },
            child: const Card(
              child: ListTile(
                title: Text("TNM Football Academy"),
                subtitle: Text("Click me to learn more"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
