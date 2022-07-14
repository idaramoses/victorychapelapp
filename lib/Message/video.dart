import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Constants.dart';

class Messge_video extends StatefulWidget {
  final String categori;
  final String type;

  Messge_video({
    Key key,
    @required this.categori,
    @required this.type,
  }) : super(key: key);
  @override
  _Messge_videoState createState() => _Messge_videoState();
}

class _Messge_videoState extends State<Messge_video> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('message')
      .doc("message")
      .collection('video');
  int galleryCount = 10;
  bool loadingMore = false;
  final scrollController = ScrollController();
  List<Color> myColors = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.green[200],
    Colors.deepPurple[200],
    Colors.purple[200],
    Colors.cyan[200],
    Colors.teal[200],
    Colors.tealAccent[200],
    Colors.pink[200],
  ];
  static const TextStyle textStyle = const TextStyle(
    fontSize: 16,
  );

  ConnectivityResult _connectivityResult;
  StreamSubscription _connectivitySubscription;
  bool _isConnectionSuccessful = false;

  @override
  initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('Current connectivity status: $result');
      setState(() {
        _connectivityResult = result;
      });
    });
    _checkConnectivityState();
  }

  @override
  dispose() {
    super.dispose();

    _connectivitySubscription.cancel();
  }

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      setState(() {
        _isConnectionSuccessful = true;
      });
    } else if (result == ConnectivityResult.mobile) {
      setState(() {
        _isConnectionSuccessful = true;
      });
    } else {
      setState(() {
        _isConnectionSuccessful = false;
      });
      print('Not connected to any network');
    }

    setState(() {
      _connectivityResult = result;
    });
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.woolha.com');

      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      print(e);
      setState(() {
        _isConnectionSuccessful = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white.withOpacity(0.02),
            Constant.mainColor.withOpacity(0.05),
          ],
        )),
        child: StreamBuilder<QuerySnapshot>(
          stream: widget.categori != null
              ? FirebaseFirestore.instance
                  .collection('message')
                  .doc("message")
                  .collection('video')
                  .where('${widget.type}', isEqualTo: widget.categori)
                  .orderBy("messagedate", descending: true)
                  .limit(galleryCount)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('message')
                  .doc("message")
                  .collection('video')
                  .orderBy("messagedate", descending: true)
                  .limit(galleryCount)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No Messages",
                    style: TextStyle(),
                  ),
                );
              }
              return Column(
                children: [
                  NotificationListener(
                    onNotification: (ScrollEndNotification notification) {
                      if (notification is ScrollEndNotification &&
                          scrollController.position.extentAfter == 0) {
                        print("end");

                        setState(() {
                          loadingMore = true;
                        });
                        loadMore();
                      }
                      return false;
                    },
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          Random random = new Random();
                          Color bg = myColors[random.nextInt(4)];
                          Map data = snapshot.data.docs[index].data();
                          DateTime mydateTime = data['created'].toDate();
                          String formattedTime =
                              DateFormat.yMMMd().add_jm().format(mydateTime);
                          String messagetitle = "${data['messagetitle']}";
                          String url = "${data['messageurl']}";
                          String preacher = "${data['messagepreacher']}";
                          String date = "${data['messagedate']}";
                          String campus = "${data['messagelocation']}";
                          String _name = '${data['messagetitle']}';
                          _name.length > 2 ? _name.substring(0, 2) : _name;

                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => Videodetails(
                                    data,
                                    formattedTime,
                                    snapshot.data.docs[index].reference,
                                  ),
                                ),
                              )
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: SizedBox(
                                    height: 120,
                                    child: Card(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: CircleAvatar(
                                                child: Text(
                                                  _name.length > 2
                                                      ? _name.substring(0, 2)
                                                      : _name,
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                backgroundColor: bg,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  messagetitle,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  preacher,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      date.replaceAll(
                                                          '00:00:00.000', ''),
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                    Text(
                                                      ' | ',
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                    Text(
                                                      campus,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(vertical: 5.0),
                                //   child: SizedBox(
                                //     height: 310,
                                //     child: Card(
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: <Widget>[
                                //           Container(
                                //               height: 200,
                                //               child: FlickPlayer(url: '$url')),
                                //           Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.center,
                                //               children: [
                                //                 Text(
                                //                   messagetitle,
                                //                   maxLines: 1,
                                //                   style: TextStyle(
                                //                       fontSize: 17,
                                //                       fontWeight: FontWeight.bold),
                                //                   softWrap: true,
                                //                   overflow: TextOverflow.ellipsis,
                                //                 ),
                                //                 SizedBox(
                                //                   height: 3,
                                //                 ),
                                //                 Text(
                                //                   preacher,
                                //                   style: TextStyle(
                                //                       fontSize: 14,
                                //                       color: Colors.black54),
                                //                 ),
                                //                 SizedBox(
                                //                   height: 3,
                                //                 ),
                                //                 Row(
                                //                   children: [
                                //                     Text(
                                //                       date,
                                //                       style: TextStyle(
                                //                           fontSize: 11,
                                //                           color: Colors.black54),
                                //                     ),
                                //                     Text(
                                //                       ' | ',
                                //                       style: TextStyle(fontSize: 11),
                                //                     ),
                                //                     Text(
                                //                       campus,
                                //                       style: TextStyle(
                                //                           fontSize: 12,
                                //                           color: Colors.black54),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  loadingMore
                      ? Center(
                          child: SpinKitThreeBounce(
                            color: Colors.black,
                            size: 30,
                          ),
                        )
                      : SizedBox.shrink()
                ],
              );
            } else {
              return Center(
                child: Text("Loading..."),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      galleryCount += 5;
      loadingMore = false;
    });
  }
}

class Videodetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Videodetails(this.data, this.time, this.ref);

  @override
  _VideodetailsState createState() => _VideodetailsState();
}

class _VideodetailsState extends State<Videodetails> {
  String title;
  String content;
  String location;
  String image;
  String date;
  String preacher;
  String readingpassage;
  String audio;
  String prayer;
  String p_code;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  var _idController = TextEditingController();
  var _seekToController = TextEditingController();
  double _volume = 100;
  bool _muted = false;
  String _playerStatus = "";
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.data['messageurl'],
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: true,
        // isLive: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady) {
      if (_controller.value.playerState == PlayerState.ended) {
        _showSnackBar('Video Ended!');
      }
      if (mounted && !_controller.value.isFullScreen) {
        setState(() {
          _playerStatus = _controller.value.playerState.toString();
        });
      }
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
                topActions: <Widget>[
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.arrow_back_ios,
                  //     color: Colors.white,
                  //     size: 20.0,
                  //   ),
                  //   onPressed: () {
                  //     _controller.toggleFullScreenMode();
                  //   },
                  // ),
                  // Expanded(
                  //   child: Text(
                  //     'Victory Chapel Uniuyo',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 18.0,
                  //     ),
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 1,
                  //   ),
                  // ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.settings,
                  //     color: Colors.white,
                  //     size: 25.0,
                  //   ),
                  //   onPressed: () {
                  //     _showSnackBar('Settings Tapped!');
                  //   },
                  // ),
                ],
                onReady: () {
                  _isPlayerReady = true;
                },
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                widget.data['messagetitle'],
                style: TextStyle(
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _space => SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  String id = YoutubePlayer.convertUrlToId(
                    _idController.text,
                  );
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
