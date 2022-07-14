import 'dart:math';

import 'package:WeightApp/Message/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import 'MessageDetails.dart';
import 'audio.dart';
import 'download.dart';

class homemesage extends StatefulWidget {
  const homemesage({Key key}) : super(key: key);

  @override
  _homemesageState createState() => _homemesageState();
}

class _homemesageState extends State<homemesage> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String filter, preacher, month, location, pcode;
  String type;
  String mainpurpose, purpose;
  bool ispurpose = false;

  List<String> typearray = [
    "preacher",
    "month",
    "location",
  ];
  List<String> locationarray = [
    "town campus",
    "permanent campus",
    "ediene abak",
  ];
  List<String> preacherarray = [
    "Rev. (Dr) Iniobong F. Udoh",
    "Pst. Fadeyi David",
    "Pst. UbongAbasi Usoro",
    "Others"
  ];
  List<String> montharray = [
    "january",
    "february",
    "march",
    'april',
    "may",
    "june",
    "july",
    'august',
    'september',
    "october",
    'november',
    'december'
  ];

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (preacher != null) {
      filter = preacher;
    } else if (month != null) {
      filter = month;
    } else if (location != null) {
      filter = location;
    }
    if (preacher == 'Rev. (Dr) Iniobong F. Udoh') {
      pcode = '1';
    } else if (month == 'Pst. Fadeyi David') {
      pcode = '2';
    } else if (location == 'Pst. UbongAbasi Usoro') {
      pcode = '3';
    } else if (location == 'Others') {
      pcode = '4';
    }
    return Scaffold(
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
                    text: "Videos",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Tab(
                    text: "Audio",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Tab(
                    text: "Texts",
                  ),
                ),
              ]),
        ),
        ExpansionTile(
          title: Text(
            'Filter message',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            Container(
              height: 55.0,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                // color: Colors.white,
                border: Border.all(color: Constant.mainColor, width: 0.5),
              ),
              child: DropdownButtonFormField<String>(
                itemHeight: 52.0,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                hint: Text(type ?? "Select type"),
                isExpanded: true,
                value: type,
                items: typearray.map((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "lato",
                        // color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                },
              ),
            ),
            type == 'preacher'
                ? Container(
                    height: 55.0,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // color: Colors.white,
                      border: Border.all(color: Constant.mainColor, width: 0.5),
                    ),
                    child: DropdownButtonFormField<String>(
                      itemHeight: 52.0,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      hint: Text(preacher ?? "Select Preacher"),
                      isExpanded: true,
                      value: preacher,
                      items: preacherarray.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "lato",
                              // color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          preacher = value;
                        });
                      },
                    ),
                  )
                : Container(),
            type == 'month'
                ? Container(
                    height: 55.0,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // color: Colors.white,
                      border: Border.all(color: Constant.mainColor, width: 0.5),
                    ),
                    child: DropdownButtonFormField<String>(
                      itemHeight: 52.0,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      hint: Text(month ?? "Select Month"),
                      isExpanded: true,
                      value: month,
                      items: montharray.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "lato",
                              // color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          month = value;
                        });
                      },
                    ),
                  )
                : Container(),
            type == 'location'
                ? Container(
                    height: 55.0,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // color: Colors.white,
                      border: Border.all(color: Constant.mainColor, width: 0.5),
                    ),
                    child: DropdownButtonFormField<String>(
                      itemHeight: 52.0,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
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
                              fontFamily: "lato",
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
                  )
                : Container(),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Messge_video(
                  categori: pcode != null ? pcode : filter,
                  type: pcode != null ? 'p_code' : "message$type"),
              Messge_audio(
                  categori: pcode != null ? pcode : filter,
                  type: pcode != null ? 'p_code' : "message$type"),
              Messge_text(
                  categori: pcode != null ? pcode : filter,
                  type: pcode != null ? 'p_code' : "message$type")
            ],
          ),
        ),
      ],
    ));
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
                          "Filter Message",
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
                    height: 55.0,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // color: Colors.white,
                      border: Border.all(color: Constant.mainColor, width: 0.5),
                    ),
                    child: DropdownButtonFormField<String>(
                      itemHeight: 52.0,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      hint: Text(type ?? "Select Message type"),
                      isExpanded: true,
                      value: type,
                      items: typearray.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "lato",
                              // color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          type = value;
                        });
                      },
                    ),
                  ),
                  type == 'Preacher'
                      ? Container(
                          height: 55.0,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // color: Colors.white,
                            border: Border.all(
                                color: Constant.mainColor, width: 0.5),
                          ),
                          child: DropdownButtonFormField<String>(
                            itemHeight: 52.0,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            hint: Text(preacher ?? "Select Preacher"),
                            isExpanded: true,
                            value: preacher,
                            items: preacherarray.map((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "lato",
                                    // color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                preacher = value;
                              });
                            },
                          ),
                        )
                      : Container(),
                  type == 'Month'
                      ? Container(
                          height: 55.0,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // color: Colors.white,
                            border: Border.all(
                                color: Constant.mainColor, width: 0.5),
                          ),
                          child: DropdownButtonFormField<String>(
                            itemHeight: 52.0,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            hint: Text(month ?? "Select Month"),
                            isExpanded: true,
                            value: month,
                            items: montharray.map((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "lato",
                                    // color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                month = value;
                              });
                            },
                          ),
                        )
                      : Container(),
                  type == 'location'
                      ? Container(
                          height: 55.0,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // color: Colors.white,
                            border: Border.all(
                                color: Constant.mainColor, width: 0.5),
                          ),
                          child: DropdownButtonFormField<String>(
                            itemHeight: 52.0,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
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
                                    fontFamily: "lato",
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
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}

