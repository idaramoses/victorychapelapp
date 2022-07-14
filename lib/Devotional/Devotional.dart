import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/devotional/devotionalDetails.dart';
import 'package:WeightApp/homepage/confession.dart';
import 'package:WeightApp/homepage/payments/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class devotional extends StatefulWidget {
  @override
  devotionalState createState() => devotionalState();
}

class devotionalState extends State<devotional> {
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
  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   appData.isPro = false;
  //
  //   await Purchases.setDebugLogsEnabled(true);
  //   await Purchases.setup("goog_ClHJnnQxqQlfiyZubpedDtGUgkC");
  //
  //   PurchaserInfo purchaserInfo;
  //   try {
  //     purchaserInfo = await Purchases.getPurchaserInfo();
  //     print(purchaserInfo.toString());
  //     if (purchaserInfo.entitlements.all['Devotional_jan'] != null) {
  //       appData.isPro =
  //           purchaserInfo.entitlements.all['Devotional_jan'].isActive;
  //     } else {
  //       appData.isPro = false;
  //     }
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   print('#### is user pro? ${appData.isPro}');
  // }

  @override
  Widget build(BuildContext context) {
    Random _random = new Random();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Devotional",
        ),
      ),
      body: ListView(
        children: <Widget>[
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "CON",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'CONFESSION',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Confession()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "JAN",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'JANUARY',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => one()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "FEB",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'FEBRUARY',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => two()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "MAR",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'MARCH',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => three()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "APR",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'APRIL',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => four()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "MAY",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'MAY',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => five()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "JUN",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'JUNE',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => six()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "JUL",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'JULY',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => seven()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "AUG",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'AUGUST',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => eight()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "SEP",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'SEPTEMBER',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => nine()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "OCT",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'OCTOBER',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ten()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "NOV",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'NOVEMBER',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => eleven()),
                        ),
                      }),
            ),
          ),
          new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "DEC",
                    ),
                    backgroundColor: myColors[_random.nextInt(4)],
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(
                    'DECEMBER',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => twelve()),
                        ),
                      }),
            ),
          ),
        ],
      ),
    );
  }
}

class one extends StatefulWidget {
  @override
  _oneState createState() => _oneState();
}

