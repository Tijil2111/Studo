import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studo/pages/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _name);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
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
            title: const Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 170,
              backgroundImage: AssetImage('assets/register.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 10,
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
                            if (input.isEmpty) return 'Name';
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purpleAccent, width: 2)
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 2)
                            ),
                          ),
                          onSaved: (input) => _name = input),
                    ),
                    SizedBox(height: 10,),
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
                                borderSide: BorderSide(color: Colors.purpleAccent, width: 2)
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 2)
                            ),
                          ),
                          onSaved: (input) => _email = input),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should be 6 + characters long';
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purpleAccent, width: 2)
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 2)
                            ),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),
                    SizedBox(height: 25),
                    RaisedButton(
                      padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: signUp,
                      child: const Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: const Text(
                        'Have an Account ? Login ',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
