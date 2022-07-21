import 'dart:async';
import 'dart:math';

import 'package:WeightApp/auth/Login.dart';
import 'package:WeightApp/welcome/Animation/FadingAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants.dart';
import 'agreement.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
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

          return user;
        } else {
          throw StateError('Missing Google Auth Token');
        }
      } else
        throw StateError('Sign in Aborted');
    }
    setState(() {
      isLoading = false;
    });
  }

  String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
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
  bool value = false;

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
    this.checkAuthentication();
    super.dispose();
  }

  String _getRandomImage() {
    final randomIndex = Random().nextInt(listCinematicImages.length - 1);
    return listCinematicImages[randomIndex];
  }

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

  signUp() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        try {
          UserCredential user = await _auth.createUserWithEmailAndPassword(
              email: _email.replaceAll(' ', ''), password: _password);
          if (user != null) {
            await _auth.currentUser.updateProfile(displayName: _name);
            await Navigator.pushReplacementNamed(context, "/");
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.message,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
          ));

          print(e);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
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
                        "Hey there!",
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
                        "Sign up to have access to app",
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
                                    validator: (input) {
                                      if (input.isEmpty) return 'Enter Name';
                                    },
                                    style: TextStyle(color: Colors.black54),
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    onSaved: (input) => _name = input),
                              ),
                              Container(
                                child: TextFormField(
                                    validator: validateEmail,
                                    style: TextStyle(color: Colors.black54),
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
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                            2,
                            InkWell(
                              onTap: () {
                                value ? signUp() : validatecheck();
                                // signUp();
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
                                              'Register',
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
                          Expanded(flex: 4, child: Divider()),
                          Expanded(
                              flex: 2,
                              child: Center(
                                  child: Text(
                                'or',
                                style: TextStyle(color: Colors.black54),
                              ))),
                          Expanded(flex: 4, child: Divider()),
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
                                value ? googleSignIn() : validategmail();
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
                                        "Sign up with Gmail",
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
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Checkbox(
                          //   activeColor: AppColors
                          //       .primary, //The color to use when this checkbox is checked.
                          //   checkColor: Colors.white,
                          //   value: this.value,
                          //   onChanged: (bool value) {
                          //     setState(() {
                          //       this.value = value;
                          //     });
                          //   },
                          // ),
                          Transform.scale(
                            //For Increasing or decreasing Sizes
                            scale: 1.3,
                            child: Theme(
                              // For Color Change,
                              data: ThemeData(
                                  unselectedWidgetColor: Constant.mainColor),
                              child: Checkbox(
                                activeColor: Constant
                                    .mainColor, //The color to use when this checkbox is checked.
                                checkColor: Colors.white,
                                value: this.value,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.value = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      "By checking this box, I accept Victory Chapel",
                                  style: TextStyle(
                                    color: Constant.mainColor,
                                    fontSize: ScreenUtil().setSp(45),
                                  ),
                                  children: <TextSpan>[]),
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Privacy()));
                              Navigator.of(context).pushNamed("/agreement");
                            },
                            child: Text(
                              "Terms of Service",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "and",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Privacy()));
                            },
                            child: Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: GestureDetector(
                        child: Text(
                          'Already have an Account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login())),
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

  void validatecheck() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        Fluttertoast.showToast(
            msg:
                "Please click on the checkbox to accept our terms and condition",
            backgroundColor: Colors.red.withOpacity(0.5));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void validategmail() async {
    Fluttertoast.showToast(
        msg: "Please click on the checkbox to accept our terms and condition",
        backgroundColor: Colors.red.withOpacity(0.5));
  }
}