class _oneState extends State<one> {
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
      .collection('devotional')
      .doc("january")
      .collection('january');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "JANUARY",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Payments")
              .doc("JANUARY")
              .collection("devotional")
              .where("user_id",
                  isEqualTo: FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .25,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          direction: ShimmerDirection.ltr,
                          child: ListView.builder(
                            itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            itemCount: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                if (snapshot.hasError)
                  return Center(child: Text('Error in connections'));
                else if (snapshot.data != null)
                  return snapshot.data.docs.length > 0
                      ? StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('devotional')
                              .doc("january")
                              .collection('january')
                              .orderBy("order", descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.docs.length == 0) {
                                return Center(
                                  child: Text(
                                    "No devotionals",
                                    style: TextStyle(
                                        color: Constant.mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }

                              return ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  Random random = new Random();
                                  Color bg = myColors[random.nextInt(4)];
                                  Map data = snapshot.data.docs[index].data();
                                  DateTime mydateTime =
                                      data['created'].toDate();
                                  String formattedTime = DateFormat.yMMMd()
                                      .add_jm()
                                      .format(mydateTime);

                                  return Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    devotionaldetails(
                                                  data,
                                                  formattedTime,
                                                  snapshot.data.docs[index]
                                                      .reference,
                                                ),
                                              ),
                                            )
                                                .then((value) {
                                              setState(() {});
                                            });
                                          },
                                          leading: CircleAvatar(
                                            child: Text(
                                              "${data['order']}",
                                            ),
                                            backgroundColor: bg,
                                          ),
                                          title: Text(
                                            "${data['devotionaltitle']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                              "${data['devotionaldate']}"
                                                  .replaceAll(
                                                      '00:00:00.000', '')),
                                          trailing: Icon(Icons.navigate_next),
                                        ),
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     Navigator.of(context)
                                      //         .push(
                                      //       MaterialPageRoute(
                                      //         builder: (context) => devotionaldetails(
                                      //           data,
                                      //           formattedTime,
                                      //           snapshot.data.docs[index].reference,
                                      //         ),
                                      //       ),
                                      //     )
                                      //         .then((value) {
                                      //       setState(() {});
                                      //     });
                                      //   },
                                      //   child: SizedBox(
                                      //     height: 140,
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.only(top: 20),
                                      //       child: Card(
                                      //         child: Padding(
                                      //           padding: const EdgeInsets.all(8.0),
                                      //           child: Column(
                                      //             crossAxisAlignment: CrossAxisAlignment.start,
                                      //             children: [
                                      //               Text(
                                      //                 "${data['devotionaltitle']}",
                                      //                 style: TextStyle(
                                      //                   fontSize: 17.0,
                                      //                   fontFamily: "lato",
                                      //                   fontWeight: FontWeight.bold,
                                      //                   color: Colors.black87,
                                      //                 ),
                                      //                 maxLines: 3,
                                      //               ),
                                      //               SizedBox(
                                      //                 height: 10,
                                      //               ),
                                      //               Container(
                                      //                 child: Text(
                                      //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                      //                   style: TextStyle(
                                      //                     fontSize: 17.0,
                                      //                     fontFamily: "lato",
                                      //                     color: Colors.black87,
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Center(child: Text("Loading...")),
                              );
                            }
                          },
                        )
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('devotional')
                              .doc("january")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return Center(
                                  child: Center(child: Text("Loading...")));
                            else
                              return snapshot.data["lock"] == true
                                  ? InkWell(
                                      onTap: () {},
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('devotional')
                                            .doc("january")
                                            .collection('january')
                                            .orderBy("order", descending: false)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data.docs.length ==
                                                0) {
                                              return Center(
                                                child: Text(
                                                  "No devotionals",
                                                  style: TextStyle(
                                                      color: Constant.mainColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              );
                                            }

                                            return ListView.builder(
                                              itemCount:
                                                  snapshot.data.docs.length,
                                              itemBuilder: (context, index) {
                                                Random random = new Random();
                                                Color bg =
                                                    myColors[random.nextInt(4)];
                                                Map data = snapshot
                                                    .data.docs[index]
                                                    .data();
                                                String mydateTime =
                                                    "${data['devotionaldate']}"
                                                        .replaceAll(
                                                            '00:00:00.000', '')
                                                        .replaceAll(
                                                            '00:00:00.000',
                                                            ' ');
                                                String formattedTime = '';

                                                return Column(
                                                  children: [
                                                    Card(
                                                      child: ListTile(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  devotionaldetails(
                                                                data,
                                                                formattedTime,
                                                                snapshot
                                                                    .data
                                                                    .docs[index]
                                                                    .reference,
                                                              ),
                                                            ),
                                                          )
                                                              .then((value) {
                                                            setState(() {});
                                                          });
                                                        },
                                                        leading: CircleAvatar(
                                                          child: Text(
                                                            "${data['order']}",
                                                          ),
                                                          backgroundColor: bg,
                                                        ),
                                                        title: Text(
                                                          "${data['devotionaltitle']}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle: Text(
                                                            "${data['devotionaldate']}"
                                                                .replaceAll(
                                                                    '00:00:00.000',
                                                                    '')
                                                                .replaceAll(
                                                                    '00:00:00.000',
                                                                    ' ')),
                                                        trailing: Icon(Icons
                                                            .navigate_next),
                                                      ),
                                                    ),
                                                    // InkWell(
                                                    //   onTap: () {
                                                    //     Navigator.of(context)
                                                    //         .push(
                                                    //       MaterialPageRoute(
                                                    //         builder: (context) => devotionaldetails(
                                                    //           data,
                                                    //           formattedTime,
                                                    //           snapshot.data.docs[index].reference,
                                                    //         ),
                                                    //       ),
                                                    //     )
                                                    //         .then((value) {
                                                    //       setState(() {});
                                                    //     });
                                                    //   },
                                                    //   child: SizedBox(
                                                    //     height: 140,
                                                    //     child: Padding(
                                                    //       padding: const EdgeInsets.only(top: 20),
                                                    //       child: Card(
                                                    //         child: Padding(
                                                    //           padding: const EdgeInsets.all(8.0),
                                                    //           child: Column(
                                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                                    //             children: [
                                                    //               Text(
                                                    //                 "${data['devotionaltitle']}",
                                                    //                 style: TextStyle(
                                                    //                   fontSize: 17.0,
                                                    //                   fontFamily: "lato",
                                                    //                   fontWeight: FontWeight.bold,
                                                    //                   color: Colors.black87,
                                                    //                 ),
                                                    //                 maxLines: 3,
                                                    //               ),
                                                    //               SizedBox(
                                                    //                 height: 10,
                                                    //               ),
                                                    //               Container(
                                                    //                 child: Text(
                                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                    //                   style: TextStyle(
                                                    //                     fontSize: 17.0,
                                                    //                     fontFamily: "lato",
                                                    //                     color: Colors.black87,
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            return Center(
                                              child: Center(
                                                  child: Text("Loading...")),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .9,
                                      child: payment(
                                          month: 'JANUARY', type: 'devotional'),
                                    );
                          },
                        );
                else
                  return Container();
            }
          }),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class two extends StatefulWidget {
  @override
  _twoState createState() => _twoState();
}