class MAinmesage extends StatefulWidget {
  const MAinmesage({Key key}) : super(key: key);

  @override
  _MAinmesageState createState() => _MAinmesageState();
}

class _MAinmesageState extends State<MAinmesage> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String filter, preacher, month, location, pcode;
  String type;
  String mainpurpose, purpose;
  bool ispurpose = false;

  List<String> typearray = [
    "preacher",
    "month",
    "location",
  ];
  List<String> locationarray = [
    "town campus",
    "permanent campus",
    "ediene abak",
  ];
  List<String> preacherarray = [
    "Rev. (Dr) Iniobong F. Udoh",
    "Pst. Fadeyi David",
    "Pst. UbongAbasi Usoro",
    "Others"
  ];
  List<String> montharray = [
    "january",
    "february",
    "march",
    'april',
    "may",
    "june",
    "july",
    'august',
    'september',
    "october",
    'november',
    'december'
  ];

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (preacher != null) {
      filter = preacher;
    } else if (month != null) {
      filter = month;
    } else if (location != null) {
      filter = location;
    }
    if (preacher == 'Rev. (Dr) Iniobong F. Udoh') {
      pcode = '1';
    } else if (month == 'Pst. Fadeyi David') {
      pcode = '2';
    } else if (location == 'Pst. UbongAbasi Usoro') {
      pcode = '3';
    } else if (location == 'Others') {
      pcode = '4';
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            "Message",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Constant.mainColor,
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
                        text: "Videos",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Tab(
                        text: "Audio",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Tab(
                        text: "Texts",
                      ),
                    ),
                  ]),
            ),
            ExpansionTile(
              title: Text(
                'Filter message',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                Container(
                  height: 55.0,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    // color: Colors.white,
                    border: Border.all(color: Constant.mainColor, width: 0.5),
                  ),
                  child: DropdownButtonFormField<String>(
                    itemHeight: 52.0,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    hint: Text(type ?? "Select type"),
                    isExpanded: true,
                    value: type,
                    items: typearray.map((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(
                          value,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "lato",
                            // color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                  ),
                ),
                type == 'preacher'
                    ? Container(
                        height: 55.0,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          // color: Colors.white,
                          border:
                              Border.all(color: Constant.mainColor, width: 0.5),
                        ),
                        child: DropdownButtonFormField<String>(
                          itemHeight: 52.0,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          hint: Text(preacher ?? "Select Preacher"),
                          isExpanded: true,
                          value: preacher,
                          items: preacherarray.map((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "lato",
                                  // color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              preacher = value;
                            });
                          },
                        ),
                      )
                    : Container(),
                type == 'month'
                    ? Container(
                        height: 55.0,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          // color: Colors.white,
                          border:
                              Border.all(color: Constant.mainColor, width: 0.5),
                        ),
                        child: DropdownButtonFormField<String>(
                          itemHeight: 52.0,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          hint: Text(month ?? "Select Month"),
                          isExpanded: true,
                          value: month,
                          items: montharray.map((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "lato",
                                  // color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              month = value;
                            });
                          },
                        ),
                      )
                    : Container(),
                type == 'location'
                    ? Container(
                        height: 55.0,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          // color: Colors.white,
                          border:
                              Border.all(color: Constant.mainColor, width: 0.5),
                        ),
                        child: DropdownButtonFormField<String>(
                          itemHeight: 52.0,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
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
                                  fontFamily: "lato",
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
                      )
                    : Container(),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Messge_video(
                      categori: pcode != null ? pcode : filter,
                      type: pcode != null ? 'p_code' : "message$type"),
                  Messge_audio(
                      categori: pcode != null ? pcode : filter,
                      type: pcode != null ? 'p_code' : "message$type"),
                  Messge_text(
                      categori: pcode != null ? pcode : filter,
                      type: pcode != null ? 'p_code' : "message$type")
                ],
              ),
            ),
          ],
        ));
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
                          "Filter Message",
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
                    height: 55.0,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // color: Colors.white,
                      border: Border.all(color: Constant.mainColor, width: 0.5),
                    ),
                    child: DropdownButtonFormField<String>(
                      itemHeight: 52.0,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      hint: Text(type ?? "Select Message type"),
                      isExpanded: true,
                      value: type,
                      items: typearray.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "lato",
                              // color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          type = value;
                        });
                      },
                    ),
                  ),
                  type == 'Preacher'
                      ? Container(
                          height: 55.0,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // color: Colors.white,
                            border: Border.all(
                                color: Constant.mainColor, width: 0.5),
                          ),
                          child: DropdownButtonFormField<String>(
                            itemHeight: 52.0,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            hint: Text(preacher ?? "Select Preacher"),
                            isExpanded: true,
                            value: preacher,
                            items: preacherarray.map((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "lato",
                                    // color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                preacher = value;
                              });
                            },
                          ),
                        )
                      : Container(),
                  type == 'Month'
                      ? Container(
                          height: 55.0,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // color: Colors.white,
                            border: Border.all(
                                color: Constant.mainColor, width: 0.5),
                          ),
                          child: DropdownButtonFormField<String>(
                            itemHeight: 52.0,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            hint: Text(month ?? "Select Month"),
                            isExpanded: true,
                            value: month,
                            items: montharray.map((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "lato",
                                    // color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                month = value;
                              });
                            },
                          ),
                        )
                      : Container(),
                  type == 'location'
                      ? Container(
                          height: 55.0,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // color: Colors.white,
                            border: Border.all(
                                color: Constant.mainColor, width: 0.5),
                          ),
                          child: DropdownButtonFormField<String>(
                            itemHeight: 52.0,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
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
                                    fontFamily: "lato",
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
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}

