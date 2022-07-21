import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/Devotional/Devotional.dart';
import 'package:WeightApp/Hymns/Hymns.dart';
import 'package:WeightApp/Message/Mesage.dart';
import 'package:WeightApp/Notepad/Notepad.dart';
import 'package:WeightApp/Sundayschool/SundaySchool.dart';
import 'package:WeightApp/UPcoming/upcoming.dart';
import 'package:WeightApp/gallery/gallery.dart';
import 'package:WeightApp/homepage/others.dart';
import 'package:WeightApp/services/storage_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
// import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../Constants.dart';
import 'Donate.dart';
import 'Livestream.dart';

class All_weight extends StatefulWidget {
  @override
  _All_weightState createState() => _All_weightState();
}

class _All_weightState extends State<All_weight> {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool light = false;

  @override
  void initState() {
    // TODO: implement initState
    // firebaseCloudMessaging_Listeners();

    super.initState();
  }

  void showSuccessNotification(
      BuildContext context, String message, String title, String id) {
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveStreamPage()),
        );
      },
      child: Flushbar(
        backgroundColor: Constant.mainColor.withOpacity(0.5),
        title: title,
        message:
            message.length > 13 ? '${message.substring(0, 13)}...' : message,
        icon: Icon(
          Icons.live_tv,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.orange[300],
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }

  void showSuccessNotification2(
      BuildContext context, String message, String title, String id) {
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveStreamPage()),
        );
      },
      child: Flushbar(
        backgroundColor: Constant.mainColor.withOpacity(0.5),
        title: title,
        message:
            message.length > 40 ? '${message.substring(0, 40)}...' : message,
        icon: Icon(
          Icons.notifications,
          size: 25.0,
          color: Colors.orange[300],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.orange[300],
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        var view = message['data']['type'];
        Timer(
          Duration(milliseconds: 1),
          () => showSuccessNotification(
              context,
              message['notification']['body'],
              message['notification']['title'],
              message['data']['user_id']),
        );
        // if (view != null) {
        //   // Navigate to the create post view
        //   if (view == 'live_stream') {
        //     Timer(
        //       Duration(milliseconds: 1),
        //       () => showSuccessNotification(
        //           context,
        //           message['notification']['body'],
        //           message['notification']['title'],
        //           message['data']['user_id']),
        //     );
        //   } else if (view == 'article_detail_noti') {
        //     Timer(
        //       Duration(milliseconds: 1),
        //       () => showSuccessNotification2(
        //           context,
        //           message['notification']['body'],
        //           message['notification']['title'],
        //           message['data']['user_id']),
        //     );
        //   } else if (view == 'p-group') {
        //     Timer(
        //       Duration(milliseconds: 1),
        //       () => showSuccessNotification2(
        //           context,
        //           message['notification']['body'],
        //           message['notification']['title'],
        //           message['data']['user_id']),
        //     );
        //   }
        //   // If there's no view it'll just open the app on the first view
        // }
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        Timer(Duration(milliseconds: 1), () => _serialiseAndNavigate(message));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        Timer(Duration(milliseconds: 1), () => _serialiseAndNavigate(message));
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['type'];
    if (view != null) {
      // Navigate to the create post view
      if (view == 'live_stream') {
        print('private chat');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveStreamPage()),
        );
      } else if (view == 'radio') {}
      // If there's no view it'll just open the app on the first view
    }
  }

  void fcmSubscribe() {
    _firebaseMessaging.subscribeToTopic('notification');
  }

  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);
  String messagetitle;
  static const snackBarDuration = Duration(seconds: 3);
  _buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
    DecorationImage backgroundImage,
    double height = 152.0,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      child: WaveWidget(
        config: config,
        backgroundColor: backgroundColor,
        backgroundImage: backgroundImage,
        size: Size(double.infinity, double.infinity),
        waveAmplitude: 0,
      ),
    );
  }

  MaskFilter _blur;
  final List<MaskFilter> _blurs = [
    null,
    MaskFilter.blur(BlurStyle.normal, 10.0),
    MaskFilter.blur(BlurStyle.inner, 10.0),
    MaskFilter.blur(BlurStyle.outer, 10.0),
    MaskFilter.blur(BlurStyle.solid, 16.0),
  ];
  int _blurIndex = 0;
  MaskFilter _nextBlur() {
    if (_blurIndex == _blurs.length - 1) {
      _blurIndex = 0;
    } else {
      _blurIndex = _blurIndex + 1;
    }
    _blur = _blurs[_blurIndex];
    return _blurs[_blurIndex];
  }

  final snackBar = SnackBar(
    content: Text(
      'Press back again to exit',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Constant.mainColor,
    duration: snackBarDuration,
  );
  void updateuserprofile() async {
    var ref = FirebaseFirestore.instance
        .collection("users")
        .doc('${FirebaseAuth.instance.currentUser.uid},');
    ref.set({
      "user_id": FirebaseAuth.instance.currentUser.uid,
      "user_email": FirebaseAuth.instance.currentUser.email,
      'user_name': FirebaseAuth.instance.currentUser.displayName,
      'isAdmin': false,
    }).whenComplete(() => {
          _firebaseMessaging.getToken().then((token) {
            print(token);
            ref.update({'token': token.toString()});
          })
        });
    // await FirebaseFirestore.instance
    //     .collection("generalGroups")
    //     .doc("testimonies")
    //     .collection("members")
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .set({
    //   'name': FirebaseAuth.instance.currentUser.displayName,
    //   "photo": FirebaseAuth.instance.currentUser.photoURL,
    //   "profession": FirebaseAuth.instance.currentUser.uid,
    //   "isAdmin": false,
    // }).whenComplete(() => {
    //           _firebaseMessaging.getToken().then((token) async {
    //             print(token);
    //             await FirebaseFirestore.instance
    //                 .collection("generalGroups")
    //                 .doc("testimonies")
    //                 .collection("members")
    //                 .doc(FirebaseAuth.instance.currentUser.uid)
    //                 .update({'token': token.toString()});
    //           })
    //         });
    // await FirebaseFirestore.instance
    //     .collection("usersGeneralGroups")
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .collection("groups")
    //     .doc("testimonies")
    //     .set({
    //   "userId": FirebaseAuth.instance.currentUser.uid,
    //   "isAdmin": false,
    //   'pending': false,
    //   "name": 'testimonies',
    //   'type': 'public'
    // });
    await FirebaseFirestore.instance
        .collection("generalGroups")
        .doc("prayers")
        .collection("members")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      'name': FirebaseAuth.instance.currentUser.displayName,
      "photo": FirebaseAuth.instance.currentUser.photoURL,
      "profession": FirebaseAuth.instance.currentUser.uid,
      "pending": false,
      "isAdmin": false,
    }).whenComplete(() => {
              _firebaseMessaging.getToken().then((token) async {
                print(token);
                await FirebaseFirestore.instance
                    .collection("generalGroups")
                    .doc("prayers")
                    .collection("members")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .update({'token': token.toString()});
              })
            });
    await FirebaseFirestore.instance
        .collection("usersGeneralGroups")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("groups")
        .doc("prayers")
        .set({
      "userId": FirebaseAuth.instance.currentUser.uid,
      "isAdmin": false,
      'pending': false,
      "name": 'prayers',
      'type': 'public'
    });
  }

  Widget userup() {
    updateuserprofile();
    return Container();
  }

  DateTime backButtonPressTime;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        light = true;
      } else {
        print('setting dark theme');
        light = false;
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Constant.mainColor.withOpacity(0.05),
              Colors.white.withOpacity(0.02),
              Constant.mainColor.withOpacity(0.05),
              Colors.white.withOpacity(0.02),
              Constant.mainColor.withOpacity(0.01),
            ],
          )),
          child: Column(
            children: [
              Container(
                height: 0,
                width: 0,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("user_id",
                          isEqualTo: FirebaseAuth.instance.currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null)
                      return snapshot.data.docs.length > 0
                          ? Container()
                          : userup();
                    else
                      return Container();
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('livestream')
                      .doc('information')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Text("");
                    else
                      return snapshot.data["islife"] == true
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LiveStreamPage(
                                          url: snapshot.data["url"],
                                          des: snapshot.data["descriptive"])),
                                );
                              },
                              child: Container(
                                color: Colors.lightGreen,
                                height: 40,
                                child: Stack(
                                  children: [
                                    //
                                    _buildCard(
                                      backgroundColor: Colors.red,
                                      config: CustomConfig(
                                        gradients: [
                                          [
                                            Colors.red,
                                            Colors.red,
                                          ],
                                          [
                                            Colors.red,
                                            Colors.red,
                                          ],
                                          [
                                            Colors.red,
                                            Colors.white.withOpacity(0.5)
                                          ],
                                          [
                                            Colors.red,
                                            Colors.red,
                                          ]
                                        ],
                                        durations: [35000, 19440, 10800, 6000],
                                        heightPercentages: [
                                          0.20,
                                          0.23,
                                          0.25,
                                          0.30
                                        ],
                                        blur: _blur,
                                        gradientBegin: Alignment.bottomLeft,
                                        gradientEnd: Alignment.topRight,
                                      ),
                                    ),
                                    Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.live_tv,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Livestream',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 40,
                              // child: InkWell(
                              //   onTap: () {
                              //     Navigator.of(context)
                              //         .push(
                              //       MaterialPageRoute(
                              //         builder: (context) => JustAudio(),
                              //       ),
                              //     )
                              //         .then((value) {
                              //       setState(() {});
                              //     });
                              //   },
                              //   child: JustAudio(),
                              // ),
                            );
                  },
                ),
              ),
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('slider')
                        .doc("slider")
                        .collection('slider')
                        .orderBy("order", descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * .33,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Swiper(
                              autoplay: true,
                              itemCount: snapshot.data.docs.length,
                              viewportFraction: 0.95,
                              scale: 0.95,
                              itemWidth: MediaQuery.of(context).size.width,
                              itemHeight:
                                  MediaQuery.of(context).size.height / 3,
                              // layout: SwiperLayout.CUSTOM,
                              pagination: SwiperPagination(),
                              customLayoutOption: new CustomLayoutOption(
                                      startIndex: -1, stateCount: 3)
                                  .addRotate([
                                -45.0 / 180,
                                0.0,
                                45.0 / 180
                              ]).addTranslate([
                                new Offset(-340.0, -40.0),
                                new Offset(0.0, 0.0),
                                new Offset(340.0, -40.0)
                              ]),

                              // control: SwiperControl(color: Colors.black),
                              // itemWidth: 300.0,
                              // itemHeight: 400.0,
                              // viewportFraction: 0.9,
                              // scale: 0.9,
                              itemBuilder: (context, _currentIndex) {
                                Map data =
                                    snapshot.data.docs[_currentIndex].data();
                                // DateTime mydateTime =
                                //     data['created'].toDate();
                                // String formattedTime = DateFormat.yMMMd()
                                //     .add_jm()
                                //     .format(mydateTime);
                                // var currentindex = _currentIndex;
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/${data['sliderlocation']}");
                                  },
                                  child: Stack(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .33,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${data['sliderimage']}",
                                                    fit: BoxFit.cover,
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .33,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          // Colors.white.withOpacity(0.05),
                                                          //Colors.black.withOpacity(0.5),
                                                          Colors.white
                                                              .withOpacity(
                                                                  0.05),
                                                          Colors.black
                                                              .withOpacity(0.8),
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 30,
                                                  left: 1,
                                                  right: 0,
                                                  child: Center(
                                                    child: Text(
                                                      "${data['maintext']}",
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(60),
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        // backgroundColor: Colors.black45,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Positioned(
                                      //     bottom: 5,
                                      //     left: 0,
                                      //     right: 0,
                                      //     child: new DotsIndicator(
                                      //         dotsCount:
                                      //             snapshot.data.docs.length,
                                      //         position: currentindex
                                      //             .ceilToDouble())),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * .33,
                          width: MediaQuery.of(context).size.width * .95,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .33,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .33,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                // Colors.white.withOpacity(0.05),
                                                //Colors.black.withOpacity(0.5),
                                                Colors.white.withOpacity(0.05),
                                                Colors.black.withOpacity(0.8),
                                              ],
                                            )),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 30,
                                        left: 1,
                                        right: 0,
                                        child: Center(
                                          child: Text(
                                            "Loading...",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(60),
                                              fontWeight: FontWeight.w900,
                                              // backgroundColor: Colors.black45,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/sermon.png",
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Sermons',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MAinmesage()),
                              ),
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/devotional.png",
                                    height: 50.0,
                                    width: 50.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Devotionals',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => devotional()),
                              ),
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/church.png",
                                    height: 50.0,
                                    width: 50.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    ' Sunday School',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => sundayschool()),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/pencil.png",
                                    height: 45.0,
                                    width: 45.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Notepad',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notepad()),
                              ),
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/gospel.png",
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Hymns',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => hymns()),
                              ),
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/pulpit.png",
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Announcement',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Upcoming()),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/donate.png",
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Give',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Donate()),
                              ),
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image.asset(
                                    "assets/images/img_2.png",
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Gallery',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => gallery()),
                              ),
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: new Card(
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            child: new Container(
                              height: MediaQuery.of(context).size.height * .20,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.more_horiz,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Other features',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(40)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Others()),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }
}
