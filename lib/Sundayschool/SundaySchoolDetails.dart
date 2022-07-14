import 'package:WeightApp/Bible/widgets/books_widget.dart';
import 'package:WeightApp/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class sundayschooldetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  sundayschooldetails(this.data, this.time, this.ref);

  @override
  _sundayschooldetailsState createState() => _sundayschooldetailsState();
}

class _sundayschooldetailsState extends State<sundayschooldetails> {
  String title;
  String content;
  String verse;
  String date;
  String discussion;
  String readingpassage;
  String conclusion;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool floatExtended = false;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    title = widget.data['sundayschooltitle'];
    content = widget.data['sundayschoolcontent'];
    date = widget.data['sundayschooldate'];
    discussion = widget.data['sundayschooldiscussion'];
    verse = widget.data['sundayschoolverse'];
    readingpassage = widget.data['sundayschoolreadingpassage'];
    conclusion = widget.data['sundayschoolconclusion'];
    return SafeArea(
      child: Scaffold(
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
        // floatingActionButton: FloatingActionButton.extended(
        //   tooltip: 'Create Card',
        //   label: Row(
        //     children: [
        //       IconButton(onPressed: () {}, icon: Icon(Icons.n)),
        //       IconButton(onPressed: () {}, icon: Icon(Icons.library_add_check)),
        //
        //       // Text('1'),
        //       // Text('2'),
        //       // Text('3'),
        //     ],
        //   ),
        //   isExtended: floatExtended,
        //   icon: Icon(
        //     floatExtended == true ? Icons.close : Icons.radio_button_on,
        //     color: floatExtended == true ? Colors.red : Theme.of(context).accentColor,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       floatExtended = !floatExtended;
        //     });
        //   },
        //   backgroundColor: floatExtended == true
        //       ? Colors.blueGrey
        //       : Colors.white.withOpacity(.7),
        // ),
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
                                      .doc('sundayschool')
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                        ),
                        child: Column(
                          children: [
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
                                  date,
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
                                  "Introduction:",
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(50),
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.w400,
                                    color: Constant.mainColor,
                                  ),
                                ),
                                Text(
                                  content,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(55),
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
                                  'Discussion:',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(50),
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.w400,
                                    color: Constant.mainColor,
                                  ),
                                ),
                                Text(
                                  discussion,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(55),
                                    fontFamily: "lato",
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
                                  'Conclusion:',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(50),
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.w400,
                                    color: Constant.mainColor,
                                  ),
                                ),
                                Text(
                                  conclusion,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(55),
                                    // fontFamily: "lato",
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //
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
