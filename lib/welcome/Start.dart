import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Animation/FadingAnimation.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    Navigator.of(context).pushNamed("/login");
  }

  navigateToRegister() async {
    Navigator.pushNamed(context, "/signUp");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white
            //     gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     Color(0xffDAD3C8).withOpacity(0.5),
            //     Color(0xffFFE5DE).withOpacity(0.5),
            //   ],
            // )
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/images/victorychapel.jpg',
                height: 75.0,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "Welcome back!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(65),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Sign in to have access to app",
              style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenUtil().setSp(45),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    2,
                    InkWell(
                      onTap: () {
                        googleSignIn();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // radius of 10
                            color: Color(0xff4EAEFF).withOpacity(0.7)
                            // green as background color
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: new Image.asset(
                                  'assets/images/google_logo.png',
                                  height: 30.0,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign in with Gmail",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
