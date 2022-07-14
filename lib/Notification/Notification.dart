import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/homepage/widget/menu_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      readNotifications();
      setState(() {
        isInit = true;
      });
    }
  }

  void readNotifications() {
    FirebaseFirestore.instance
        .collection("notifications")
        .doc("${FirebaseAuth.instance.currentUser.uid}")
        .collection("${FirebaseAuth.instance.currentUser.uid}")
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.update({"read": true});
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Constant.mainColor,
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (choice) {
              switch (choice.title) {
                case "Mark all as read":
                  break;
                case "Delete all notifications":
                  FirebaseFirestore.instance
                      .collection("notifications")
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection(FirebaseAuth.instance.currentUser.uid)
                      .get()
                      .then((value) => value.docs.forEach((element) {
                            element.reference.delete();
                          }));
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                Choice(
                    icon: Icons.mark_chat_read_outlined,
                    title: "Mark all as read"),
                Choice(
                    icon: Icons.delete_outlined,
                    title: "Delete all notifications"),
              ].map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        choice.icon,
                        color: Constant.mainColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        choice.title,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("notifications")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection(FirebaseAuth.instance.currentUser.uid)
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                Timestamp date = documentSnapshot["timestamp"];
                var time = DateFormat("MMM d, h:m a").format(date.toDate());
                return Column(
                  children: [
                    documentSnapshot["notiread"] != true
                        ? Card(
                            color: Constant.mainColor.withOpacity(0.5),
                            child: ListTile(
                              onTap: () {
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(builder: (context) {
                                //   return ArticleDetailNotification(
                                //     documentSnapshot:
                                //         snapshot.data.documents[index],
                                //   );
                                // }));
                                FirebaseFirestore.instance
                                    .collection("notifications")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .collection(
                                        FirebaseAuth.instance.currentUser.uid)
                                    .doc(documentSnapshot['data']["id"])
                                    .update({
                                  'notiread': true,
                                });
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.red[500],
                                  ),
                                ],
                              ),
                              title: Text(documentSnapshot["title"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(documentSnapshot["content"],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              trailing: Text(time,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white)),
                            ),
                          )
                        : Card(
                            color: Colors.white,
                            child: ListTile(
                              onTap: () {
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(builder: (context) {
                                //   return ArticleDetailNotification(
                                //     documentSnapshot:
                                //         snapshot.data.documents[index],
                                //   );
                                // }));
                                FirebaseFirestore.instance
                                    .collection("notifications")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .collection(
                                        FirebaseAuth.instance.currentUser.uid)
                                    .doc(documentSnapshot['data']["id"])
                                    .update({
                                  'notiread': true,
                                });
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.green[500],
                                  ),
                                ],
                              ),
                              title: Text(documentSnapshot["title"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(documentSnapshot["content"],
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                              trailing: Text(time,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Constant.mainColor)),
                            ),
                          ),
                  ],
                );
              },
            );
          } else
            return Container();
        },
      ),
    );
  }
}
