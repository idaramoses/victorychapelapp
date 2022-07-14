import 'dart:math';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/homepage/payments/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'SundaySchoolDetails.dart';

class sundayschoolpaid extends StatefulWidget {
  @override
  sundayschoolpaidState createState() => sundayschoolpaidState();
}

class sundayschoolpaidState extends State<sundayschoolpaid> {
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
          "Sunday School",
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
                    'FEBUARY',
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
  CollectionReference ref = FirebaseFirestore.instance
      .collection('sundayschoolpaid')
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
            .doc("January")
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("january")
                  .collection('january')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'January', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
  CollectionReference ref = FirebaseFirestore.instance
      .collection('sundayschoolpaid')
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("february")
                  .collection('february')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'FEBRUARY', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
  CollectionReference ref = FirebaseFirestore.instance
      .collection('sundayschoolpaid')
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("march")
                  .collection('march')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'MARCH', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
  CollectionReference ref = FirebaseFirestore.instance
      .collection('sundayschoolpaid')
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("april")
                  .collection('april')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'APRIL', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("april")
                  .collection('april')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'MAY', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("june")
                  .collection('june')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'JUNE', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("july")
                  .collection('july')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'JULY', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("august")
                  .collection('august')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'AUGUST', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
  CollectionReference ref = FirebaseFirestore.instance
      .collection('sundayschoolpaid')
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("september")
                  .collection('september')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'SEPTEMBER', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
  CollectionReference ref = FirebaseFirestore.instance
      .collection('sundayschoolpaid')
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("october")
                  .collection('october')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'OCTOBER', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
  CollectionReference ref = FirebaseFirestore.instance
      .collection('sundayschoolpaid')
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("november")
                  .collection('november')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'NOVEMBER', type: 'sundayschoolpaid'),
            );
          else
            return Container();
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
            .collection("sundayschoolpaid")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return snapshot.data.docs.length > 0
                ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sundayschoolpaid')
                  .doc("december")
                  .collection('december')
                  .orderBy("order", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text(
                        "No sundayschoolpaids",
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
                      String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        sundayschooldetails(
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
                              leading: CircleAvatar(
                                child: Text(
                                  "${data['order']}",
                                ),
                                backgroundColor: bg,
                              ),
                              title: Text(
                                "${data['sundayschoolpaidtitle']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Text("${data['sundayschoolpaiddate']}"),
                              trailing: Icon(Icons.navigate_next),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .push(
                          //       MaterialPageRoute(
                          //         builder: (context) => sundayschooldetails(
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
                          //                 "${data['sundayschoolpaidtitle']}",
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
                          //                   "${data['sundayschoolpaiddate']}",
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
                    child: Text("Loading..."),
                  );
                }
              },
            )
                : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .9,
              child: payment(month: 'DECEMBER', type: 'sundayschoolpaid'),
            );
          else
            return Container();
        },
      ),
    );
  }
}
