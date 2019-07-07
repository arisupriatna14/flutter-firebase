import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _handleSignIn() async {
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print(user.email);
    print(user.providerId);
    print(user.isEmailVerified);
    print(user.phoneNumber);
    print(user.uid);
    print(user.photoUrl);
    print(user.displayName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('Firebase Auth'),
          actions: <Widget>[
            Icon(Icons.search)
          ],
        ),
        preferredSize: Size.fromHeight(100.0),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Google Sign In'),
          onPressed: () {
            _handleSignIn();
          },
        ),
      ),
    );
  }
}