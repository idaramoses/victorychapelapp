import 'dart:math';

import 'package:WeightApp/group/new_group.dart';
import 'package:WeightApp/homepage/chat_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';

import '../Constants.dart';
import 'group_info.dart';

class groups extends StatefulWidget {
  const groups({Key key}) : super(key: key);

  @override
  _groupsState createState() => _groupsState();
}

class _groupsState extends State<groups> {
  bool isInit = false;
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    //refresh();
    if (!isInit) {
      FirebaseFirestore.instance
          .collection("usersPgroupActivity")
          .doc('${FirebaseAuth.instance.currentUser.uid}')
          .collection('activity')
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.delete();
              }));

      setState(() {
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Constant.mainColor,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Groups",
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => rooms(),
                        ),
                      );
                    },
                    child: Text(
                      'Join group',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          generalGroupList(),
        ],
      ),
    );
  }

  Widget generalGroupList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("usersGeneralGroups")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("groups")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data.docs.length == null) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data.docs.length == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                "No Group Chats.",
                style: TextStyle(
                    color: Constant.mainColor, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Map doc = snapshot.data.docs[index].data();
                  String dataid = snapshot.data.docs[index].id;
                  bool pending = doc["pending"];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Container(
                          // color: Theme.of(context).backgroundColor,
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                pending == false
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Chat(
                                            isadmin: doc["isAdmin"],
                                            peername: doc["name"],
                                            peerId: dataid,
                                            peerAvatar: doc["type"],
                                          ),
                                        ),
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text(
                                                "Pending request",
                                                style: TextStyle(
                                                    color: Colors.orange),
                                              ),
                                              content: Text(
                                                  "Your request to join this group is still pending"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("CANCEL"),
                                                )
                                              ],
                                            ));
                              },
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('generalGroups')
                                      .doc('$dataid' ?? '1')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return const Text("");
                                    else
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //   builder: (context) => SchoolDetails(
                                          //     groupId: schoolid,
                                          //     fromDeepLink: false,
                                          //   ),
                                          // ));
                                        },
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: CachedNetworkImage(
                                                      placeholder:
                                                          (context, s) {
                                                        return Center(
                                                          child: Container(
                                                              height: 70,
                                                              width: 70,
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          'https://cdn.logo.com/hotlink-ok/logo-social.png')))),
                                                        );
                                                      },
                                                      imageUrl: snapshot
                                                          .data["photo"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                  },
                                ),
                              ),
                              title: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('generalGroups')
                                    .doc('$dataid' ?? '1')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return const Text("");
                                  else
                                    return Text(
                                      "${snapshot.data["name"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    );
                                },
                              ),
                              subtitle: pending == false
                                  ? groupLastMessage(dataid,
                                      FirebaseAuth.instance.currentUser.uid)
                                  : Text(
                                      'pending request',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  // Expanded(
                                  //     child: lastGroupMessageTime(
                                  //         dataid,
                                  //         FirebaseAuth
                                  //             .instance.currentUser.uid)),
                                  Expanded(
                                    child: groupChatCounter(dataid),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget groupLastMessage(String groupId, String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('groupChats')
          .doc(groupId)
          .collection(groupId)
          .orderBy("timestamp", descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Map doc = snapshot.data.docs[index].data();
                  String dataid = snapshot.data.docs[index].id;
                  // Group group = value.userGroups.reversed.toList()[index];
                  // Group group = Group(
                  //     id: int.parse(doc.docID),
                  //     name: doc.data["name"],
                  //     photo: doc.data["photo"],
                  //     description: doc.data["description"],
                  //     totalMembers: 0,
                  //     certificate: "",
                  //     type: "",
                  //     year: "",
                  //     schoolId: 0,
                  //     schoolName: "");

                  return RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "${doc["idname"]}:" ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: " ${doc["content"]}" ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                    maxLines: 1,
                  );
                },
              ),
            ],
          );
        } else
          return Text("");
      },
    );
  }

  Widget lastGroupMessageTime(String groupId, String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('groupChats')
          .doc("$groupId")
          .collection("members")
          .doc("$userId")
          .collection("messages")
          .orderBy("timestamp", descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          var now = DateTime.now();
          var today = DateTime(now.year, now.month, now.day);
          var yesterday = DateTime(now.year, now.month, now.day - 1);
          Timestamp time = snapshot.data.docs.length < 1
              ? Timestamp.fromDate(DateTime.now())
              : snapshot.data.docs.last["timestamp"];

          var date = time != null ? time.toDate() : DateTime.now();
          var formattedTime;

          if (DateTime(date.year, date.month, date.day) == today) {
            formattedTime = DateFormat('hh:mm a').format(date);
          } else if (DateTime(date.year, date.month, date.day) == yesterday) {
            formattedTime = "Yesterday";
          } else {
            formattedTime = DateFormat('yMd').format(date);
          }

          return Text(
            snapshot.data.docs.length < 1 ? "" : formattedTime,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          );
        }
        return Text("");
      },
    );
  }

  Widget groupChatCounter(String groupId) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('groupChats')
            .doc("$groupId")
            .collection("members")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("messages")
            .where("read", isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return Container(
              child: snapshot.data.docs.length == 0
                  ? Text("")
                  : Container(
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setHeight(50),
                      child: CircleAvatar(
                        backgroundColor: Colors.greenAccent[400],
                        child: Text(snapshot.data.docs.length.toString() ?? "",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(25),
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
            );
          return Text("");
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
}

class rooms extends StatefulWidget {
  @override
  _roomsState createState() => _roomsState();
}

class _roomsState extends State<rooms> {
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
    List<Color> myColors = [
      Colors.red[200],
      Colors.green[200],
      Colors.deepPurple[200],
      Colors.cyan[200],
      Colors.teal[200],
      Colors.tealAccent[200],
      Colors.pink[200],
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Groups",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Constant.mainColor,
      ),
      body: Container(
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('generalGroups')
              // .orderBy("order", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No Rooms",
                    style: TextStyle(
                      color: Colors.black,
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
                  String dataid = snapshot.data.docs[index].id;
                  String type = snapshot.data.docs[index]['type'];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => Join_Group(
                              groupId: "$dataid", fromDeepLink: true),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen.shade100,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: "${data['photo']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.white.withOpacity(0.05),
                                    Colors.black.withOpacity(1),
                                  ],
                                )),
                              ),
                              type == 'private'
                                  ? Positioned(
                                      top: 5,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // radius of 10
                                                  color: Colors.black.withOpacity(
                                                      0.5) // green as background color
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Icon(CupertinoIcons.lock,
                                                        size: 14,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Private',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              Positioned(
                                bottom: 5,
                                left: 10,
                                right: 0,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data['name']}",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            // backgroundColor: Colors.black45,
                                            color: Colors.white,
                                          ),
                                        ),
                                        FutureBuilder<int>(
                                            future: _getGroupCount(dataid),
                                            builder: (context, snapshot) {
                                              if (snapshot.data == null)
                                                return Text(
                                                  "0 Members",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              return Text(
                                                "${snapshot.data} Members",
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white,
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10), // radius of 10
                                            color: Colors
                                                .white // green as background color
                                            ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Icon(CupertinoIcons.plus,
                                                  size: 16,
                                                  color: Constant.mainColor),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Request to join',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Constant.mainColor),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // when clicked on floating action button prompt to create user
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NewGroup(),
            ),
          );
        },
        label: Text('Create group'),
        backgroundColor: Constant.mainColor,
      ),
    );
  }

  Future<int> _getGroupCount(String dataid) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("generalGroups")
        .doc("$dataid")
        .collection("members")
        .where('pending', isEqualTo: false)
        .get();
    return qs.docs.length;
  }
}
