import 'dart:async';
import 'dart:io';

import 'package:WeightApp/Bible/widgets/books_widget.dart';
import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notepaddetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Notepaddetails(this.data, this.time, this.ref);

  @override
  _NotepaddetailsState createState() => _NotepaddetailsState();
}

class _NotepaddetailsState extends State<Notepaddetails> {
  String age;
  String Notepad;
  String preacher;
  String verse;
  String location;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();
    save();
  }

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

  @override
  Widget build(BuildContext context) {
    age = widget.data['notetitle'] ?? '';
    Notepad = widget.data['notecontent'] ?? "";
    preacher = widget.data['notepreacher'] ?? "";
    verse = widget.data['noteverse'] ?? "";
    location = widget.data['notelocation'] ?? "";
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              age,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      !edit
                          ? Fluttertoast.showToast(
                              msg: "Tap on text to edit note",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Constant.mainColor,
                              textColor: Colors.white,
                              fontSize: 16.0)
                          : Fluttertoast.showToast(
                                  msg: "Note edited successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Constant.mainColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0)
                              .whenComplete(() => save());
                      setState(() {
                        edit = !edit;
                      });
                    },
                    icon: Icon(
                      edit ? Icons.save : Icons.edit_outlined,
                      size: 24.0,
                      color: Colors.white,
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
                  //
                  SizedBox(
                    width: 8.0,
                  ),
                  //
                  IconButton(
                    onPressed: delete,
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 24.0,
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
                    //  ),
                    // ),
                  ),
                ],
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
            child: Container(
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    child: Text(
                      widget.time,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "lato",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Constant.mainColor,
                        semanticLabel:
                            'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                      ),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: "lato",
                          color: Constant.mainColor,
                        ),
                      ),
                      // TextFormField(
                      //   decoration: InputDecoration.collapsed(
                      //     hintText: "location",
                      //   ),
                      //   style: TextStyle(
                      //     fontSize: 17.0,
                      //     color: Colors.black,
                      //   ),
                      //   initialValue: widget.data['notelocation'],
                      //   enabled: edit,
                      //   onChanged: (_val) {
                      //     location = _val;
                      //   },
                      //   validator: (_val) {
                      //     if (_val.isEmpty) {
                      //       return "Can't be empty !";
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                  //
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Topic",
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        !edit
                            ? TextFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: "Topic",
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "lato",
                                  color: Theme.of(context).accentColor,
                                ),
                                initialValue: widget.data['notetitle'],
                                enabled: edit,
                                onChanged: (_val) {
                                  age = _val;
                                },
                                validator: (_val) {
                                  if (_val.isEmpty) {
                                    return "Can't be empty !";
                                  } else {
                                    return null;
                                  }
                                },
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Constant.mainColor
                                          .withOpacity(0.5), // set border color
                                      width: 0.5), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          5.0)), // set rounded corner radius
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Topic",
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                  ),
                                  initialValue: widget.data['notetitle'],
                                  enabled: edit,
                                  onChanged: (_val) {
                                    age = _val;
                                  },
                                  validator: (_val) {
                                    if (_val.isEmpty) {
                                      return "Can't be empty !";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Preacher",
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        !edit
                            ? TextFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: "Preacher",
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "lato",
                                  color: Theme.of(context).accentColor,
                                ),
                                initialValue: widget.data['notepreacher'],
                                enabled: edit,
                                onChanged: (_val) {
                                  preacher = _val;
                                },
                                validator: (_val) {
                                  if (_val.isEmpty) {
                                    return "Can't be empty !";
                                  } else {
                                    return null;
                                  }
                                },
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Constant.mainColor
                                          .withOpacity(0.5), // set border color
                                      width: 0.5), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          5.0)), // set rounded corner radius
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Preacher",
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                  ),
                                  initialValue: widget.data['notepreacher'],
                                  enabled: edit,
                                  onChanged: (_val) {
                                    preacher = _val;
                                  },
                                  validator: (_val) {
                                    if (_val.isEmpty) {
                                      return "Can't be empty !";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Reading verse",
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        !edit
                            ? TextFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: "Reading verse",
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "lato",
                                  color: Theme.of(context).accentColor,
                                ),
                                maxLines: 3,
                                initialValue: widget.data['noteverse'],
                                enabled: edit,
                                onChanged: (_val) {
                                  verse = _val;
                                },
                                validator: (_val) {
                                  if (_val.isEmpty) {
                                    return "Can't be empty !";
                                  } else {
                                    return null;
                                  }
                                },
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Constant.mainColor
                                          .withOpacity(0.5), // set border color
                                      width: 0.5), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          5.0)), // set rounded corner radius
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Reading verse",
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                  ),
                                  maxLines: 3,
                                  initialValue: widget.data['noteverse'],
                                  enabled: edit,
                                  onChanged: (_val) {
                                    verse = _val;
                                  },
                                  validator: (_val) {
                                    if (_val.isEmpty) {
                                      return "Can't be empty !";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                        //
                        SizedBox(
                          height: 12.0,
                        ),
                        //
                        Text(
                          'Note',
                          style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "lato",
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        !edit
                            ? TextFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: "Note",
                                ),
                                minLines: 5,
                                maxLines: 15,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "lato",
                                  color: Theme.of(context).accentColor,
                                ),
                                initialValue: widget.data['notecontent'],
                                enabled: edit,
                                onChanged: (_val) {
                                  Notepad = _val;
                                },
                                validator: (_val) {
                                  if (_val.isEmpty) {
                                    return "Can't be empty !";
                                  } else {
                                    return null;
                                  }
                                },
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Constant.mainColor
                                          .withOpacity(0.5), // set border color
                                      width: 0.5), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          5.0)), // set rounded corner radius
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Note",
                                  ),
                                  minLines: 5,
                                  maxLines: 15,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                  ),
                                  initialValue: widget.data['notecontent'],
                                  enabled: edit,
                                  onChanged: (_val) {
                                    Notepad = _val;
                                  },
                                  validator: (_val) {
                                    if (_val.isEmpty) {
                                      return "Can't be empty !";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    await widget.ref.update(
      {
        'notetitle': age,
        'notecontent': Notepad,
        'notepreacher': preacher,
        'noteverse': verse
      },
    );
    setState(() {
      age = age;
      Notepad = Notepad;
      preacher = preacher;
      verse = verse;
      location = location;
    });
    Navigator.of(context).pop();
  }
}
