import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../Constants.dart';
import 'add_gallery.dart';
import 'gallery_detail.dart';

class gallery extends StatefulWidget {
  const gallery({Key key}) : super(key: key);

  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> with TickerProviderStateMixin {
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
            'Gallery Event',
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
        floatingActionButton: Container(
          width: 60,
          height: 60,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("user_id",
                      isEqualTo: FirebaseAuth.instance.currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return snapshot.data.docs.single["isAdmin"] == true
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddGallery()));
                          },
                          backgroundColor: Constant.mainColor,
                          child: Icon(
                            Icons.add,
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
                } else if (snapshot.data.docs.length == 0) {
                  return Text("No Members");
                } else
                  return Text("No Members");
              }),
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
  final scrollController = ScrollController();
  int galleryCount = 5;
  bool loadingMore = false;
  bool showPicker = false;
  String selectedCategory;
  DateTime startDate;
  DateTime endDate;

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
              .collection('gallery')
              // .where('location', isEqualTo: 'town campus')
              // .orderBy("order", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No gallerys events",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                );
              }

              return generalBody();
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

  Widget generalBody() {
    String userId = FirebaseAuth.instance.currentUser.uid;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("gallery")
              .limit(galleryCount)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return SizedBox.shrink();
            else {
              return NotificationListener(
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
                  child: GridView.builder(
                    controller: scrollController,
                    itemCount: snapshot.data.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: (1 / 1.5),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (BuildContext context, int index) {
                      String cover = snapshot.data.docs[index]["cover_image"];
                      int imageCount =
                          snapshot.data.docs[index]["images"] == null
                              ? 1
                              : snapshot.data.docs[index]["images"].length + 1;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          child: Container(
                            color: Theme.of(context).backgroundColor,
                            child: Column(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return GalleryDetail(
                                          id: snapshot.data.docs[index]
                                              ["photo_id"],
                                        );
                                      }));
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(10.0),
                                        //     border: Border.all(
                                        //         color: Colors.white, width: 2)),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Hero(
                                              tag:
                                                  "cover_${snapshot.data.docs[index].id}",
                                              child: CachedNetworkImage(
                                                imageUrl: cover,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          Constant.mainColor),
                                                  child: Center(
                                                    child: Text(
                                                      imageCount.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          fontSize: 12),
                                                    ),
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
                                Container(
                                  height: 60,
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data.docs[index]["description"]}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 15,
                                                    color: Constant.mainColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${snapshot.data.docs[index]["location"]}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Theme.of(context)
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
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    // staggeredTileBuilder: (int index) =>
                    //     StaggeredTile.count(2, index.isEven ? 3 : 2),
                  ),
                ),
              );
            }
          },
        ),
        // StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection("gallery").snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.data == null || snapshot.data.docs == null)
        //       return SizedBox.shrink();
        //     else {
        //       List<DocumentSnapshot> posts = snapshot.data.docs;
        //
        //       return NotificationListener(
        //         onNotification: (ScrollEndNotification notification) {
        //           if (notification is ScrollEndNotification &&
        //               scrollController.position.extentAfter == 0) {
        //             print("end");
        //
        //             setState(() {
        //               loadingMore = true;
        //             });
        //             loadMore();
        //           }
        //           return false;
        //         },
        //         child: Expanded(
        //           child: StaggeredGridView.countBuilder(
        //             controller: scrollController,
        //             crossAxisCount: 4,
        //             itemCount: posts.length >= galleryCount
        //                 ? galleryCount
        //                 : posts.length,
        //             itemBuilder: (BuildContext context, int index) {
        //               String cover = posts[index]["cover_image"];
        //               int imageCount = posts[index]["images"] == null
        //                   ? 1
        //                   : posts[index]["images"].length + 1;
        //               return Column(
        //                 children: [
        //                   Expanded(
        //                     child: InkWell(
        //                       onTap: () {
        //                         Navigator.of(context)
        //                             .push(MaterialPageRoute(builder: (context) {
        //                           return GalleryDetail(
        //                             id: snapshot.data.docs[index]["photo_id"],
        //                           );
        //                         }));
        //                       },
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                             border: Border.all(
        //                                 color: Colors.white, width: 2)),
        //                         child: Stack(
        //                           fit: StackFit.expand,
        //                           children: [
        //                             Hero(
        //                               tag: "cover_${posts[index].id}",
        //                               child: CachedNetworkImage(
        //                                 placeholder: (context, s) {
        //                                   return Center(
        //                                     child: SpinKitThreeBounce(
        //                                       color: Colors.grey,
        //                                       size: 20,
        //                                     ),
        //                                   );
        //                                 },
        //                                 imageUrl: cover,
        //                                 fit: BoxFit.cover,
        //                               ),
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: Align(
        //                                 alignment: Alignment.topLeft,
        //                                 child: Container(
        //                                   height: 20,
        //                                   width: 20,
        //                                   decoration: BoxDecoration(
        //                                       shape: BoxShape.circle,
        //                                       color: Colors.green),
        //                                   child: Center(
        //                                     child: Text(
        //                                       imageCount.toString(),
        //                                       style: TextStyle(
        //                                           color: Colors.white,
        //                                           fontSize: 12),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                             Align(
        //                               alignment: Alignment.topRight,
        //                               child: StreamBuilder<DocumentSnapshot>(
        //                                 stream: FirebaseFirestore.instance
        //                                     .collection("favourites")
        //                                     .doc("gallery")
        //                                     .collection("$userId")
        //                                     .doc(posts[index].id)
        //                                     .snapshots(),
        //                                 builder: (context, snap) {
        //                                   if (snap.data == null) {
        //                                     return SizedBox.shrink();
        //                                   }
        //                                   return IconButton(
        //                                     onPressed: () {
        //                                       if (!snap.data.exists)
        //                                         addToFav(posts[index]);
        //                                       else
        //                                         removeFromFav(posts[index]);
        //                                     },
        //                                     icon: Icon(
        //                                       Icons.favorite,
        //                                       color: !snap.data.exists
        //                                           ? Colors.grey
        //                                           : Colors.red,
        //                                     ),
        //                                   );
        //                                 },
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Container(
        //                     height: 50,
        //                     decoration: BoxDecoration(
        //                         border: Border.all(color: Colors.black)),
        //                     child: Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: Row(
        //                         crossAxisAlignment: CrossAxisAlignment.end,
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Expanded(
        //                             child: Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               children: [
        //                                 Text(
        //                                   "${snapshot.data.docs[index]["description"]}",
        //                                   maxLines: 1,
        //                                   overflow: TextOverflow.ellipsis,
        //                                   style: TextStyle(
        //                                       fontSize: 12, color: Colors.grey),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               );
        //             },
        //             staggeredTileBuilder: (int index) =>
        //                 StaggeredTile.count(2, index.isEven ? 3 : 2),
        //           ),
        //         ),
        //       );
        //     }
        //   },
        // ),
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
  }

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      galleryCount += 5;
      loadingMore = false;
    });
  }

  void addToFav(DocumentSnapshot documentSnapshot) {
    FirebaseFirestore.instance
        .collection("favourites")
        .doc("gallery")
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc(documentSnapshot.id)
        .set(Map.from(documentSnapshot.data()));
    Fluttertoast.showToast(msg: "Added to favourites");
  }

  void removeFromFav(DocumentSnapshot documentSnapshot) {
    FirebaseFirestore.instance
        .collection("favourites")
        .doc("gallery")
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc(documentSnapshot.id)
        .delete();
    Fluttertoast.showToast(msg: "Removed from favourites");
  }

  Widget startDateButton() {
    String selectedDate;
    if (startDate != null) {
      selectedDate = DateFormat('MMM d, y').format(startDate);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.0,
        width: 150,
        child: FlatButton(
          onPressed: () => selectStartDate(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(selectedDate ?? "START DATE"), SizedBox()],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0, color: Colors.black)),
      ),
    );
  }

  Widget endDateButton() {
    String selectedDate;
    if (endDate != null) {
      selectedDate = DateFormat('MMM d, y').format(endDate);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.0,
        width: 150,
        child: FlatButton(
          onPressed: () => selectEndDate(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(selectedDate ?? "END DATE"), SizedBox()],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0, color: Colors.black)),
      ),
    );
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime(2025),
    );
    if (d != null) {
      setState(() {
        startDate = d;
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime(2025),
    );
    if (d != null) {
      setState(() {
        endDate = d;
      });
    }
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
                    "No gallerys events",
                    style: TextStyle(
                      color: Colors.white70,
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
                      //     builder: (context) => gallerydetails(
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              children: [
                                Container(
                                  child: Material(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        child: CircularProgressIndicator(),
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
                                              color: Colors.black,
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
              return Center(
                child: Text("Loading..."),
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
                    "No gallerys events",
                    style: TextStyle(
                      color: Colors.white70,
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
                      //     builder: (context) => gallerydetails(
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              children: [
                                Container(
                                  child: Material(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        child: CircularProgressIndicator(),
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
                                              color: Colors.black,
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
              return Center(
                child: Text("Loading..."),
              );
            }
          },
        ),
      ),
    );
  }
}
