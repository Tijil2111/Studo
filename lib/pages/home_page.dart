
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:studo/pages/institutes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  PageController pageController = PageController();
  int _selectedIndex = 0;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  navigateToPage1() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Institutes()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.orangeAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            child: !isloggedin
                ? const CircularProgressIndicator()
                : Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Image(
                        image: AssetImage('assets/click.png'),
                        height: 200,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, "page1");
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 600,
                                  height: 50,
                                  color: Colors.orangeAccent,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 100.0, top: 10),
                                    child: Text(
                                      'Donate to Institutes',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
          ),
          Container(
            child: !isloggedin
                ? const CircularProgressIndicator()
                : Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Interested in knowing how does the app work read further !',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                            'So first of all thank you for deciding to help all those needies. Our app has a simple yet intuitive algorithm. Whenever you create an account you are assigned a new UID or identification id that is unique to your account Then you are at home page provided with various places where you can donate money. You can click at the place you want to donate and then call them and ask them how to pay the money or any other way in which you can help them. If you pay them through UPI dont forget to copy paste the below message. Also tell them you are donating through an app called Donateo. This is completly optional. '),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                            "Hello I am making this donation and found about you from an app called Donateo.                                                               My Unique ID is, ${user.uid}"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text:
                                  "Hello I am making this donation and found about you from an app called Donateo.My Unique ID is, ${user.uid}"));
                        },
                        color: Colors.orangeAccent,
                        child: const Text('Click to Copy the message'),
                      ),
                    ],
                  ),
          ),
          Container(
            child: !isloggedin
                ? const CircularProgressIndicator()
                : Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Name - ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            user.displayName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Registered Email ID - ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Unique ID - ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            user.uid,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: user.uid));
                        },
                        color: Colors.orangeAccent,
                        child: const Text('Click to Copy UID'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          signOut();
                        },
                        child: const Text('Sign Out'),
                        color: Colors.orangeAccent,
                      )
                    ],
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'About'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onTap,
      ),
    );
  }
}
