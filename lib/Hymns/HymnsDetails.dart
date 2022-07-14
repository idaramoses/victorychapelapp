import 'dart:async';
import 'dart:io';

import 'package:WeightApp/Constants.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Hymnsdetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Hymnsdetails(this.data, this.time, this.ref);

  @override
  _HymnsdetailsState createState() => _HymnsdetailsState();
}

AnimationController _animationIconController1;

AudioCache audioCache;

AudioPlayer audioPlayer;

Duration _duration = new Duration();
Duration _position = new Duration();

bool issongplaying = false;

bool isplaying = false;

void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  audioPlayer.seek(newDuration);
}

class _HymnsdetailsState extends State<Hymnsdetails>
    with TickerProviderStateMixin {
  String title;
  String content;
  String audio;

  bool edit = false;
  bool isplaying = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  void playRemoteFile() {
    AudioPlayer player = new AudioPlayer();
    player.play(widget.data['hymnsaudio']);
    player.getCurrentPosition();
    setState(() {
      isplaying = true;
    });
  }

  ConnectivityResult _connectivityResult;
  StreamSubscription _connectivitySubscription;
  bool _isConnectionSuccessful = false;
  @override
  void initState() {
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
    initPlayer();
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

  void initPlayer() {
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });
    audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  Future<bool> _BackPressed() {
    setState(() {
      isplaying
          ? _animationIconController1.reverse()
          : _animationIconController1.forward();
      isplaying = !isplaying;
    });

    audioPlayer.pause();
    setState(() {
      issongplaying = false;
    });
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    title = widget.data['hymnstitle'];
    content = widget.data['hymnscontent'];
    audio = widget.data['hymnsaudio'];
    return WillPopScope(
      onWillPop: _BackPressed,
      child: SafeArea(
        child: Scaffold(
          //
          appBar: AppBar(
            // iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              title,
              // style: TextStyle(color: Colors.white),
            ),
            // backgroundColor: Constant.mainColor,
          ),
          floatingActionButton: _isConnectionSuccessful
              ? FloatingActionButton(
                  child: Icon(isplaying ? Icons.pause : Icons.play_arrow),
                  backgroundColor: Constant.mainColor,
                  foregroundColor: Colors.white,
                  tooltip: 'Speaker',
                  onPressed: () {
                    !isplaying
                        ? Fluttertoast.showToast(
                            msg: "Loading...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 15.0)
                        : Fluttertoast.showToast(
                            msg: "Pause",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                            fontSize: 15.0);
                    setState(() {
                      isplaying
                          ? _animationIconController1.reverse()
                          : _animationIconController1.forward();
                      isplaying = !isplaying;
                    });
                    if (issongplaying == false) {
                      audioPlayer.play(widget.data['hymnsaudio']);
                      setState(() {
                        issongplaying = true;
                      });
                    } else {
                      audioPlayer.pause();
                      setState(() {
                        issongplaying = false;
                      });
                    }
                  },
                )
              : FloatingActionButton(
                  child: Icon(isplaying ? Icons.pause : Icons.play_arrow),
                  backgroundColor: Constant.mainColor,
                  foregroundColor: Colors.white,
                  tooltip: 'Speaker',
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "No internet connection",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                ),
          resizeToAvoidBottomInset: false,
          //
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Column(
                children: [
                  //
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
