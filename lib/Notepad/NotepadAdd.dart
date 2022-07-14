import 'package:WeightApp/Bible/widgets/books_widget.dart';
import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants.dart';

class NotepadAdd extends StatefulWidget {
  @override
  _NotepadAddState createState() => _NotepadAddState();
}

class _NotepadAddState extends State<NotepadAdd> {
  String age;
  String weight;
  String location;
  String messagetype;
  String preacher;
  String readingverse;
  List<String> locationarray = [
    "Main campus",
    "Permanent campus",
    "Edinebak",
  ];
  Future<bool> _onBackPressed() {
    if (age == null &&
        weight == null &&
        location == null &&
        preacher == null &&
        readingverse == null) {
      Navigator.pop(context);
    } else {
      add();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "Notepad",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  add();
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.all(
                //     Constant.mainColor,
                //   ),
                //   padding: MaterialStateProperty.all(
                //     EdgeInsets.symmetric(
                //       horizontal: 15.0,
                //       vertical: 8.0,
                //     ),
                //   ),
                // ),
              ),
            ],
            // backgroundColor: Constant.mainColor,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // when clicked on floating action button prompt to create user
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => OpenBible(),
                ),
              );
            },
            label: Text('Open Bible'),
            backgroundColor: Constant.mainColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                //
                Form(
                  child: Column(
                    children: [
                      Container(
                        height: 55.0,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Theme.of(context).backgroundColor,
                          border:
                              Border.all(color: Constant.mainColor, width: 0.5),
                        ),
                        child: DropdownButtonFormField<String>(
                          itemHeight: 52.0,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          hint: Text(location ?? "Select Location"),
                          isExpanded: true,
                          value: location,
                          items: locationarray.map((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  // fontFamily: "lato",
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              color: Constant.mainColor, // set border color
                              width: 0.5), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Topic',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            fontWeight: FontWeight.w600,
                            // color: Colors.black,
                          ),
                          onChanged: (_val) {
                            age = _val;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              color: Constant.mainColor, // set border color
                              width: 0.5), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Preacher',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            // fontWeight: FontWeight.bold,
                            // color: Colors.black,
                          ),
                          onChanged: (_val) {
                            preacher = _val;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              color: Constant.mainColor, // set border color
                              width: 0.5), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Reading Verses',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            // fontWeight: FontWeight.bold,
                            // color: Colors.black,
                          ),
                          onChanged: (_val) {
                            readingverse = _val;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              color: Constant.mainColor, // set border color
                              width: 0.5), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          minLines: 5,
                          maxLines: 15,
                          decoration: InputDecoration(
                            hintText: 'Note',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            // fontWeight: FontWeight.bold,
                            // color: Colors.black,
                          ),
                          onChanged: (_val) {
                            weight = _val;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('notepad')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection(FirebaseAuth.instance.currentUser.uid);
    Fluttertoast.showToast(
        msg: "Note added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Constant.mainColor,
        textColor: Colors.white,
        fontSize: 16.0);
    var data = {
      'notetitle': age,
      'notecontent': weight,
      'notelocation': location,
      'notepreacher': preacher,
      'noteverse': readingverse,
      'created': DateTime.now(),
    };
    ref.add(data);
    Navigator.pushReplacementNamed(context, "/notepad");
  }
}