class Messge_text extends StatefulWidget {
  final String categori;
  final String type;

  Messge_text({
    Key key,
    @required this.categori,
    @required this.type,
  }) : super(key: key);
  @override
  _Messge_textState createState() => _Messge_textState();
}

class _Messge_textState extends State<Messge_text> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('message')
      .doc("message")
      .collection('text');

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
  int galleryCount = 10;
  bool loadingMore = false;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: const Text(
      //     "Message",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Constant.mainColor,
      // ),
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
          stream: widget.categori != null
              ? FirebaseFirestore.instance
                  .collection('message')
                  .doc("message")
                  .collection('text')
                  .where('${widget.type}', isEqualTo: widget.categori)
                  .orderBy("messagedate", descending: true)
                  .limit(galleryCount)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('message')
                  .doc("message")
                  .collection('text')
                  .orderBy("messagedate", descending: true)
                  .limit(galleryCount)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No Messages",
                    style: TextStyle(),
                  ),
                );
              }

              return Column(
                children: [
                  NotificationListener(
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
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          Random random = new Random();
                          Color bg = myColors[random.nextInt(4)];
                          Map data = snapshot.data.docs[index].data();
                          DateTime mydateTime = data['created'].toDate();
                          String formattedTime =
                              DateFormat.yMMMd().add_jm().format(mydateTime);
                          String messagetitle = "${data['messagetitle']}";
                          String preacher = "${data['messagepreacher']}";
                          String date = "${data['messagedate']}";
                          String campus = "${data['messagelocation']}";
                          String code = "${data['p_code']}";
                          String _name = '${data['messagetitle']}';
                          _name.length > 2 ? _name.substring(0, 2) : _name;
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => Messagedetails(
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: SizedBox(
                                height: 120,
                                child: Card(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: CircleAvatar(
                                            child: Text(
                                              _name.length > 2
                                                  ? _name.substring(0, 2)
                                                  : _name,
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            backgroundColor: bg,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              messagetitle,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              preacher,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  date.replaceAll(
                                                      '00:00:00.000', ''),
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                ),
                                                Text(
                                                  ' | ',
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                Text(
                                                  campus,
                                                  style: TextStyle(
                                                      fontSize: 12,
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      galleryCount += 5;
      loadingMore = false;
    });
  }
}

class Messge_audio extends StatefulWidget {
  final String categori;
  final String type;

  Messge_audio({
    Key key,
    @required this.categori,
    @required this.type,
  }) : super(key: key);
  @override
  _Messge_audioState createState() => _Messge_audioState();
}

class _Messge_audioState extends State<Messge_audio> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('message')
      .doc("message")
      .collection('audio');

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

  Future<void> savename(String arena) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('messagetitle', arena);
  }

  int galleryCount = 10;
  bool loadingMore = false;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: const Text(
      //     "Message",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Constant.mainColor,
      // ),
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
          stream: widget.categori != null
              ? FirebaseFirestore.instance
                  .collection('message')
                  .doc("message")
                  .collection('audio')
                  .where('${widget.type}', isEqualTo: widget.categori)
                  .orderBy("messagedate", descending: true)
                  .limit(galleryCount)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('message')
                  .doc("message")
                  .collection('audio')
                  .orderBy("messagedate", descending: true)
                  .limit(galleryCount)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "No Messages",
                    style: TextStyle(),
                  ),
                );
              }

              return Column(
                children: [
                  NotificationListener(
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
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          Random random = new Random();
                          Color bg = myColors[random.nextInt(4)];
                          Map data = snapshot.data.docs[index].data();
                          DateTime mydateTime = data['created'].toDate();
                          String formattedTime =
                              DateFormat.yMMMd().add_jm().format(mydateTime);
                          String messagetitle = "${data['messagetitle']}";
                          String preacher = "${data['messagepreacher']}";
                          String date = "${data['messagedate']}";
                          String campus = "${data['messagelocation']}";
                          String audio = "${data['messageurl']}";
                          String p_code = "${data['p_code']}";
                          String _name = '${data['messagetitle']}';
                          _name.length > 2 ? _name.substring(0, 2) : _name;
                          return InkWell(
                            onTap: () {
                              showBottom(
                                  topic: messagetitle,
                                  title: audio,
                                  preacher: preacher,
                                  campus: campus,
                                  date: date,
                                  platform: platform,
                                  p_code: p_code);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: SizedBox(
                                height: 120,
                                child: Card(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: CircleAvatar(
                                          child: Text(
                                            _name.length > 2
                                                ? _name.substring(0, 2)
                                                : _name,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          backgroundColor: bg,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messagetitle,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            preacher,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                date.replaceAll(
                                                    '00:00:00.000', ''),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                              Text(
                                                ' | ',
                                                style: TextStyle(fontSize: 11),
                                              ),
                                              Text(
                                                campus,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        // width: 50,
                                        child: Download_details(
                                            topic: messagetitle,
                                            title: audio,
                                            preacher: preacher,
                                            campus: campus,
                                            date: date,
                                            platform: platform,
                                            p_code: p_code),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      galleryCount += 5;
      loadingMore = false;
    });
  }

  showBottom(
      {String topic,
      String title,
      String preacher,
      String campus,
      String date,
      TargetPlatform platform,
      String p_code}) {
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
            height: MediaQuery.of(context).size.height * 0.80,
            child: Audio_Details(
                topic: topic,
                title: title,
                preacher: preacher,
                campus: campus,
                date: date,
                platform: platform,
                p_code: p_code),
          );
        });
  }
}
