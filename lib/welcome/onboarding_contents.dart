import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {@required this.title, @required this.image, @required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to Victory Chapel",
    image: "assets/images/4.png",
    desc: "The Church on Campus.\nUniversity of Uyo,Uyo",
  ),
  OnboardingContents(
    title: "Media",
    image: "assets/images/8.png",
    desc: "Listen to audio messages,hymns from your mobile phone.",
  ),
  OnboardingContents(
    title: "Large community of christian",
    image: "assets/images/6.png",
    desc: "Connect with your church members outside the church premises.",
  ),
];
