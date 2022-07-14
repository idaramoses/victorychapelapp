import 'package:WeightApp/Devotional/Devotional.dart';
import 'package:WeightApp/Sundayschool/SundaySchool.dart';
import 'package:WeightApp/Testimonies/Testimonies.dart';
import 'package:WeightApp/UPcoming/upcoming.dart';
import 'package:WeightApp/auth/Login.dart';
import 'package:WeightApp/auth/SignUp.dart';
import 'package:WeightApp/group/new_group.dart';
import 'package:WeightApp/homepage/HomePage.dart';
import 'package:WeightApp/homepage/confession.dart';
import 'package:WeightApp/welcome/Splash.dart';
import 'package:WeightApp/welcome/Start.dart';
import 'package:WeightApp/welcome/onboarding_screen.dart';
import 'package:flutter/material.dart';

import 'Notepad/Notepad.dart';
import 'homepage/about.dart';

routes(BuildContext context) => {
      "/login": (BuildContext context) => Login(),
      "/splash": (BuildContext context) => Splash(),
      "/signUp": (BuildContext context) => SignUp(),
      "/start": (BuildContext context) => Start(),
      "/home": (BuildContext context) => HomePage(),
      "/notepad": (BuildContext context) => Notepad(),
      "/create": (BuildContext context) => NewGroup(),
      "/sundayschool": (BuildContext context) => sundayschool(),
      "/devotional": (BuildContext context) => devotional(),
      "/events": (BuildContext context) => Upcoming(),
      "/testimony": (BuildContext context) => Testimonies(),
      "/welcome": (BuildContext context) => About(),
      "/confession": (BuildContext context) => Confession(),
      '/splash': (BuildContext context) => OnboardingScreen(),
    };
