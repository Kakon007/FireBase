import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_in/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class UiDesign extends StatefulWidget {
  UiDesign({Key key}) : super(key: key);

  @override
  _UiDesignState createState() => _UiDesignState();
}

class _UiDesignState extends State<UiDesign> {
  final _txtemail = TextEditingController();
  final _txtpassword = TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Google Sign in
  Future<void> _googlesignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      AuthResult result = (await _auth.signInWithCredential(credential));

      FirebaseUser user = result.user;
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: user,
            ),
          ),
        );
      } else {
        print("Error");
      }
    } catch (error) {
      print(error.message);
    }
  }

  //facebook sign in

  void _signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
    print(graphResponse.body);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.getCredential(accessToken: token);
      _auth.signInWithCredential(credential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/location.png'),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                      controller: _txtemail,
                      decoration: InputDecoration(
                        hintText: "Enter an Email",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: 2.0), // add padding to adjust icon
                          child: Icon(Icons.supervised_user_circle),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: _txtpassword,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: 2.0), // add padding to adjust icon
                          child: Icon(Icons.phone_android),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Forget the password?',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                      height: 58,
                      minWidth: 365,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      onPressed: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: _txtemail.text.trim(),
                          password: _txtpassword.text.trim(),
                        )
                            .then((singedIn) {
                          Navigator.of(context)
                              .pushReplacementNamed('homeemail');
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            height: 55,
                            minWidth: 365,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(
                                  topLeft: Radius.circular(15)),
                            ),
                            onPressed: () {
                              _signInFacebook();
                            },
                            child: Text(
                              "Facebook",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            color: Colors.blue[800],
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 55,
                            minWidth: 365,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(
                                  bottomRight: Radius.circular(15)),
                            ),
                            onPressed: () {
                              _googlesignIn();
                            },
                            child: Text(
                              "Google",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.red,
                              ),
                            ),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Don\'t have an Account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _txtemail.text.trim(),
                                password: _txtpassword.text.trim())
                            .then((signUp) {
                          Navigator.of(context).pushReplacementNamed('start');
                        });
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
