import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Enter An Email",
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Enter Password",
                  border: UnderlineInputBorder(),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((signUp) {
                    Navigator.of(context).pushReplacementNamed('/startingPage');
                  });
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
