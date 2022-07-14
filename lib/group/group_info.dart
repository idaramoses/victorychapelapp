import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/utils/flushbar_mixin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class Join_Group extends StatefulWidget {
  final String groupId;
  final bool fromDeepLink;

  const Join_Group({
    Key key,
    @required this.groupId,
    this.fromDeepLink = false,
  }) : super(key: key);

  @override
  _Join_GroupState createState() => _Join_GroupState();
}

class _Join_GroupState extends State<Join_Group> with FlushBarMixin {
  String token;
  String userPhoto;
  int pgroupid;
  int galleryCount = 15;
  final scrollController = ScrollController();
  bool loadingMore = false;
  bool isscrooleddown = false;
  bool isfirstscrooldown = true;
  int currentIndex = 0;
  int currentPostId = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
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
    return WillPopScope(
      onWillPop: widget.fromDeepLink
          ? () async {
              Navigator.pop(context);
              return true;
            }
          : () async {
              Navigator.pop(context);
              return true;
            },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/p_group.jpeg'),
                fit: BoxFit.cover,
              ),
            )),
            _body(),
          ],
        ),
      ),
    );
  }

  Future<int> _getGroupCount() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("generalGroups")
        .doc("${widget.groupId}")
        .collection("members")
        .where('pending', isEqualTo: false)
        .get();
    return qs.docs.length;
  }

  void next() async {
    showSuccessNotification(context, "Joined group");
    Fluttertoast.showToast(
        msg: "Joined group", backgroundColor: Colors.green.withOpacity(0.5));
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void leavepage() async {
    Fluttertoast.showToast(
        msg: "You've left  group",
        backgroundColor: Colors.red.withOpacity(0.5));
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget _body() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("generalGroups")
          .doc("${widget.groupId}")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * .25,
                flexibleSpace: Container(
                  child: FlexibleSpaceBar(
                    background: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: '${snapshot.data["photo"]}' == null
                                  ? AssetImage(
                                      "assets/images/cube.png",
                                    )
                                  : NetworkImage('${snapshot.data["photo"]}')),
                        )),
                  ),
                ),
                actions: <Widget>[
                  // FutureBuilder(
                  //     future: _getGroupDetails(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         DocumentSnapshot groupDetails = snapshot.data;
                  //
                  //         return (groupDetails["createdUserId"] ==
                  //             context.read<AuthProvider>().userInfo.id)
                  //             ? FlatButton(
                  //             onPressed: () {
                  //               Navigator.of(context).push(
                  //                   MaterialPageRoute(builder: (context) {
                  //                     return NewGroup(
                  //                       isEdit: true,
                  //                       groupDetails: groupDetails,
                  //                     );
                  //                   }));
                  //             },
                  //             child: Text(
                  //               "EDIT",
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //               ),
                  //             ))
                  //             : SizedBox();
                  //       } else
                  //         return SizedBox();
                  //     })
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((
                  context,
                  index,
                ) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '${snapshot.data["name"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                height: 1.5,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                        color: Constant.mainColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('${snapshot.data["description"]}'),
                                  Container(
                                    height: 1.5,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      snapshot.data["createdUserId"] ==
                                              FirebaseAuth
                                                  .instance.currentUser.uid
                                          ? InkWell(
                                              onTap: () {},
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    "Delete Group",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                ],
                                              ),
                                            )
                                          : (snapshot.data["createdUserId"] !=
                                                      FirebaseAuth.instance
                                                          .currentUser.uid &&
                                                  widget.fromDeepLink)
                                              ? InkWell(
                                                  onTap: () async {
                                                    bool pendinng = false;
                                                    if (snapshot.data["type"] ==
                                                        'private') {
                                                      pendinng = true;
                                                    } else {
                                                      pendinng = false;
                                                    }
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  title: Text(
                                                                      "Request to  join?"),
                                                                  content: Text(
                                                                      "Are you sure you want to join group?"),
                                                                  actions: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () async {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Loading...",
                                                                            backgroundColor:
                                                                                Colors.green.withOpacity(0.5));
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "generalGroups")
                                                                            .doc(snapshot.data[
                                                                                "id"])
                                                                            .collection(
                                                                                "members")
                                                                            .doc(FirebaseAuth
                                                                                .instance.currentUser.uid)
                                                                            .set({
                                                                          'name': FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          "photo": FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          "profession": FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          "pending":
                                                                              pendinng,
                                                                          "isAdmin":
                                                                              false,
                                                                          'token':
                                                                              token,
                                                                        }).whenComplete(() =>
                                                                                {
                                                                                  _firebaseMessaging.getToken().then((token) async {
                                                                                    print(token);
                                                                                    await FirebaseFirestore.instance.collection("generalGroups").doc(snapshot.data["name"]).collection("members").doc(FirebaseAuth.instance.currentUser.uid).update({
                                                                                      'token': token.toString()
                                                                                    });
                                                                                  })
                                                                                });
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "usersGeneralGroups")
                                                                            .doc(FirebaseAuth
                                                                                .instance.currentUser.uid)
                                                                            .collection(
                                                                                "groups")
                                                                            .doc(snapshot.data[
                                                                                "id"])
                                                                            .set({
                                                                          "userId": FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .uid,
                                                                          "isAdmin":
                                                                              false,
                                                                          "joined":
                                                                              DateTime.now(),
                                                                          "name":
                                                                              snapshot.data["name"],
                                                                          "type":
                                                                              snapshot.data["type"],
                                                                          "pending":
                                                                              pendinng
                                                                        }).whenComplete(() =>
                                                                                next());
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "CANCEL"),
                                                                    )
                                                                  ],
                                                                ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        "Join Group",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    snapshot.data["id"] ==
                                                            pgroupid
                                                        ? showBottom(
                                                            snapshot.data["id"])
                                                        : showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Leave group?"),
                                                                      content: Text(
                                                                          "Are you sure you want to leave group?"),
                                                                      actions: <
                                                                          Widget>[
                                                                        FlatButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await FirebaseFirestore.instance.collection("generalGroups").doc("${snapshot.data.documentID}").collection("members").doc(FirebaseAuth.instance.currentUser.uid).delete();
                                                                            await FirebaseFirestore.instance.collection("usersGeneralGroups").doc(FirebaseAuth.instance.currentUser.uid).collection("groups").doc("${snapshot.data.documentID}").delete();
                                                                            Navigator.pop(context);
                                                                            // DocumentReference user_school = Firestore
                                                                            //     .instance
                                                                            //     .collection("user_pgroup")
                                                                            //     .document(context
                                                                            //     .read<AuthProvider>()
                                                                            //     .userInfo
                                                                            //     .id
                                                                            //     .toString());
                                                                            // user_school.delete();
                                                                            leavepage();
                                                                          },
                                                                          child:
                                                                              Text("OK"),
                                                                        ),
                                                                        FlatButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text("CANCEL"),
                                                                        )
                                                                      ],
                                                                    ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.exit_to_app,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        "Leave Group",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                      InkWell(
                                        onTap: () async {
                                          String link = await groupJoinLink(
                                            widget.groupId,
                                          );
                                          Share.share(
                                              "${FirebaseAuth.instance.currentUser.displayName} invites you to join ${snapshot.data["name"]} $link");
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.share_outlined,
                                              color: Constant.mainColor,
                                            ),
                                            Text(
                                              "Share Group Link",
                                              style: TextStyle(
                                                  color: Constant.mainColor),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 1.5,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  SizedBox(height: 20),
                                  ExpansionTile(
                                    title: Text('Members'),
                                    subtitle: FutureBuilder<int>(
                                        future: _getGroupCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null)
                                            return Text("0");
                                          return Text("${snapshot.data}");
                                        }),
                                    children: <Widget>[
                                      Column(
                                        children: [grouplist()],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }, childCount: 1),
              )
            ],
          );
      },
    );
  }

  Widget grouplist() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("generalGroups")
                .doc("${widget.groupId}")
                .collection("members")
                .where('pending', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return NotificationListener(
                  onNotification: (ScrollEndNotification notification) {
                    if (notification is ScrollEndNotification &&
                        scrollController.position.extentAfter == 0) {
                      print("end");
                      setState(() {
                        loadingMore = true;
                      });
                      loadMoree();
                    }
                    if (notification is ScrollEndNotification &&
                        scrollController.position.extentBefore == 0) {
                      print("begining");
                      setState(() {
                        isscrooleddown = false;
                        // _open = true;
                      });
                    }
                    return false;
                  },
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.docs[index];
                      String evenOrOdd = index % 2 == 0 ? 'even' : 'odd';
                      return Column(
                        children: [
                          Container(
                            color: evenOrOdd == 'odd'
                                ? Colors.grey.withOpacity(0.7)
                                : Colors.white,
                            height: 70,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "${documentSnapshot["name"]}",
                                      style: TextStyle(
                                        color: evenOrOdd != 'odd'
                                            ? Colors.black54
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.data.docs.length == 0) {
                return Text("No Members");
              } else
                return Text("No Members");
            })
      ],
    );
  }

  Widget images({DocumentSnapshot documentSnapshot}) {
    return Container(
      height: 250,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: documentSnapshot['images'].length,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
            currentPostId = documentSnapshot['post_id'];
          });
        },
        itemBuilder: (context, index) {
          String image = documentSnapshot['images'][index];
          int current_index = index + 1;
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.black,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: documentSnapshot['images'].length,
                            onPageChanged: (value) {
                              setState(() {
                                // currentIndex = value;
                                // currentPostId = documentSnapshot['post_id'];
                              });
                            },
                            itemBuilder: (context, index) {
                              String image = documentSnapshot['images'][index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: InkWell(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(0.0)),
                                    child: CachedNetworkImage(
                                      placeholder: (_, string) {
                                        return Container(
                                          height: 500,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                      imageUrl: image,
                                      fit: BoxFit.fitWidth,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  '${documentSnapshot['title']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 400,
                    child: CachedNetworkImage(
                      placeholder: (_, string) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      imageUrl: image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 20,
                      width: 35,
                      decoration: BoxDecoration(color: Constant.mainColor),
                      child: Center(
                        child: Text(
                          '$current_index/${documentSnapshot['images'].length}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> loadMoree() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      galleryCount += 10;
      loadingMore = false;
    });
  }

  showBottom(int groupid) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .45,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Oops,You cannot leave your current Professional-group"),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Center(
                        child: Text(
                      "Select Professional Feed",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<List<DocumentSnapshot>> getGeneralGroups() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("usersGeneralGroups")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("groups")
        .get();
    List<DocumentSnapshot> docs = qs.docs;
    return docs;
  }

  void leaveGroup() async {
    await FirebaseFirestore.instance
        .collection("generalGroups")
        .doc("${widget.groupId}")
        .collection("members")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .delete();
    await FirebaseFirestore.instance
        .collection("usersGeneralGroups")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("groups")
        .doc("${widget.groupId}")
        .delete();
    Flushbar(
      message: "left group}",
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.green[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.green[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
    Fluttertoast.showToast(
        msg: "Leaving group ,please wait...",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Constant.mainColor,
        textColor: Colors.white,
        fontSize: 14.0);
    Navigator.of(context).pop();
  }

  Future<String> groupJoinLink(
    String groupId,
  ) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://victorychapelapp.page.link',
      link: Uri.parse(
          'https://app.victorychapelapp.com/groups-join?groupId=$groupId'),
      androidParameters: AndroidParameters(
          packageName: 'app.maradistudio.victory_chapel_uniuyo'),
      // iosParameters: IosParameters(bundleId: 'com.dreamlabs.vc-apps01')
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    final Uri shortUrl = shortenedLink.shortUrl;
    return 'https://victorychapelapp.page.link' + shortUrl.path;
  }

  void _showShareOptions(String groupDetails, String data) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  // onPressed: () async {
                  //   String link = await groupJoinLink(
                  //     groupDetails["id"],
                  //   );
                  //   Navigator.of(context)
                  //       .push(MaterialPageRoute(builder: (context) {
                  //     return ShareLinkPage(
                  //         link:
                  //             "${FirebaseAuth.instance.currentUser.displayName} invites you to join ${groupDetails["name"]} $link");
                  //   }));
                  // },
                  child: Text("Share in App"),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () async {
                    String link = await groupJoinLink(
                      widget.groupId,
                    );
                    Share.share(
                        "${FirebaseAuth.instance.currentUser.uid} invites you to join $data $link");
                  },
                  child: Text("Share outside App"),
                ),
              ],
            ),
          );
        });
  }
}

