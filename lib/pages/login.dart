import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: const CircleAvatar(
                radius: 200,
                backgroundImage: AssetImage('assets/login.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.isEmpty) return 'Email';
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purpleAccent, width: 3)
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 3)
                            ),
                          ),
                          onSaved: (input) => _email = input),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should be 6 + characters';
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purpleAccent, width: 3)
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 3)
                            ),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: login,
                      child: const Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: const Text('Dont have an account'),
              onTap: navigateToSignUp,
            )
          ],
        ),
      ),
    ));
  }
}
