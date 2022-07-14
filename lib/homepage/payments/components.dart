import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppData {
  static final AppData _appData = new AppData._internal();

  bool isPro;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
const kColorPrimary = Color(0xff283149);
const kColorPrimaryLight = Color(0xff424B67);
const kColorPrimaryDark = Color(0xff21293E);
const kColorAccent = Colors.blue;
const kColorText = Color(0xffDBEDF3);

TextStyle kSendButtonTextStyle = TextStyle(
  color: kColorText,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

class TopBarAgnosticNoIcon extends StatelessWidget {
  final String text;

  final TextStyle style;
  final String uniqueHeroTag;
  final Widget child;

  TopBarAgnosticNoIcon({
    this.text,
    this.style,
    this.uniqueHeroTag,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return Scaffold(
        backgroundColor: kColorPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kColorText, //change your color here
          ),
          backgroundColor: kColorPrimaryLight,
          title: Text(
            text,
            style: style,
          ),
        ),
        body: child,
      );
    } else {
      return CupertinoPageScaffold(
        backgroundColor: kColorPrimary,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: kColorPrimaryLight,
          heroTag: uniqueHeroTag,
          transitionBetweenRoutes: false,
          middle: Text(
            text,
            style: style,
          ),
        ),
        child: child,
      );
    }
  }
}
