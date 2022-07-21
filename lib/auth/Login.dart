import 'dart:async';
import 'dart:math';

import 'package:WeightApp/welcome/Animation/FadingAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants.dart';
import 'SignUp.dart';
import 'forgotpassword.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        if (googleAuth.idToken != null && googleAuth.accessToken != null) {
          final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

          final UserCredential user =
              await _auth.signInWithCredential(credential);

          await Navigator.pushReplacementNamed(context, "/");
          // updatetoken();

          return user;
        } else {
          throw StateError('Missing Google Auth Token');
        }
      } else
        throw StateError('Sign in Aborted');
    }
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  static const listCinematicImages = [
    'assets/images/img1.JPG',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img1.JPG',
  ];

  String currentImage = 'assets/images/img1.JPG';
  Timer _timer;
  bool isLoading = false;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 8), (Timer t) {
      final newImage = _getRandomImage();
      setState(() => currentImage = newImage);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    this.checkAuthentification();
    super.dispose();
  }

  String _getRandomImage() {
    final randomIndex = Random().nextInt(listCinematicImages.length - 1);
    return listCinematicImages[randomIndex];
  }
  // @override
  // void initState() {
  //   super.initState();
  //   this.checkAuthentification();
  // }

  login() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        try {
          await _auth.signInWithEmailAndPassword(
              email: _email.replaceAll(' ', ''), password: _password);
          await Navigator.pushReplacementNamed(context, "/");
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.message,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
          ));
          _emailController.clear();
          _passwordController.clear();
          setState(() {
            isLoading = false;
          });
          print(e);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  // void updatetoken() async {
  //   var ref = FirebaseFirestore.instance
  //       .collection("users")
  //       .doc('${FirebaseAuth.instance.currentUser.uid},');
  //   ref.set({
  //     "user_id": FirebaseAuth.instance.currentUser.uid,
  //     "user_email": FirebaseAuth.instance.currentUser.email,
  //     'user_name': FirebaseAuth.instance.currentUser.displayName,
  //     "isAdmin": false,
  //   }).whenComplete(() => {
  //         _firebaseMessaging.getToken().then((token) {
  //           print(token);
  //           ref.update({'token': token.toString()});
  //         })
  //       });
  //   await FirebaseFirestore.instance
  //       .collection("generalGroups")
  //       .doc("testimonies")
  //       .collection("members")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .set({
  //     'name': FirebaseAuth.instance.currentUser.displayName,
  //     "photo": FirebaseAuth.instance.currentUser.photoURL,
  //     "profession": FirebaseAuth.instance.currentUser.uid,
  //     "isAdmin": false,
  //   }).whenComplete(() => {
  //             _firebaseMessaging.getToken().then((token) async {
  //               print(token);
  //               await FirebaseFirestore.instance
  //                   .collection("generalGroups")
  //                   .doc("testimonies")
  //                   .collection("members")
  //                   .doc(FirebaseAuth.instance.currentUser.uid)
  //                   .update({'token': token.toString()});
  //             })
  //           });
  //   await FirebaseFirestore.instance
  //       .collection("usersGeneralGroups")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .collection("groups")
  //       .doc("testimonies")
  //       .set({
  //     "userId": FirebaseAuth.instance.currentUser.uid,
  //     "isAdmin": false,
  //     'pending': false,
  //     "name": 'testimonies',
  //     'type': 'public'
  //   });
  //   await FirebaseFirestore.instance
  //       .collection("generalGroups")
  //       .doc("prayers")
  //       .collection("members")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .set({
  //     'name': FirebaseAuth.instance.currentUser.displayName,
  //     "photo": FirebaseAuth.instance.currentUser.photoURL,
  //     "profession": FirebaseAuth.instance.currentUser.uid,
  //     "isAdmin": false,
  //   }).whenComplete(() => {
  //             _firebaseMessaging.getToken().then((token) async {
  //               print(token);
  //               await FirebaseFirestore.instance
  //                   .collection("generalGroups")
  //                   .doc("prayers")
  //                   .collection("members")
  //                   .doc(FirebaseAuth.instance.currentUser.uid)
  //                   .update({'token': token.toString()});
  //             })
  //           });
  //   await FirebaseFirestore.instance
  //       .collection("usersGeneralGroups")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .collection("groups")
  //       .doc("prayers")
  //       .set({
  //     "userId": FirebaseAuth.instance.currentUser.uid,
  //     "isAdmin": false,
  //     'pending': false,
  //     "name": 'prayers',
  //     'type': 'public'
  //   });
  // }

  void showSuccessNotification(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.green[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.green[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  void showErrorNotification(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.red[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  String validateEmail(String value) {
    if (value.trim().length < 1) return "Email can't be empty";
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) return "Invalid email address";
    return null;
  }

  String validatepassword(String value) {
    if (value.trim().length < 1)
      return "Password must be more than 6 characters";
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
        .hasMatch(value.trim()))
      return "Password must contain capital,small letters and numbers";
    return null;
  }

  navigateToSignUp() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  navigateToforget() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Forgot()));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  currentImage,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Constant.mainColor.withOpacity(0.7),
                    Colors.white.withOpacity(0.9),
                    Colors.white,
                  ],
                )),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        'assets/images/victorychapel_bg.png',
                        height: 75.0,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "Welcome back!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(65),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Sign in to have access to app",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenUtil().setSp(45),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(color: Colors.black54),
                                    validator: validateEmail,
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle:
                                            TextStyle(color: Colors.black54),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.black54,
                                        )),
                                    onSaved: (input) => _email = input),
                              ),
                              Container(
                                child: TextFormField(
                                    style: TextStyle(color: Colors.black54),
                                    validator: validatepassword,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    obscureText: true,
                                    onSaved: (input) => _password = input),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      onTap: navigateToforget,
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                            2,
                            InkWell(
                              onTap: () {
                                login();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // radius of 10
                                    color: Constant.mainColor.withOpacity(0.7)
                                    // green as background color
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isLoading
                                          ? CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                            )
                                          : Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Divider(
                                color: Colors.black54,
                              )),
                          Expanded(
                              flex: 2,
                              child: Center(
                                  child: Text(
                                'or',
                                style: TextStyle(color: Colors.black54),
                              ))),
                          Expanded(
                              flex: 4,
                              child: Divider(
                                color: Colors.black54,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
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
                                    borderRadius: BorderRadius.circular(
                                        10), // radius of 10
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
                    SizedBox(height: 30),
                    Center(
                      child: GestureDetector(
                        child: Text(
                          'Don\'t have an Account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: navigateToSignUp,
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
              isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: SpinKitThreeBounce(
                          color: Colors.black,
                          size: 30,
                        ),
                      ))
                  : SizedBox()
            ],
          ),
        ));
  }
}