class Main_Join extends StatefulWidget {
  final String groupId;
  final bool fromDeepLink;

  const Main_Join({
    Key key,
    @required this.groupId,
    this.fromDeepLink = false,
  }) : super(key: key);

  @override
  _Main_JoinState createState() => _Main_JoinState();
}

class _Main_JoinState extends State<Main_Join> with FlushBarMixin {
  String token;
  String userPhoto;
  int pgroupid;
  int galleryCount = 15;
  final scrollController = ScrollController();
  bool loadingMore = false;
  bool isscrooleddown = false;
  bool isfirstscrooldown = true;
  int currentIndex = 0;
  int currentPostId = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
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
    return WillPopScope(
      onWillPop: widget.fromDeepLink
          ? () async {
              Navigator.pop(context);
              return true;
            }
          : () async {
              Navigator.pop(context);
              return true;
            },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/p_group.jpeg'),
                fit: BoxFit.cover,
              ),
            )),
            _body(),
          ],
        ),
      ),
    );
  }

  Future<int> _getGroupCount() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("generalGroups")
        .doc("${widget.groupId}")
        .collection("members")
        .where('pending', isEqualTo: false)
        .get();
    return qs.docs.length;
  }

  void next() async {
    showSuccessNotification(context, "Joined group");
    Fluttertoast.showToast(
        msg: "Joined group", backgroundColor: Colors.green.withOpacity(0.5));
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    // Navigator.pop(context);
  }

  void leavepage() async {
    showSuccessNotification(context, "You've left  group");
    Fluttertoast.showToast(
        msg: "You've left  group",
        backgroundColor: Colors.red.withOpacity(0.5));
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget _body() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("generalGroups")
          .doc("${widget.groupId}")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * .25,
                flexibleSpace: Container(
                  child: FlexibleSpaceBar(
                    background: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: '${snapshot.data["photo"]}' == null
                                  ? AssetImage(
                                      "assets/images/cube.png",
                                    )
                                  : NetworkImage('${snapshot.data["photo"]}')),
                        )),
                  ),
                ),
                actions: <Widget>[
                  // FutureBuilder(
                  //     future: _getGroupDetails(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         DocumentSnapshot groupDetails = snapshot.data;
                  //
                  //         return (groupDetails["createdUserId"] ==
                  //             context.read<AuthProvider>().userInfo.id)
                  //             ? FlatButton(
                  //             onPressed: () {
                  //               Navigator.of(context).push(
                  //                   MaterialPageRoute(builder: (context) {
                  //                     return NewGroup(
                  //                       isEdit: true,
                  //                       groupDetails: groupDetails,
                  //                     );
                  //                   }));
                  //             },
                  //             child: Text(
                  //               "EDIT",
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //               ),
                  //             ))
                  //             : SizedBox();
                  //       } else
                  //         return SizedBox();
                  //     })
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((
                  context,
                  index,
                ) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '${snapshot.data["name"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                height: 1.5,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                        color: Constant.mainColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('${snapshot.data["description"]}'),
                                  Container(
                                    height: 1.5,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      snapshot.data["createdUserId"] ==
                                              FirebaseAuth
                                                  .instance.currentUser.uid
                                          ? InkWell(
                                              onTap: () {},
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    "Delete Group",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                ],
                                              ),
                                            )
                                          : (snapshot.data["createdUserId"] !=
                                                      FirebaseAuth.instance
                                                          .currentUser.uid &&
                                                  widget.fromDeepLink)
                                              ? InkWell(
                                                  onTap: () async {
                                                    bool pendinng = false;
                                                    if (snapshot.data["type"] ==
                                                        'private') {
                                                      pendinng = true;
                                                    } else {
                                                      pendinng = false;
                                                    }
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  title: Text(
                                                                      "Request to  join?"),
                                                                  content: Text(
                                                                      "Are you sure you want to join group?"),
                                                                  actions: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () async {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Loading...",
                                                                            backgroundColor:
                                                                                Colors.green.withOpacity(0.5));
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "generalGroups")
                                                                            .doc(snapshot.data[
                                                                                "id"])
                                                                            .collection(
                                                                                "members")
                                                                            .doc(FirebaseAuth
                                                                                .instance.currentUser.uid)
                                                                            .set({
                                                                          'name': FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          "photo": FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          "profession": FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          "pending":
                                                                              pendinng,
                                                                          "isAdmin":
                                                                              false,
                                                                          'token':
                                                                              token,
                                                                        }).whenComplete(() =>
                                                                                {
                                                                                  _firebaseMessaging.getToken().then((token) async {
                                                                                    print(token);
                                                                                    await FirebaseFirestore.instance.collection("generalGroups").doc(snapshot.data["name"]).collection("members").doc(FirebaseAuth.instance.currentUser.uid).update({
                                                                                      'token': token.toString()
                                                                                    });
                                                                                  })
                                                                                });
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "usersGeneralGroups")
                                                                            .doc(FirebaseAuth
                                                                                .instance.currentUser.uid)
                                                                            .collection(
                                                                                "groups")
                                                                            .doc(snapshot.data[
                                                                                "id"])
                                                                            .set({
                                                                          "userId": FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .uid,
                                                                          "isAdmin":
                                                                              false,
                                                                          "joined":
                                                                              DateTime.now(),
                                                                          "name":
                                                                              snapshot.data["name"],
                                                                          "type":
                                                                              snapshot.data["type"],
                                                                          "pending":
                                                                              pendinng
                                                                        }).whenComplete(() =>
                                                                                next());
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "CANCEL"),
                                                                    )
                                                                  ],
                                                                ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        "Join Group",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    snapshot.data["id"] ==
                                                            pgroupid
                                                        ? showBottom(
                                                            snapshot.data["id"])
                                                        : showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Leave group?"),
                                                                      content: Text(
                                                                          "Are you sure you want to leave group?"),
                                                                      actions: <
                                                                          Widget>[
                                                                        FlatButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await FirebaseFirestore.instance.collection("generalGroups").doc("${snapshot.data.documentID}").collection("members").doc(FirebaseAuth.instance.currentUser.uid).delete();
                                                                            await FirebaseFirestore.instance.collection("usersGeneralGroups").doc(FirebaseAuth.instance.currentUser.uid).collection("groups").doc("${snapshot.data.documentID}").delete();
                                                                            Navigator.pop(context);
                                                                            // DocumentReference user_school = Firestore
                                                                            //     .instance
                                                                            //     .collection("user_pgroup")
                                                                            //     .document(context
                                                                            //     .read<AuthProvider>()
                                                                            //     .userInfo
                                                                            //     .id
                                                                            //     .toString());
                                                                            // user_school.delete();
                                                                            leavepage();
                                                                          },
                                                                          child:
                                                                              Text("OK"),
                                                                        ),
                                                                        FlatButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text("CANCEL"),
                                                                        )
                                                                      ],
                                                                    ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.exit_to_app,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        "Leave Group",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                      // InkWell(
                                      //   onTap: () async {
                                      //     String link = await groupJoinLink(
                                      //       widget.groupId,
                                      //     );
                                      //     Share.share(
                                      //         "${FirebaseAuth.instance.currentUser.displayName} invites you to join ${snapshot.data["name"]} $link");
                                      //   },
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(
                                      //         Icons.share_outlined,
                                      //         color: Constant.mainColor,
                                      //       ),
                                      //       Text(
                                      //         "Share Group Link",
                                      //         style: TextStyle(
                                      //             color: Constant.mainColor),
                                      //       )
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 1.5,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  SizedBox(height: 20),
                                  ExpansionTile(
                                    title: Text('Members'),
                                    subtitle: FutureBuilder<int>(
                                        future: _getGroupCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null)
                                            return Text("0");
                                          return Text("${snapshot.data}");
                                        }),
                                    children: <Widget>[
                                      Column(
                                        children: [grouplist()],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }, childCount: 1),
              )
            ],
          );
      },
    );
  }

  Widget grouplist() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("generalGroups")
                .doc("${widget.groupId}")
                .collection("members")
                .where('pending', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return NotificationListener(
                  onNotification: (ScrollEndNotification notification) {
                    if (notification is ScrollEndNotification &&
                        scrollController.position.extentAfter == 0) {
                      print("end");
                      setState(() {
                        loadingMore = true;
                      });
                      loadMoree();
                    }
                    if (notification is ScrollEndNotification &&
                        scrollController.position.extentBefore == 0) {
                      print("begining");
                      setState(() {
                        isscrooleddown = false;
                        // _open = true;
                      });
                    }
                    return false;
                  },
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.docs[index];
                      String evenOrOdd = index % 2 == 0 ? 'even' : 'odd';
                      return Column(
                        children: [
                          Container(
                            color: evenOrOdd == 'odd'
                                ? Colors.grey.withOpacity(0.7)
                                : Colors.white,
                            height: 70,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "${documentSnapshot["name"]}",
                                      style: TextStyle(
                                        color: evenOrOdd != 'odd'
                                            ? Colors.black54
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.data.docs.length == 0) {
                return Text("No Members");
              } else
                return Text("No Members");
            })
      ],
    );
  }

  Widget images({DocumentSnapshot documentSnapshot}) {
    return Container(
      height: 250,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: documentSnapshot['images'].length,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
            currentPostId = documentSnapshot['post_id'];
          });
        },
        itemBuilder: (context, index) {
          String image = documentSnapshot['images'][index];
          int current_index = index + 1;
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.black,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: documentSnapshot['images'].length,
                            onPageChanged: (value) {
                              setState(() {
                                // currentIndex = value;
                                // currentPostId = documentSnapshot['post_id'];
                              });
                            },
                            itemBuilder: (context, index) {
                              String image = documentSnapshot['images'][index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: InkWell(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(0.0)),
                                    child: CachedNetworkImage(
                                      placeholder: (_, string) {
                                        return Container(
                                          height: 500,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                      imageUrl: image,
                                      fit: BoxFit.fitWidth,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  '${documentSnapshot['title']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 400,
                    child: CachedNetworkImage(
                      placeholder: (_, string) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      imageUrl: image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 20,
                      width: 35,
                      decoration: BoxDecoration(color: Constant.mainColor),
                      child: Center(
                        child: Text(
                          '$current_index/${documentSnapshot['images'].length}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> loadMoree() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      galleryCount += 10;
      loadingMore = false;
    });
  }

  showBottom(int groupid) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .45,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Oops,You cannot leave your current Professional-group"),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Center(
                        child: Text(
                      "Select Professional Feed",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<List<DocumentSnapshot>> getGeneralGroups() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("usersGeneralGroups")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("groups")
        .get();
    List<DocumentSnapshot> docs = qs.docs;
    return docs;
  }

  void leaveGroup() async {
    await FirebaseFirestore.instance
        .collection("generalGroups")
        .doc("${widget.groupId}")
        .collection("members")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .delete();
    await FirebaseFirestore.instance
        .collection("usersGeneralGroups")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("groups")
        .doc("${widget.groupId}")
        .delete();
    Flushbar(
      message: "left group}",
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.green[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.green[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
    Fluttertoast.showToast(
        msg: "Leaving group ,please wait...",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Constant.mainColor,
        textColor: Colors.white,
        fontSize: 14.0);
    Navigator.of(context).pop();
  }

  Future<String> groupJoinLink(
    String groupId,
  ) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://victorychapelapp.page.link',
      link: Uri.parse(
          'https://app.victorychapelapp.com/groups-join?groupId=$groupId'),
      androidParameters: AndroidParameters(
          packageName: 'app.maradistudio.victory_chapel_uniuyo'),
      // iosParameters: IosParameters(bundleId: 'com.dreamlabs.vc-apps01')
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    final Uri shortUrl = shortenedLink.shortUrl;
    return 'https://victorychapelapp.page.link' + shortUrl.path;
  }

  void _showShareOptions(String groupDetails, String data) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  // onPressed: () async {
                  //   String link = await groupJoinLink(
                  //     groupDetails["id"],
                  //   );
                  //   Navigator.of(context)
                  //       .push(MaterialPageRoute(builder: (context) {
                  //     return ShareLinkPage(
                  //         link:
                  //             "${FirebaseAuth.instance.currentUser.displayName} invites you to join ${groupDetails["name"]} $link");
                  //   }));
                  // },
                  child: Text("Share in App"),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () async {
                    String link = await groupJoinLink(
                      widget.groupId,
                    );
                    Share.share(
                        "${FirebaseAuth.instance.currentUser.uid} invites you to join $data $link");
                  },
                  child: Text("Share outside App"),
                ),
              ],
            ),
          );
        });
  }
}
