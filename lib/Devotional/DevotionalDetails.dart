import 'package:WeightApp/Bible/widgets/books_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../Constants.dart';

class devotionaldetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  devotionaldetails(this.data, this.time, this.ref);

  @override
  _devotionaldetailsState createState() => _devotionaldetailsState();
}

class _devotionaldetailsState extends State<devotionaldetails> {
  String title;
  String content;
  String verse;
  String date;
  String prayer;
  String readingpassage;
  String oneyearplan;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    title = widget.data['devotionaltitle'];
    content = widget.data['devotionalcontent'];
    date = widget.data['devotionaldate'];
    prayer = widget.data['devotionalprayer'];
    verse = widget.data['devotionalverse'];
    readingpassage = widget.data['devotionalreadingpassage'];
    oneyearplan = widget.data['devotionalreadingplan'];
    return SafeArea(
      child: Scaffold(
        //
        // appBar: AppBar(
        //   iconTheme: IconThemeData(color: Colors.white),
        //   title: Text(
        //     title,
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: Constant.mainColor,
        // ),
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              leading: Text(''),

              flexibleSpace: Container(
                child: FlexibleSpaceBar(
                    title: Text(
                      "$title",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    titlePadding: const EdgeInsetsDirectional.only(
                        start: 16.0, bottom: 16.0),
                    centerTitle: false,
                    background: Container(
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        child: Container(
                          color: Color(0xFF212121),
                          child: Center(
                            child: Stack(
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('pictures')
                                      .doc('devotional')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return const Text("Loading...");
                                    else
                                      return Container(
                                        child: Column(
                                          children: <Widget>[
                                            Center(
                                              child: Container(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                height: 200,
                                                width: double.infinity,
                                                child: CachedNetworkImage(
                                                  placeholder: (context, s) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.grey,
                                                      ),
                                                    );
                                                  },
                                                  imageUrl:
                                                      snapshot.data["url"],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                  },
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.white.withOpacity(0.02),
                                      Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.5),
                                    ],
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              //
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((
                context,
                index,
              ) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.calendar,
                            color: Constant.mainColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            date.replaceAll('00:00:00.000', ''),
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(55),
                              fontFamily: "lato",
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              verse,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(55),
                                fontFamily: "lato",
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context).accentColor,
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
                          Text(
                            content,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(53),
                              // fontFamily: "lato",
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Prayer",
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                              fontFamily: "lato",
                              fontWeight: FontWeight.w400,
                              color: Constant.mainColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            prayer,
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(55),
                                fontFamily: "lato",
                                color: Theme.of(context).accentColor,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
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
                      Text(
                        "Reading Passage:",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(50),
                          fontFamily: "lato",
                          fontWeight: FontWeight.w400,
                          color: Constant.mainColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        readingpassage.toString(),
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(55),
                            fontFamily: "lato",
                            color: Theme.of(context).accentColor,
                            fontStyle: FontStyle.italic),
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
                      Text(
                        "One Year Reading Plan:",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(50),
                          fontFamily: "lato",
                          fontWeight: FontWeight.w400,
                          color: Constant.mainColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        oneyearplan.toString(),
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(55),
                            fontFamily: "lato",
                            color: Theme.of(context).accentColor,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                );
              }, childCount: 1),
            )
          ],
        ),
      ),
    );
  }
}
