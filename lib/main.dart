import 'package:flutter/material.dart';
import 'package:mobile_banking_system/src/widgets/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseUser user;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  loginWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(),
      home: user == null
          ? LoginScreen(
              login: loginWithGoogle,
            )
          : HomeScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final Function login;

  const LoginScreen({Key key, @required this.login}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Center(
          child: IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: login,
            iconSize: 60.0,
          ),
        ),
      ),
    );
  }
}
