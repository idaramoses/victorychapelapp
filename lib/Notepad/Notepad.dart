import 'dart:async';
import 'dart:io';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/Notepad/NotepadAdd.dart';
import 'package:WeightApp/Notepad/Notepaddetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Notepad extends StatefulWidget {
  @override
  _NotepadState createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
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

  CollectionReference ref = FirebaseFirestore.instance
      .collection('notepad')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection(FirebaseAuth.instance.currentUser.uid);

  List<Color> myColors = [
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Notepad",
          // style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Constant.mainColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NotepadAdd()));
        },
        backgroundColor: Constant.mainColor,
        child: Icon(
          Icons.add,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text(
                  "No Notepads",
                  style: TextStyle(
                    color: Constant.mainColor,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Map data = snapshot.data.docs[index].data();
                DateTime mydateTime = data['created'].toDate();
                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);

                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => Notepaddetails(
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
                    title: Text(
                      "${data['notetitle']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("$formattedTime"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                );
              },
            );
          } else {
            return Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 10.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: ListTile(
                                  title: Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    color: Colors.white,
                                  ),
                                  trailing: Icon(
                                    Icons.navigate_next,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
