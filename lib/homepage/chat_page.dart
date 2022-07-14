import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/group/group_info.dart';
import 'package:WeightApp/homepage/widget/menu_widget.dart';
import 'package:WeightApp/utils/flushbar_mixin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../Constants.dart';

class Chat extends StatefulWidget {
  final String peerId;
  final bool isadmin;
  final String peername;
  final String peerAvatar;

  Chat(
      {Key key,
      @required this.peerId,
      @required this.peername,
      @required this.peerAvatar,
      @required this.isadmin})
      : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with FlushBarMixin {
  bool isInit = false;
  void leavepage() async {
    showSuccessNotification(context, "You've left  group");
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInit) {
      readChat();
      setState(() {
        isInit = true;
      });
    }
  }

  void readChat() {
    FirebaseFirestore.instance
        .collection('groupChats')
        .doc(widget.peerId)
        .collection("members")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("messages")
        .where('read', isEqualTo: false)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.update({"read": true});
            }));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.appbarColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.peername,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          widget.peerAvatar == 'private'
              ? Column(
                  children: [
                    widget.isadmin
                        ? Stack(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Notifications(
                                                peerId: widget.peerId)));
                                  },
                                  icon: Icon(
                                    Icons.notifications_none,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("notifications")
                                        .doc("${widget.peerId}")
                                        .collection("${widget.peerId}")
                                        .where("read", isEqualTo: false)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null ||
                                          snapshot.data.docs.length == 0) {
                                        return SizedBox.shrink();
                                      } else
                                        return Container(
                                          height: 19,
                                          width: 19,
                                          child: Center(
                                              child: Text(
                                            snapshot.data.docs.length
                                                .toString(),
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(30),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.red, width: 2),
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                        );
                                    }),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                )
              : SizedBox(),
          PopupMenuButton<Choice>(
            icon: Icon(Icons.more_vert, color: Constant.appiconColor),
            onSelected: (choice) {
              switch (choice.title) {
                case "Info":
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Join_Group(
                          groupId: "${widget.peerId}", fromDeepLink: false),
                    ),
                  );
                  break;
                case "Leave group":
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Leave group?"),
                            content:
                                Text("Are you sure you want to leave group?"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("generalGroups")
                                      .doc("${widget.peerId}")
                                      .collection("members")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .delete();
                                  await FirebaseFirestore.instance
                                      .collection("usersGeneralGroups")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .collection("groups")
                                      .doc("${widget.peerId}")
                                      .delete();
                                  Navigator.pop(context);
                                  leavepage();
                                },
                                child: Text("OK"),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("CANCEL"),
                              )
                            ],
                          ));
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                Choice(icon: Icons.info_outline, title: "Info"),
                Choice(icon: Icons.exit_to_app, title: "Leave group")
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
                        style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: new ChatScreen(
        peerId: widget.peerId,
        peerAvatar: widget.peerAvatar,
        peername: widget.peername,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String peername;

  ChatScreen(
      {Key key,
      @required this.peerId,
      @required this.peername,
      @required this.peerAvatar})
      : super(key: key);

  @override
  State createState() =>
      new ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerId, @required this.peerAvatar});

  String peerId;
  String peerAvatar;
  String id;
  TextEditingController commentController = TextEditingController();

  var listMessage;

  // String peerId = 'main id';

  File imageFile;
  File videoFile;
  bool isShowSticker;
  bool isimage = false;
  bool isvideo = false;
  String imageUrl;
  bool isLoading = false;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();
  bool isInit = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    isShowSticker = false;
    imageUrl = '';
    // readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInit) {
      readChat();
      setState(() {
        isInit = true;
      });
    }
  }

  void readChat() {
    FirebaseFirestore.instance
        .collection('groupChats')
        .doc("$peerId")
        .collection("members")
        .doc("$peerId")
        .collection("messages")
        .where('read', isEqualTo: false)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.update({"read": true});
            }));
  }
  // readLocal() async {
  //   if (id.hashCode <= peerId.hashCode) {
  //     peerId = '$id-$peerId';
  //   } else {
  //     peerId = '$peerId-$id';
  //   }
  //   setState(() {});
  // }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image;
      compressFile();
    });
  }

  Future compressFile() async {
    showBottom();
  }

  Future getVideo() async {
    var video = await ImagePicker.pickVideo(
      source: ImageSource.gallery,
    );
    setState(() {
      videoFile = video;
    });
  }

  showBottom() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white.withOpacity(0.02),
                Constant.mainColor.withOpacity(0.02),
                Colors.white.withOpacity(0.02),
              ],
            )),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    // color: Colors.grey[200],
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Add Image",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(40),
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    width: 400,
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            minLines: 5,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            controller: commentController,
                            decoration: InputDecoration.collapsed(
                              hintStyle: TextStyle(fontSize: 12),
                              hintText: "Write Something...",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: isLoading
                        ? Center(
                            child: SpinKitThreeBounce(
                            color: Colors.black,
                            size: 30,
                          ))
                        : Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              // color: Constant.mainColor,
                              style: ElevatedButton.styleFrom(
                                primary: Constant.mainColor,
                              ),
                              child: Text(
                                "Post",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                uploadimage();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  showdetails({DocumentSnapshot documentSnapshot}) {
    onview(documentSnapshot['timestamp']);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
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
            height: MediaQuery.of(context).size.height * .95,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    // color: Colors.grey[200],
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          "Prayer Details",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(40),
                              fontWeight: FontWeight.bold),
                        ),
                        documentSnapshot['idFrom'] ==
                                FirebaseAuth.instance.currentUser.uid
                            ? TextButton(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  documentSnapshot.reference
                                      .delete()
                                      .whenComplete(
                                          () => Navigator.pop(context));
                                },
                              )
                            : Container(
                                width: 50,
                              )
                      ],
                    ),
                  ),
                  buildListPRely(
                    documentSnapshot: documentSnapshot,
                  ),
                  buildreply(
                    documentSnapshot: documentSnapshot,
                  ),
                ],
              ),
            ),
          );
        });
  }

  showcoments({DocumentSnapshot documentSnapshot}) {
    onview(documentSnapshot['timestamp']);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
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
            height: MediaQuery.of(context).size.height * .92,
            child: Padding(
              padding: EdgeInsets.only(
                  // bottom: MediaQuery.of(context).viewInsets.bottom

                  ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    // color: Colors.grey[200],
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          "Replies",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(40),
                              fontWeight: FontWeight.bold),
                        ),
                        documentSnapshot['idFrom'] ==
                                FirebaseAuth.instance.currentUser.uid
                            ? TextButton(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  documentSnapshot.reference
                                      .delete()
                                      .whenComplete(
                                          () => Navigator.pop(context));
                                },
                              )
                            : Container(
                                width: 50,
                              )
                      ],
                    ),
                  ),
                  buildListRely(
                    documentSnapshot: documentSnapshot,
                  ),
                  buildcomments(
                    documentSnapshot: documentSnapshot,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    var documentReference = FirebaseFirestore.instance
        .collection('groupChats')
        .doc(peerId)
        .collection(peerId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("post")
        .child(peerId)
        .child("video")
        .child("video" + ".mp4");
    UploadTask uploadTask = storageReference.putFile(videoFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((value) {
      documentReference.set({
        "video": value,
        'content': commentController.text,
        'idFrom': FirebaseAuth.instance.currentUser.uid,
        'idname': FirebaseAuth.instance.currentUser.displayName ?? '',
        "idphoto": FirebaseAuth.instance.currentUser.photoURL,
        'idTo': peerId,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': 1
      });
    });
  }

  Future uploadimage() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var documentReference = FirebaseFirestore.instance
          .collection('groupChats')
          .doc(peerId)
          .collection(peerId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("post")
          .child(peerId)
          .child("image")
          .child("image" + ".jpg");
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      storageTaskSnapshot.ref.getDownloadURL().then((value) {
        documentReference.set({
          "image": value,
          'content': commentController.text,
          'idFrom': FirebaseAuth.instance.currentUser.uid,
          'idname': FirebaseAuth.instance.currentUser.displayName ?? '',
          "idphoto": FirebaseAuth.instance.currentUser.photoURL,
          'idTo': peerId,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'type': 1
        }).whenComplete(() => commentController.clear());
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();
      var documentReference = FirebaseFirestore.instance
          .collection('groupChats')
          .doc(peerId)
          .collection(peerId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': FirebaseAuth.instance.currentUser.uid,
            'idname': FirebaseAuth.instance.currentUser.displayName ?? '',
            "idphoto": FirebaseAuth.instance.currentUser.photoURL,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      sendMessage(content, type);
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  void onSendreply(String content, int type, String id) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();
      var documentReference = FirebaseFirestore.instance
          .collection('groupChats')
          .doc(id)
          .collection('reply')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': FirebaseAuth.instance.currentUser.uid,
            'idname': FirebaseAuth.instance.currentUser.displayName ?? '',
            "idphoto": FirebaseAuth.instance.currentUser.photoURL,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      sendMessage(content, type);
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  void onview(String id) {
    var documentReference = FirebaseFirestore.instance
        .collection('groupChats')
        .doc(id)
        .collection('view')
        .doc(FirebaseAuth.instance.currentUser.uid.toString());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'idFrom': FirebaseAuth.instance.currentUser.uid,
          'idname': FirebaseAuth.instance.currentUser.displayName ?? '',
          "idphoto": FirebaseAuth.instance.currentUser.photoURL,
          'idTo': peerId,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );
    });
  }

  void sendMessage(String content, int type) async {
    //send message to each group member
    QuerySnapshot q = await FirebaseFirestore.instance
        .collection("generalGroups")
        .doc("${peerId}")
        .collection("members")
        .get();
    List<DocumentSnapshot> docs = q.docs;

    docs.forEach((element) {
      sendToGroup(
          content,
          type,
          FirebaseAuth.instance.currentUser.uid == element.id ? '' : element.id,
          FirebaseAuth.instance.currentUser.uid == element.id
              ? ''
              : element.data()['token']);
    });
  }

  void sendToGroup(
    var text,
    var content,
    var memberId,
    var token,
  ) {
    sendNotification(
        "${FirebaseAuth.instance.currentUser.uid} made a post on ${widget.peername}",
        widget.peername,
        memberId,
        token);
    FirebaseFirestore.instance
        .collection('groupChats')
        .doc("$peerId")
        .collection("members")
        .doc("$memberId")
        .collection("messages")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      'read': memberId == FirebaseAuth.instance.currentUser.uid ? true : false,
      'timestamp': FieldValue.serverTimestamp(),
    });

    if (FirebaseAuth.instance.currentUser.uid != memberId) {
      var peerChatActivity = FirebaseFirestore.instance
          .collection("usersgroupActivity")
          .doc('$memberId')
          .collection('activity')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      peerChatActivity.set({'type': 'group message'});
    }
  }

  void sendNotification(
      String content, String heading, String token, String userId) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "notification": {
        "body": content,
        "title": heading,
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        'type': 'group',
        'user_id': '${FirebaseAuth.instance.currentUser.uid}',
        'user_name': '${FirebaseAuth.instance.currentUser.displayName ?? ''}',
      },
      "to": '$token'
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAFHe5x28:APA91bGRWk-jLZKOeG_JHE4Ev8j2vLnNDWQJC95igthzVf4XICSivQ0TMq9i95CjBApQcMyzscCdtBpcObCHPN97usT1nC_SpLUaTZR1dHEYMNbNmNasH_DHMglh4TzJOMzj_Nnr9Shv'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth

      print('test ok push CFM');
    } else {
      print(' CFM error');
    }
  }

  Widget Arena(int index, DocumentSnapshot document) {
    return InkWell(
      onTap: () {
        showdetails(
          documentSnapshot: document,
        );
      },
      child: Container(
        child: document['type'] == 0
            // Text
            ? Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ReadMoreText('${document['content']}' ?? '',
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
                              DateFormat('dd MMM kk:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(document['timestamp']))),
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: Theme.of(context).accentColor,
                              size: 20,
                              semanticLabel:
                                  'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('groupChats')
                                    .doc(document['timestamp'].toString())
                                    .collection('reply')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData)
                                    return snapshot.data.docs.length > 0
                                        ? Row(
                                            children: [
                                              Text(snapshot.data.docs.length
                                                  .toString()),
                                            ],
                                          )
                                        : Text('0');
                                  else
                                    return SizedBox();
                                }),
                            SizedBox(
                              width: 25,
                            ),
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Theme.of(context).accentColor,
                              size: 20,
                              semanticLabel:
                                  'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('groupChats')
                                    .doc(document['timestamp'].toString())
                                    .collection('view')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData)
                                    return snapshot.data.docs.length > 0
                                        ? Row(
                                            children: [
                                              Text(snapshot.data.docs.length
                                                  .toString()),
                                            ],
                                          )
                                        : Text('0');
                                  else
                                    return SizedBox();
                                })
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: MediaQuery.of(context).size.width * .90,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              )
            : document['type'] == 1
                // Image
                ? Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .92,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
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
                                errorWidget: (context, url, error) => Material(
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
                                imageUrl: document['image'],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReadMoreText('${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(fontSize: 15)),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      DateFormat('dd MMM kk:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(
                                                  document['timestamp']))),
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      color: Theme.of(context).accentColor,
                                      size: 20,
                                      semanticLabel:
                                          'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('groupChats')
                                            .doc(document['timestamp']
                                                .toString())
                                            .collection('reply')
                                            .orderBy("timestamp",
                                                descending: true)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData)
                                            return snapshot.data.docs.length > 0
                                                ? Row(
                                                    children: [
                                                      Text(snapshot
                                                          .data.docs.length
                                                          .toString()),
                                                    ],
                                                  )
                                                : Text('0');
                                          else
                                            return SizedBox();
                                        }),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Theme.of(context).accentColor,
                                      size: 20,
                                      semanticLabel:
                                          'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('groupChats')
                                            .doc(document['timestamp']
                                                .toString())
                                            .collection('view')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData)
                                            return snapshot.data.docs.length > 0
                                                ? Row(
                                                    children: [
                                                      Text(snapshot
                                                          .data.docs.length
                                                          .toString()),
                                                    ],
                                                  )
                                                : Text('0');
                                          else
                                            return SizedBox();
                                        })
                                  ],
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
                  )
                // Sticker
                : Container(
                    child: new Image.asset(
                      'assets/images/${document['content']}.gif',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                    margin: EdgeInsets.only(
                        bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                        right: 10.0),
                  ),
      ),
    );
  }

  Widget buildreplies(int index, DocumentSnapshot document) {
    if (document['idFrom'] == FirebaseAuth.instance.currentUser.uid) {
      // Right (my message)
      deleteForMe(DocumentSnapshot documentSnapshot) {
        documentSnapshot.reference.delete();
      }

      return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Delete message?"),
                    actions: <Widget>[
                      // onTap: () {
                      //   showdetails(
                      //     documentSnapshot: document,
                      //   );
                      // },
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showcoments(
                            documentSnapshot: document,
                          );
                        },
                        child: Text("reply"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          document.reference.delete();
                          Navigator.pop(context);
                        },
                        child: Text("ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      )
                    ],
                  ));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              document['type'] == 0
                  // Text
                  ? Container(
                      child: Column(
                        children: [
                          Card(
                            elevation: 0.5,
                            color: Color(0xffAEEEC4),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.reply_outlined,
                                        color: Theme.of(context).accentColor,
                                        size: 20,
                                        semanticLabel:
                                            'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('groupChats')
                                              .doc(document['timestamp']
                                                  .toString())
                                              .collection('reply')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData)
                                              return snapshot.data.docs.length >
                                                      0
                                                  ? Row(
                                                      children: [
                                                        Text(snapshot
                                                            .data.docs.length
                                                            .toString()),
                                                      ],
                                                    )
                                                  : Text('0');
                                            else
                                              return SizedBox();
                                          }),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    DateFormat('dd MMM kk:mm').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(document['timestamp']))),
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                          right: 10.0),
                    )
                  : document['type'] == 1
                      // Image
                      ? Container(
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                              right: 10.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 0.5,
                                color: Color(0xffAEEEC4),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Material(
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Container(
                                            child: SpinKitThreeBounce(
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            // width: 200.0,
                                            // height: 200.0,
                                            padding: EdgeInsets.all(70.0),
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
                                          imageUrl: document['image'],
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: ReadMoreText(
                                            '${document['content']}' ?? '',
                                            trimLines: 10,
                                            colorClickableText: Colors.blue,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: '... Read more',
                                            trimExpandedText: '... Show less',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.reply_outlined,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 20,
                                            semanticLabel:
                                                'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('groupChats')
                                                  .doc(document['timestamp']
                                                      .toString())
                                                  .collection('reply')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData)
                                                  return snapshot.data.docs
                                                              .length >
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Text(snapshot.data
                                                                .docs.length
                                                                .toString()),
                                                          ],
                                                        )
                                                      : Text('0');
                                                else
                                                  return SizedBox();
                                              }),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        DateFormat('dd MMM kk:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    document['timestamp']))),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      // Sticker
                      : Container(
                          child: new Image.asset(
                            'assets/images/${document['content']}.gif',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
      );
    } else {
      // Left (peer message)
      return Column(
        children: [
          InkWell(
            onTap: () {
              showcoments(
                documentSnapshot: document,
              );
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: document['idphoto'] ?? '',
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  document['type'] == 0
                      // Text
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${document['idname']}',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.reply_outlined,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 20,
                                            semanticLabel:
                                                'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('groupChats')
                                                  .doc(document['timestamp']
                                                      .toString())
                                                  .collection('reply')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData)
                                                  return snapshot.data.docs
                                                              .length >
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Text(snapshot.data
                                                                .docs.length
                                                                .toString()),
                                                          ],
                                                        )
                                                      : Text('0');
                                                else
                                                  return SizedBox();
                                              }),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        DateFormat('dd MMM kk:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    document['timestamp']))),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: MediaQuery.of(context).size.width * .7,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        )
                      : document['type'] == 1
                          // Image
                          ? Container(
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Material(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: SpinKitThreeBounce(
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          width: 200.0,
                                          height: 200.0,
                                          padding: EdgeInsets.all(70.0),
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
                                        imageUrl: document['image'],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                        right: 10.0),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ReadMoreText(
                                        '${document['content']}' ?? '',
                                        trimLines: 10,
                                        colorClickableText: Colors.blue,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: '... Read more',
                                        trimExpandedText: '... Show less',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.reply_outlined,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                size: 20,
                                                semanticLabel:
                                                    'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('groupChats')
                                                      .doc(document['timestamp']
                                                          .toString())
                                                      .collection('reply')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData)
                                                      return snapshot.data.docs
                                                                  .length >
                                                              0
                                                          ? Row(
                                                              children: [
                                                                Text(snapshot
                                                                    .data
                                                                    .docs
                                                                    .length
                                                                    .toString()),
                                                              ],
                                                            )
                                                          : Text('0');
                                                    else
                                                      return SizedBox();
                                                  }),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            DateFormat('dd MMM kk:mm').format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        int.parse(document[
                                                            'timestamp']))),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 12.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          // Sticker
                          : Container(
                              child: new Image.asset(
                                'assets/images/${document['content']}.gif',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                            ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['idFrom'] == FirebaseAuth.instance.currentUser.uid) {
      // Right (my message)
      deleteForMe(DocumentSnapshot documentSnapshot) {
        documentSnapshot.reference.delete();
      }

      return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Delete message?"),
                    actions: <Widget>[
                      // onTap: () {
                      //   showdetails(
                      //     documentSnapshot: document,
                      //   );
                      // },
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //     // showcoments(
                      //     //   documentSnapshot: document,
                      //     // );
                      //   },
                      //   child: Text("reply"),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          document.reference.delete();
                          Navigator.pop(context);
                        },
                        child: Text("ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      )
                    ],
                  ));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              document['type'] == 0
                  // Text
                  ? Container(
                      child: Column(
                        children: [
                          Card(
                            elevation: 0.5,
                            color: Color(0xffAEEEC4),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Icon(
                                  //       Icons.reply_outlined,
                                  //       color: Theme.of(context).accentColor,
                                  //       size: 20,
                                  //       semanticLabel:
                                  //           'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     StreamBuilder(
                                  //         stream: FirebaseFirestore.instance
                                  //             .collection('groupChats')
                                  //             .doc(document['timestamp']
                                  //                 .toString())
                                  //             .collection('reply')
                                  //             .snapshots(),
                                  //         builder: (context, snapshot) {
                                  //           if (snapshot.hasData)
                                  //             return snapshot.data.docs.length >
                                  //                     0
                                  //                 ? Row(
                                  //                     children: [
                                  //                       Text(snapshot
                                  //                           .data.docs.length
                                  //                           .toString()),
                                  //                     ],
                                  //                   )
                                  //                 : Text('0');
                                  //           else
                                  //             return SizedBox();
                                  //         }),
                                  //   ],
                                  // ),
                                  Spacer(),
                                  Text(
                                    DateFormat('dd MMM kk:mm').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(document['timestamp']))),
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                          right: 10.0),
                    )
                  : document['type'] == 1
                      // Image
                      ? Container(
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                              right: 10.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 0.5,
                                color: Color(0xffAEEEC4),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Material(
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Container(
                                            child: SpinKitThreeBounce(
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            // width: 200.0,
                                            // height: 200.0,
                                            padding: EdgeInsets.all(70.0),
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
                                          imageUrl: document['image'],
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: ReadMoreText(
                                            '${document['content']}' ?? '',
                                            trimLines: 10,
                                            colorClickableText: Colors.blue,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: '... Read more',
                                            trimExpandedText: '... Show less',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(4.0),
                              //   child: Container(
                              //     alignment: Alignment.bottomRight,
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.end,
                              //       children: [
                              //         Row(
                              //           children: [
                              //             Icon(
                              //               Icons.reply_outlined,
                              //               color:
                              //                   Theme.of(context).accentColor,
                              //               size: 20,
                              //               semanticLabel:
                              //                   'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                              //             ),
                              //             SizedBox(
                              //               width: 5,
                              //             ),
                              //             StreamBuilder(
                              //                 stream: FirebaseFirestore.instance
                              //                     .collection('groupChats')
                              //                     .doc(document['timestamp']
                              //                         .toString())
                              //                     .collection('reply')
                              //                     .snapshots(),
                              //                 builder: (context, snapshot) {
                              //                   if (snapshot.hasData)
                              //                     return snapshot.data.docs
                              //                                 .length >
                              //                             0
                              //                         ? Row(
                              //                             children: [
                              //                               Text(snapshot.data
                              //                                   .docs.length
                              //                                   .toString()),
                              //                             ],
                              //                           )
                              //                         : Text('0');
                              //                   else
                              //                     return SizedBox();
                              //                 }),
                              //           ],
                              //         ),
                              //         Spacer(),
                              //         Text(
                              //           DateFormat('dd MMM kk:mm').format(
                              //               DateTime.fromMillisecondsSinceEpoch(
                              //                   int.parse(
                              //                       document['timestamp']))),
                              //           style: TextStyle(
                              //               color:
                              //                   Theme.of(context).accentColor,
                              //               fontSize: 12.0,
                              //               fontStyle: FontStyle.italic),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      // Sticker
                      : Container(
                          child: new Image.asset(
                            'assets/images/${document['content']}.gif',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
      );
    } else {
      // Left (peer message)
      return Column(
        children: [
          InkWell(
            // onTap: () {
            //   showcoments(
            //     documentSnapshot: document,
            //   );
            // },
            child: Container(
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: document['idphoto'] ?? '',
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  document['type'] == 0
                      // Text
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${document['idname']}',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     Icon(
                                      //       Icons.reply_outlined,
                                      //       color:
                                      //           Theme.of(context).accentColor,
                                      //       size: 20,
                                      //       semanticLabel:
                                      //           'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                      //     ),
                                      //     SizedBox(
                                      //       width: 5,
                                      //     ),
                                      //     StreamBuilder(
                                      //         stream: FirebaseFirestore.instance
                                      //             .collection('groupChats')
                                      //             .doc(document['timestamp']
                                      //                 .toString())
                                      //             .collection('reply')
                                      //             .snapshots(),
                                      //         builder: (context, snapshot) {
                                      //           if (snapshot.hasData)
                                      //             return snapshot.data.docs
                                      //                         .length >
                                      //                     0
                                      //                 ? Row(
                                      //                     children: [
                                      //                       Text(snapshot.data
                                      //                           .docs.length
                                      //                           .toString()),
                                      //                     ],
                                      //                   )
                                      //                 : Text('0');
                                      //           else
                                      //             return SizedBox();
                                      //         }),
                                      //   ],
                                      // ),
                                      Spacer(),
                                      Text(
                                        DateFormat('dd MMM kk:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    document['timestamp']))),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: MediaQuery.of(context).size.width * .7,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        )
                      : document['type'] == 1
                          // Image
                          ? Container(
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Material(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: SpinKitThreeBounce(
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          width: 200.0,
                                          height: 200.0,
                                          padding: EdgeInsets.all(70.0),
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
                                        imageUrl: document['image'],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                        right: 10.0),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ReadMoreText(
                                        '${document['content']}' ?? '',
                                        trimLines: 10,
                                        colorClickableText: Colors.blue,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: '... Read more',
                                        trimExpandedText: '... Show less',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.reply_outlined,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                size: 20,
                                                semanticLabel:
                                                    'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('groupChats')
                                                      .doc(document['timestamp']
                                                          .toString())
                                                      .collection('reply')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData)
                                                      return snapshot.data.docs
                                                                  .length >
                                                              0
                                                          ? Row(
                                                              children: [
                                                                Text(snapshot
                                                                    .data
                                                                    .docs
                                                                    .length
                                                                    .toString()),
                                                              ],
                                                            )
                                                          : Text('0');
                                                    else
                                                      return SizedBox();
                                                  }),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            DateFormat('dd MMM kk:mm').format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        int.parse(document[
                                                            'timestamp']))),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 12.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          // Sticker
                          : Container(
                              child: new Image.asset(
                                'assets/images/${document['content']}.gif',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                            ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget PrvatArena(int index, DocumentSnapshot document) {
    if (document['idFrom'] == FirebaseAuth.instance.currentUser.uid) {
      // Right (my message)
      deleteForMe(DocumentSnapshot documentSnapshot) {
        documentSnapshot.reference.delete();
      }

      return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Delete message?"),
                    actions: <Widget>[
                      // onTap: () {
                      //   showdetails(
                      //     documentSnapshot: document,
                      //   );
                      // },
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showdetails(
                            documentSnapshot: document,
                          );
                        },
                        child: Text("reply"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          document.reference.delete();
                          Navigator.pop(context);
                        },
                        child: Text("ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      )
                    ],
                  ));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              document['type'] == 0
                  // Text
                  ? Container(
                      child: Column(
                        children: [
                          Card(
                            elevation: 0.5,
                            color: Color(0xffAEEEC4),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.reply_outlined,
                                        color: Theme.of(context).accentColor,
                                        size: 20,
                                        semanticLabel:
                                            'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('groupChats')
                                              .doc(document['timestamp']
                                                  .toString())
                                              .collection('reply')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData)
                                              return snapshot.data.docs.length >
                                                      0
                                                  ? Row(
                                                      children: [
                                                        Text(snapshot
                                                            .data.docs.length
                                                            .toString()),
                                                      ],
                                                    )
                                                  : Text('0');
                                            else
                                              return SizedBox();
                                          }),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    DateFormat('dd MMM kk:mm').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(document['timestamp']))),
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                          right: 10.0),
                    )
                  : document['type'] == 1
                      // Image
                      ? Container(
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                              right: 10.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 0.5,
                                color: Color(0xffAEEEC4),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Material(
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Container(
                                            child: SpinKitThreeBounce(
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            // width: 200.0,
                                            // height: 200.0,
                                            padding: EdgeInsets.all(70.0),
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
                                          imageUrl: document['image'],
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: ReadMoreText(
                                            '${document['content']}' ?? '',
                                            trimLines: 10,
                                            colorClickableText: Colors.blue,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: '... Read more',
                                            trimExpandedText: '... Show less',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.reply_outlined,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 20,
                                            semanticLabel:
                                                'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('groupChats')
                                                  .doc(document['timestamp']
                                                      .toString())
                                                  .collection('reply')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData)
                                                  return snapshot.data.docs
                                                              .length >
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Text(snapshot.data
                                                                .docs.length
                                                                .toString()),
                                                          ],
                                                        )
                                                      : Text('0');
                                                else
                                                  return SizedBox();
                                              }),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        DateFormat('dd MMM kk:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    document['timestamp']))),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      // Sticker
                      : Container(
                          child: new Image.asset(
                            'assets/images/${document['content']}.gif',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
      );
    } else {
      // Left (peer message)
      return Column(
        children: [
          InkWell(
            onTap: () {
              showdetails(
                documentSnapshot: document,
              );
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: document['idphoto'] ?? '',
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  document['type'] == 0
                      // Text
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${document['idname']}',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.reply_outlined,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 20,
                                            semanticLabel:
                                                'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('groupChats')
                                                  .doc(document['timestamp']
                                                      .toString())
                                                  .collection('reply')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData)
                                                  return snapshot.data.docs
                                                              .length >
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Text(snapshot.data
                                                                .docs.length
                                                                .toString()),
                                                          ],
                                                        )
                                                      : Text('0');
                                                else
                                                  return SizedBox();
                                              }),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        DateFormat('dd MMM kk:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    document['timestamp']))),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: MediaQuery.of(context).size.width * .7,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        )
                      : document['type'] == 1
                          // Image
                          ? Container(
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Material(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: SpinKitThreeBounce(
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          width: 200.0,
                                          height: 200.0,
                                          padding: EdgeInsets.all(70.0),
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
                                        imageUrl: document['image'],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                        right: 10.0),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ReadMoreText(
                                        '${document['content']}' ?? '',
                                        trimLines: 10,
                                        colorClickableText: Colors.blue,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: '... Read more',
                                        trimExpandedText: '... Show less',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.reply_outlined,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                size: 20,
                                                semanticLabel:
                                                    'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('groupChats')
                                                      .doc(document['timestamp']
                                                          .toString())
                                                      .collection('reply')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData)
                                                      return snapshot.data.docs
                                                                  .length >
                                                              0
                                                          ? Row(
                                                              children: [
                                                                Text(snapshot
                                                                    .data
                                                                    .docs
                                                                    .length
                                                                    .toString()),
                                                              ],
                                                            )
                                                          : Text('0');
                                                    else
                                                      return SizedBox();
                                                  }),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            DateFormat('dd MMM kk:mm').format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        int.parse(document[
                                                            'timestamp']))),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 12.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          // Sticker
                          : Container(
                              child: new Image.asset(
                                'assets/images/${document['content']}.gif',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                            ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget PrvatArena2(int index, DocumentSnapshot document) {
    if (document['idFrom'] == FirebaseAuth.instance.currentUser.uid) {
      // Right (my message)
      deleteForMe(DocumentSnapshot documentSnapshot) {
        documentSnapshot.reference.delete();
      }

      return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Delete message?"),
                    actions: <Widget>[
                      // onTap: () {
                      //   showdetails(
                      //     documentSnapshot: document,
                      //   );
                      // },
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showcoments(
                            documentSnapshot: document,
                          );
                        },
                        child: Text("reply"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          document.reference.delete();
                          Navigator.pop(context);
                        },
                        child: Text("ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      )
                    ],
                  ));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              document['type'] == 0
                  // Text
                  ? Container(
                      child: Column(
                        children: [
                          Card(
                            elevation: 0.5,
                            color: Color(0xffAEEEC4),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.reply_outlined,
                                        color: Theme.of(context).accentColor,
                                        size: 20,
                                        semanticLabel:
                                            'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('groupChats')
                                              .doc(document['timestamp']
                                                  .toString())
                                              .collection('reply')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData)
                                              return snapshot.data.docs.length >
                                                      0
                                                  ? Row(
                                                      children: [
                                                        Text(snapshot
                                                            .data.docs.length
                                                            .toString()),
                                                      ],
                                                    )
                                                  : Text('0');
                                            else
                                              return SizedBox();
                                          }),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    DateFormat('dd MMM kk:mm').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(document['timestamp']))),
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                          right: 10.0),
                    )
                  : document['type'] == 1
                      // Image
                      ? Container(
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 5.0,
                              right: 10.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 0.5,
                                color: Color(0xffAEEEC4),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Material(
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Container(
                                            child: SpinKitThreeBounce(
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            // width: 200.0,
                                            // height: 200.0,
                                            padding: EdgeInsets.all(70.0),
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
                                          imageUrl: document['image'],
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: ReadMoreText(
                                            '${document['content']}' ?? '',
                                            trimLines: 10,
                                            colorClickableText: Colors.blue,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: '... Read more',
                                            trimExpandedText: '... Show less',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.reply_outlined,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 20,
                                            semanticLabel:
                                                'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('groupChats')
                                                  .doc(document['timestamp']
                                                      .toString())
                                                  .collection('reply')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData)
                                                  return snapshot.data.docs
                                                              .length >
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Text(snapshot.data
                                                                .docs.length
                                                                .toString()),
                                                          ],
                                                        )
                                                      : Text('0');
                                                else
                                                  return SizedBox();
                                              }),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        DateFormat('dd MMM kk:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    document['timestamp']))),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      // Sticker
                      : Container(
                          child: new Image.asset(
                            'assets/images/${document['content']}.gif',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
      );
    } else {
      // Left (peer message)
      return Column(
        children: [
          InkWell(
            onTap: () {
              showcoments(
                documentSnapshot: document,
              );
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: document['idphoto'] ?? '',
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  document['type'] == 0
                      // Text
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${document['idname']}',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: ReadMoreText(
                                    '${document['content']}' ?? '',
                                    trimLines: 10,
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '... Read more',
                                    trimExpandedText: '... Show less',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.reply_outlined,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 20,
                                            semanticLabel:
                                                'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('groupChats')
                                                  .doc(document['timestamp']
                                                      .toString())
                                                  .collection('reply')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData)
                                                  return snapshot.data.docs
                                                              .length >
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Text(snapshot.data
                                                                .docs.length
                                                                .toString()),
                                                          ],
                                                        )
                                                      : Text('0');
                                                else
                                                  return SizedBox();
                                              }),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        DateFormat('dd MMM kk:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    document['timestamp']))),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: MediaQuery.of(context).size.width * .7,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        )
                      : document['type'] == 1
                          // Image
                          ? Container(
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Material(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: SpinKitThreeBounce(
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          width: 200.0,
                                          height: 200.0,
                                          padding: EdgeInsets.all(70.0),
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
                                        imageUrl: document['image'],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: isLastMessageRight(index)
                                            ? 20.0
                                            : 10.0,
                                        right: 10.0),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ReadMoreText(
                                        '${document['content']}' ?? '',
                                        trimLines: 10,
                                        colorClickableText: Colors.blue,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: '... Read more',
                                        trimExpandedText: '... Show less',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.reply_outlined,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                size: 20,
                                                semanticLabel:
                                                    'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('groupChats')
                                                      .doc(document['timestamp']
                                                          .toString())
                                                      .collection('reply')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData)
                                                      return snapshot.data.docs
                                                                  .length >
                                                              0
                                                          ? Row(
                                                              children: [
                                                                Text(snapshot
                                                                    .data
                                                                    .docs
                                                                    .length
                                                                    .toString()),
                                                              ],
                                                            )
                                                          : Text('0');
                                                    else
                                                      return SizedBox();
                                                  }),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            DateFormat('dd MMM kk:mm').format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        int.parse(document[
                                                            'timestamp']))),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 12.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          // Sticker
                          : Container(
                              child: new Image.asset(
                                'assets/images/${document['content']}.gif',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                            ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        ],
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  void sendgenNotification(String content) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "notification": {
        "body": '$content',
        "title": 'Midnight prayers',
      },
      'topic': "notification",
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        'type': 'midnight_prayer',
      },
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAFHe5x28:APA91bGRWk-jLZKOeG_JHE4Ev8j2vLnNDWQJC95igthzVf4XICSivQ0TMq9i95CjBApQcMyzscCdtBpcObCHPN97usT1nC_SpLUaTZR1dHEYMNbNmNasH_DHMglh4TzJOMzj_Nnr9ShV'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth

      print('test ok push CFM');
    } else {
      print(' CFM error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
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
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of groupChats
                peerAvatar == 'private'
                    ? buildprivateListMessage()
                    : buildListMessage(),
                // Sticker
                (isShowSticker ? buildSticker() : Container()),
                // Input content
                peerAvatar == 'private' ? buildInputprivate() : buildInput(),
              ],
            ),
            // Loading
            buildLoading()
          ],
        ),
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => onSendMessage('mimi1', 2),
                child: new Image.asset(
                  'assets/images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi2', 2),
                child: new Image.asset(
                  'assets/images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi3', 2),
                child: new Image.asset(
                  'assets/images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => onSendMessage('mimi4', 2),
                child: new Image.asset(
                  'assets/images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi5', 2),
                child: new Image.asset(
                  'assets/images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi6', 2),
                child: new Image.asset(
                  'assets/images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => onSendMessage('mimi7', 2),
                child: new Image.asset(
                  'assets/images/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi8', 2),
                child: new Image.asset(
                  'assets/images/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi9', 2),
                child: new Image.asset(
                  'assets/images/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: SpinKitThreeBounce(
                  color: Colors.black,
                  size: 30,
                ),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return snapshot.data.docs.single["isAdmin"] == true
                ? Container(
                    child: Row(
                      children: <Widget>[
                        // Button send image
                        Material(
                          child: new Container(
                            margin: new EdgeInsets.symmetric(horizontal: 1.0),
                            child: new IconButton(
                              icon: new Icon(Icons.image),
                              onPressed: getImage,
                              color: Colors.black,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        // Edit text
                        Flexible(
                          child: Container(
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                              controller: textEditingController,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Type your message...',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              focusNode: focusNode,
                            ),
                          ),
                        ),

                        // Button send message
                        Material(
                          child: new Container(
                            margin: new EdgeInsets.symmetric(horizontal: 8.0),
                            child: new IconButton(
                              icon: new Icon(Icons.send),
                              onPressed: () {
                                onSendMessage(textEditingController.text, 0);
                                sendgenNotification(textEditingController.text);
                              },
                              color: Colors.black,
                            ),
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        border: new Border(
                            top:
                                new BorderSide(color: Colors.grey, width: 0.5)),
                        color: Colors.white),
                  )
                : SizedBox(
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
        });
  }

  Widget buildInputprivate() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: getImage,
                color: Colors.black,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: Colors.black,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildreply({DocumentSnapshot documentSnapshot}) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("user_id",
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data.docs.single["isAdmin"] == true
                    ? Container(
                        child: Row(
                          children: <Widget>[
                            // Button send image
                            Material(
                              child: new Container(
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 1.0),
                                child: new IconButton(
                                  icon: new Icon(Icons.image),
                                  onPressed: getImage,
                                  color: Colors.black,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            // Edit text
                            Flexible(
                              child: Container(
                                child: TextField(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  controller: textEditingController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Type your message...',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusNode: focusNode,
                                ),
                              ),
                            ),

                            // Button send message
                            Material(
                              child: new Container(
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 8.0),
                                child: new IconButton(
                                  icon: new Icon(Icons.send),
                                  onPressed: () => onSendreply(
                                      textEditingController.text,
                                      0,
                                      documentSnapshot['timestamp']),
                                  color: Colors.black,
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            border: new Border(
                                top: new BorderSide(
                                    color: Colors.grey, width: 0.5)),
                            color: Colors.white),
                      )
                    : SizedBox(
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
                return Text("");
              } else
                return Text("");
            })
      ],
    );
  }

  Widget buildcomments({DocumentSnapshot documentSnapshot}) {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: getImage,
                color: Colors.black,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendreply(textEditingController.text, 0,
                    documentSnapshot['timestamp']),
                color: Colors.black,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildprivateListMessage() {
    return Flexible(
      child: peerId == ''
          ? Center(
              child: SpinKitThreeBounce(
              color: Colors.black,
              size: 30,
            ))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groupChats')
                  .doc(peerId)
                  .collection(peerId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: SpinKitThreeBounce(
                    color: Colors.black,
                    size: 30,
                  ));
                } else {
                  listMessage = snapshot.data.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => peerAvatar == 'private'
                        ? PrvatArena2(index, snapshot.data.docs[index])
                        : Arena(index, snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: peerId == ''
          ? Center(
              child: SpinKitThreeBounce(
              color: Colors.black,
              size: 30,
            ))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groupChats')
                  .doc(peerId)
                  .collection(peerId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: SpinKitThreeBounce(
                    color: Colors.black,
                    size: 30,
                  ));
                } else {
                  listMessage = snapshot.data.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => peerAvatar == 'private'
                        ? PrvatArena(index, snapshot.data.docs[index])
                        : Arena(index, snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

  Widget buildListPRely({DocumentSnapshot documentSnapshot}) {
    return Flexible(
      child: peerId == ''
          ? Center(
              child: SpinKitThreeBounce(
              color: Colors.black,
              size: 30,
            ))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groupChats')
                  .doc(documentSnapshot['timestamp'].toString())
                  .collection('reply')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: SpinKitThreeBounce(
                    color: Colors.black,
                    size: 30,
                  ));
                } else {
                  listMessage = snapshot.data.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildreplies(index, snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

  Widget buildListRely({DocumentSnapshot documentSnapshot}) {
    return Flexible(
      child: peerId == ''
          ? Center(
              child: SpinKitThreeBounce(
              color: Colors.black,
              size: 30,
            ))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groupChats')
                  .doc(documentSnapshot['timestamp'].toString())
                  .collection('reply')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: SpinKitThreeBounce(
                    color: Colors.black,
                    size: 30,
                  ));
                } else {
                  listMessage = snapshot.data.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
}

class Notifications extends StatefulWidget {
  final String peerId;

  Notifications({
    Key key,
    @required this.peerId,
  }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> with FlushBarMixin {
  final ScrollController listScrollController = new ScrollController();
  bool loadingMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Pending Request",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Constant.mainColor,
        ),
        body: grouplist());
  }

  void next() async {
    showSuccessNotification(context, "Action competed");
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget grouplist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("generalGroups")
                  .doc("${widget.peerId}")
                  .collection("members")
                  .where('pending', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return NotificationListener(
                    onNotification: (ScrollEndNotification notification) {
                      if (notification is ScrollEndNotification &&
                          listScrollController.position.extentAfter == 0) {
                        print("end");
                        setState(() {
                          loadingMore = true;
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
                        String dataid = snapshot.data.docs[index].id;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.white.withOpacity(0.02),
                                            Constant.mainColor
                                                .withOpacity(0.02),
                                            Colors.white.withOpacity(0.02),
                                          ],
                                        )),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Column(
                                            children: [
                                              StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .where("user_id",
                                                          isEqualTo: dataid)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.data != null) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Center(
                                                              child:
                                                                  CircleAvatar(
                                                                maxRadius: 60,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        'https://www.vecteezy.com/vector-art/1546003-indian-woman-s-face-avatar'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: 'Name: ',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor),
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          "${snapshot.data.docs.single["user_name"]}",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: 'Email: ',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor),
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          "${snapshot.data.docs.single["user_email"]}",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'User ID: ',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor),
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          "${snapshot.data.docs.single["user_id"]}",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            AlertDialog(
                                                                              title: Text("Approved request?"),
                                                                              content: Text("Are you sure you want to approved request?"),
                                                                              actions: <Widget>[
                                                                                FlatButton(
                                                                                  onPressed: () async {
                                                                                    await FirebaseFirestore.instance.collection("generalGroups").doc("${widget.peerId}").collection("members").doc(snapshot.data.docs.single["user_id"]).update({
                                                                                      "pending": false,
                                                                                    });
                                                                                    await FirebaseFirestore.instance.collection("usersGeneralGroups").doc(snapshot.data.docs.single["user_id"]).collection("groups").doc("${widget.peerId}").update({
                                                                                      "pending": false
                                                                                    });
                                                                                    next();
                                                                                  },
                                                                                  child: Text("OK"),
                                                                                ),
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text("CANCEL"),
                                                                                )
                                                                              ],
                                                                            ));
                                                                  },
                                                                  child: Container(
                                                                      color: Colors.green,
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                10,
                                                                            horizontal:
                                                                                20),
                                                                        child:
                                                                            Text(
                                                                          'Approve',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      )),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            AlertDialog(
                                                                              title: Text("Decline request?"),
                                                                              content: Text("Are you sure you want to decline request?"),
                                                                              actions: <Widget>[
                                                                                FlatButton(
                                                                                  onPressed: () async {
                                                                                    await FirebaseFirestore.instance.collection("generalGroups").doc("${widget.peerId}").collection("members").doc(snapshot.data.docs.single["user_id"]).delete();
                                                                                    await FirebaseFirestore.instance.collection("usersGeneralGroups").doc(snapshot.data.docs.single["user_id"]).collection("groups").doc("${widget.peerId}").delete();
                                                                                    next();
                                                                                  },
                                                                                  child: Text("OK"),
                                                                                ),
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text("CANCEL"),
                                                                                )
                                                                              ],
                                                                            ));
                                                                  },
                                                                  child: Container(
                                                                      color: Colors.red,
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                10,
                                                                            horizontal:
                                                                                20),
                                                                        child:
                                                                            Text(
                                                                          'Decline',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else if (snapshot
                                                            .data.docs.length ==
                                                        0) {
                                                      return Text("No Members");
                                                    } else
                                                      return Text("No Members");
                                                  })
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
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
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (snapshot.data.docs.length == 0) {
                  return Text("No Pending request");
                } else
                  return Text("No Members");
              })
        ],
      ),
    );
  }

  void sendNotification(String content, String heading, String token,
      String userId, String username) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "notification": {
        "body": content,
        "title": heading,
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        'type': 'group',
        'user_id': '$userId',
        'user_name': '$username',
      },
      "to": '$token'
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAFHe5x28:APA91bGRWk-jLZKOeG_JHE4Ev8j2vLnNDWQJC95igthzVf4XICSivQ0TMq9i95CjBApQcMyzscCdtBpcObCHPN97usT1nC_SpLUaTZR1dHEYMNbNmNasH_DHMglh4TzJOMzj_Nnr9Shv'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth

      print('test ok push CFM');
    } else {
      print(' CFM error');
    }
  }
}