class _twoState extends State<two> {
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
      .collection('devotional')
      .doc("february")
      .collection('february');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FEBRUARY",
          // style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Constant.mainColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("FEBRUARY")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("february")
                            .collection('february')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("february")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("february")
                                          .collection('february')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'FEBRUARY', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class three extends StatefulWidget {
  @override
  _threeState createState() => _threeState();
}

class _threeState extends State<three> {
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
      .collection('devotional')
      .doc("march")
      .collection('march');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "MARCH",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("MARCH")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("march")
                            .collection('march')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("march")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("march")
                                          .collection('march')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'MARCH', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class four extends StatefulWidget {
  @override
  _fourState createState() => _fourState();
}

class _fourState extends State<four> {
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
      .collection('devotional')
      .doc("april")
      .collection('april');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "APRIL",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("APRIL")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("april")
                            .collection('april')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("april")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("april")
                                          .collection('april')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'APRIL', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class five extends StatefulWidget {
  @override
  _fiveState createState() => _fiveState();
}

class _fiveState extends State<five> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MAY",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("MAY")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("may")
                            .collection('may')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("may")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("may")
                                          .collection('may')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'MAY', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class six extends StatefulWidget {
  @override
  _sixState createState() => _sixState();
}

class _sixState extends State<six> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "JUNE",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("JUNE")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("june")
                            .collection('june')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("june")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("june")
                                          .collection('june')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'JUNE', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class seven extends StatefulWidget {
  @override
  _sevenState createState() => _sevenState();
}

class _sevenState extends State<seven> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "JULY",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("JULY")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("july")
                            .collection('july')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("july")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("july")
                                          .collection('july')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'JULY', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class eight extends StatefulWidget {
  @override
  _eightState createState() => _eightState();
}

class _eightState extends State<eight> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AUGUST",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("AUGUST")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("august")
                            .collection('august')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("august")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("august")
                                          .collection('august')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'AUGUST', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class nine extends StatefulWidget {
  @override
  _nineState createState() => _nineState();
}

class _nineState extends State<nine> {
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
      .collection('devotional')
      .doc("september")
      .collection('september');
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SEPTEMBER",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("SEPTEMBER")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("september")
                            .collection('september')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("september")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("september")
                                          .collection('september')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'SEPTEMBER', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class ten extends StatefulWidget {
  @override
  _tenState createState() => _tenState();
}

class _tenState extends State<ten> {
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
      .collection('devotional')
      .doc("october")
      .collection('october');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OCTOBER",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("OCTOBER")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("october")
                            .collection('october')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("october")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("october")
                                          .collection('october')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'OCTOBER', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class eleven extends StatefulWidget {
  @override
  _elevenState createState() => _elevenState();
}

class _elevenState extends State<eleven> {
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
      .collection('devotional')
      .doc("november")
      .collection('november');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NOVEMBER",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("NOVEMBER")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("november")
                            .collection('november')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("november")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("november")
                                          .collection('november')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'NOVEMBER', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}

class twelve extends StatefulWidget {
  @override
  _twelveState createState() => _twelveState();
}

class _twelveState extends State<twelve> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DECEMBER",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Payments")
            .doc("DECEMBER")
            .collection("devotional")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error in connections'));
              else if (snapshot.data != null)
                return snapshot.data.docs.length > 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("december")
                            .collection('december')
                            .orderBy("order", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "No devotionals",
                                  style: TextStyle(
                                      color: Constant.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Random random = new Random();
                                Color bg = myColors[random.nextInt(4)];
                                Map data = snapshot.data.docs[index].data();
                                DateTime mydateTime = data['created'].toDate();
                                String formattedTime = DateFormat.yMMMd()
                                    .add_jm()
                                    .format(mydateTime);

                                return Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  devotionaldetails(
                                                data,
                                                formattedTime,
                                                snapshot
                                                    .data.docs[index].reference,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        leading: CircleAvatar(
                                          child: Text(
                                            "${data['order']}",
                                          ),
                                          backgroundColor: bg,
                                        ),
                                        title: Text(
                                          "${data['devotionaltitle']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "${data['devotionaldate']}"
                                                .replaceAll(
                                                    '00:00:00.000', '')),
                                        trailing: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) => devotionaldetails(
                                    //           data,
                                    //           formattedTime,
                                    //           snapshot.data.docs[index].reference,
                                    //         ),
                                    //       ),
                                    //     )
                                    //         .then((value) {
                                    //       setState(() {});
                                    //     });
                                    //   },
                                    //   child: SizedBox(
                                    //     height: 140,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(top: 20),
                                    //       child: Card(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 "${data['devotionaltitle']}",
                                    //                 style: TextStyle(
                                    //                   fontSize: 17.0,
                                    //                   fontFamily: "lato",
                                    //                   fontWeight: FontWeight.bold,
                                    //                   color: Colors.black87,
                                    //                 ),
                                    //                 maxLines: 3,
                                    //               ),
                                    //               SizedBox(
                                    //                 height: 10,
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                    //                   style: TextStyle(
                                    //                     fontSize: 17.0,
                                    //                     fontFamily: "lato",
                                    //                     color: Colors.black87,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Center(child: Text("Loading...")),
                            );
                          }
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('devotional')
                            .doc("december")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Loading..."));
                          else
                            return snapshot.data["lock"] == true
                                ? InkWell(
                                    onTap: () {},
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('devotional')
                                          .doc("december")
                                          .collection('december')
                                          .orderBy("order", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "No devotionals",
                                                style: TextStyle(
                                                    color: Constant.mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              Random random = new Random();
                                              Color bg =
                                                  myColors[random.nextInt(4)];
                                              Map data = snapshot
                                                  .data.docs[index]
                                                  .data();
                                              DateTime mydateTime =
                                                  data['created'].toDate();
                                              String formattedTime =
                                                  DateFormat.yMMMd()
                                                      .add_jm()
                                                      .format(mydateTime);

                                              return Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                devotionaldetails(
                                                              data,
                                                              formattedTime,
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference,
                                                            ),
                                                          ),
                                                        )
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      leading: CircleAvatar(
                                                        child: Text(
                                                          "${data['order']}",
                                                        ),
                                                        backgroundColor: bg,
                                                      ),
                                                      title: Text(
                                                        "${data['devotionaltitle']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "${data['devotionaldate']}"
                                                              .replaceAll(
                                                                  '00:00:00.000',
                                                                  '')),
                                                      trailing: Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     Navigator.of(context)
                                                  //         .push(
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => devotionaldetails(
                                                  //           data,
                                                  //           formattedTime,
                                                  //           snapshot.data.docs[index].reference,
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //         .then((value) {
                                                  //       setState(() {});
                                                  //     });
                                                  //   },
                                                  //   child: SizedBox(
                                                  //     height: 140,
                                                  //     child: Padding(
                                                  //       padding: const EdgeInsets.only(top: 20),
                                                  //       child: Card(
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Column(
                                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "${data['devotionaltitle']}",
                                                  //                 style: TextStyle(
                                                  //                   fontSize: 17.0,
                                                  //                   fontFamily: "lato",
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   color: Colors.black87,
                                                  //                 ),
                                                  //                 maxLines: 3,
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 10,
                                                  //               ),
                                                  //               Container(
                                                  //                 child: Text(
                                                  //                   "${data['devotionaldate']}".replaceAll('00:00:00.000', ''),
                                                  //                   style: TextStyle(
                                                  //                     fontSize: 17.0,
                                                  //                     fontFamily: "lato",
                                                  //                     color: Colors.black87,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Center(
                                                child: Text("Loading...")),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: payment(
                                        month: 'DECEMBER', type: 'devotional'),
                                  );
                        },
                      );
              else
                return Container();
          }
        },
      ),
      bottomSheet: _isConnectionSuccessful
          ? Container(
              height: 0,
              width: 0,
            )
          : ListTile(
              tileColor: Constant.mainColor.withOpacity(0.1),
              leading: new Icon(Icons.wifi_off_outlined),
              title: new Text('Not connected to the internet'),
              subtitle: new Text('Please connect to the internet'),
              trailing: new Icon(Icons.close),
              onTap: () {
                // Navigator.pop(context);
                setState(() {
                  _isConnectionSuccessful = true;
                });
              },
            ),
    );
  }
}
