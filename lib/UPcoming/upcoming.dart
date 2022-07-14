import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({Key key}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String filter;

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.mainColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Upcoming Event',
            style: TextStyle(
              color: Constant.appiconColor,
            ),
          ),
          elevation: 0,
          actions: [
            // IconButton(
            //   tooltip: 'sort',
            //   icon: const Icon(
            //     Icons.filter_list_outlined,
            //     color: Colors.white,
            //   ),
            // ),
            // IconButton(
            //   tooltip: 'Search',
            //   icon: const Icon(
            //     Icons.search,
            //     color: Colors.white,
            //   ),
            //   // onPressed: () async {
            //   //   // await showSearch<dynamic>(
            //   //   //   context: context,
            //   //   //   delegate: _searchDelegate,
            //   //   // );
            //   // },
            // )
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Constant.mainColor,
              height: 40,
              child: TabBar(
                  indicatorWeight: 0.5,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: Colors.black54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Constant.appiconColor,
                  unselectedLabelColor: Colors.white,
                  controller: _tabController,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Tab(
                        text: "Town Camp",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Tab(
                        text: "Perm Site",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Tab(
                        text: "Abak",
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Town(),
                  Perm(),
                  Abak()
                  // AudioServiceWidget(child: JustAudio()),
                  // generalGroupList(),
                  // // (iswhite) ? groupsList(value) : groupsListblack(value),
                  // chatRequestList()
                ],
              ),
            )
          ],
        ));
  }
}

class Town extends StatefulWidget {
  @override
  _TownState createState() => _TownState();
}

class _TownState extends State<Town> {
  CollectionReference ref = FirebaseFirestore.instance.collection('upcoming');

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
          stream: FirebaseFirestore.instance
              .collection('upcoming')
              .where('campus', isEqualTo: 'town')
              .orderBy("order", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No Upcomings events",
                    style: TextStyle(
                        // color: Colors.white70,
                        ),
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

                  return InkWell(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(
                      //   MaterialPageRoute(
                      //     builder: (context) => Upcomingdetails(
                      //       data,
                      //       formattedTime,
                      //       snapshot.data.docs[index].reference,
                      //     ),
                      //   ),
                      // )
                      //     .then((value) {
                      //   setState(() {});
                      // });
                    },
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .92,
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              children: [
                                Container(
                                  child: Material(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        child: SpinKitThreeBounce(
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        // width: 100.0,
                                        // height: 100.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Material(
                                        child: Image.asset(
                                          'assets/images/img_not_available.jpeg',
                                          width: double.infinity,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                      imageUrl: "${data['upcomingimage']}",
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${data['upcomingtitle']}',
                                            style: TextStyle(
                                              // color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Theme.of(context).accentColor,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: ReadMoreText(
                                            "${data['upcomingcontent']}" ?? '',
                                            trimLines: 10,
                                            colorClickableText: Colors.blue,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: '... Read more',
                                            trimExpandedText: '... Show less',
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            '${data['upcomingtype']}',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 13.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
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
                                Card(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .90,
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 200.0,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              Divider(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  height: 8.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Perm extends StatefulWidget {
  @override
  _PermState createState() => _PermState();
}

class _PermState extends State<Perm> {
  CollectionReference ref = FirebaseFirestore.instance.collection('upcoming');

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
          stream: FirebaseFirestore.instance
              .collection('upcoming')
              .orderBy("order", descending: false)
              .where('campus', isEqualTo: 'perm')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No Upcomings events",
                    style: TextStyle(
                        // color: Colors.white70,
                        ),
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

                  return InkWell(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(
                      //   MaterialPageRoute(
                      //     builder: (context) => Upcomingdetails(
                      //       data,
                      //       formattedTime,
                      //       snapshot.data.docs[index].reference,
                      //     ),
                      //   ),
                      // )
                      //     .then((value) {
                      //   setState(() {});
                      // });
                    },
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .92,
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              children: [
                                Container(
                                  child: Material(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        child: SpinKitThreeBounce(
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        // width: 100.0,
                                        // height: 100.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Material(
                                        child: Image.asset(
                                          'assets/images/img_not_available.jpeg',
                                          width: double.infinity,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                      imageUrl: "${data['upcomingimage']}",
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${data['upcomingtitle']}',
                                            style: TextStyle(
                                              // color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Theme.of(context).accentColor,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: ReadMoreText(
                                            "${data['upcomingcontent']}" ?? '',
                                            trimLines: 10,
                                            colorClickableText: Colors.blue,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: '... Read more',
                                            trimExpandedText: '... Show less',
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            '${data['upcomingtype']}',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 13.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
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
                                Card(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .90,
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 200.0,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              Divider(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  height: 8.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Abak extends StatefulWidget {
  @override
  _AbakState createState() => _AbakState();
}

class _AbakState extends State<Abak> {
  CollectionReference ref = FirebaseFirestore.instance.collection('upcoming');

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
          stream: FirebaseFirestore.instance
              .collection('upcoming')
              .orderBy("order", descending: false)
              .where('campus', isEqualTo: 'abak')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No Upcoming events",
                    style: TextStyle(
                        // color: Colors.white70,
                        ),
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

                  return InkWell(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(
                      //   MaterialPageRoute(
                      //     builder: (context) => Upcomingdetails(
                      //       data,
                      //       formattedTime,
                      //       snapshot.data.docs[index].reference,
                      //     ),
                      //   ),
                      // )
                      //     .then((value) {
                      //   setState(() {});
                      // });
                    },
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .92,
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              children: [
                                Container(
                                  child: Material(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        child: SpinKitThreeBounce(
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        // width: 100.0,
                                        // height: 100.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Material(
                                        child: Image.asset(
                                          'assets/images/img_not_available.jpeg',
                                          width: double.infinity,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                      imageUrl: "${data['upcomingimage']}",
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${data['upcomingtitle']}',
                                            style: TextStyle(
                                              // color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Theme.of(context).accentColor,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: ReadMoreText(
                                            "${data['upcomingcontent']}" ?? '',
                                            trimLines: 10,
                                            colorClickableText: Colors.blue,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: '... Read more',
                                            trimExpandedText: '... Show less',
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            '${data['upcomingtype']}',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 13.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
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
                                Card(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .90,
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 200.0,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              Divider(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  height: 8.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
