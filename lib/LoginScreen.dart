import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  __login() async {
    try {
      await _googleSignIn.signIn().then((singedIn) {
        Navigator.of(context).pushReplacementNamed('/homeScreen');
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Container(
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Password',
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                RaisedButton(
                    child: Text('Sign In'),
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((singedIn) {
                        Navigator.of(context)
                            .pushReplacementNamed('/homeScreen');
                      });
                    }),
                OutlineButton(
                  onPressed: () {
                    __login();
                  },
                  child: Text("Sign In with Google"),
                ),
                Text('Don\'t have an account?'),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signUp');
                  },
                  child: Text(
                    'Sign up?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
