import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../Constants.dart';

class Messagedetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Messagedetails(this.data, this.time, this.ref);

  @override
  _MessagedetailsState createState() => _MessagedetailsState();
}

class _MessagedetailsState extends State<Messagedetails> {
  String title;
  String content;
  String location;
  String image;
  String date;
  String preacher;
  String readingpassage;
  String audio;
  String prayer;
  String p_code;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    title = widget.data['messagetitle'];
    content = widget.data['messagecontent'];
    location = widget.data['messagelocation'];
    date = widget.data['messagedate'];
    preacher = widget.data['messagepreacher'];
    image = widget.data['messageimage'];
    audio = widget.data['messageaudio'];
    readingpassage = widget.data['messagereadingpassage'];
    prayer = widget.data['messageprayer'];
    p_code = widget.data['p_code'];
    return SafeArea(
      child: Scaffold(
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
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 300,
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
                        color: Theme.of(context).accentColor,
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
                                        .doc('$p_code')
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
                                                  color: Colors.black,
                                                  // height: 300,
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
                                                    fit: BoxFit.fitHeight,
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
                                        Colors.black.withOpacity(0.5),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                title: Text(
                                  preacher,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(51),
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                subtitle: Text(
                                  location,
                                  style: TextStyle(
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                trailing: Text(
                                  date.replaceAll('00:00:00.000', ''),
                                  style: TextStyle(
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Reading Passage:",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(55),
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.w500,
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
                                content,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(55),
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Prayers:",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(55),
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.w400,
                                  color: Constant.mainColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                prayer.toString(),
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(55),
                                    fontFamily: "lato",
                                    color: Theme.of(context).accentColor,
                                    fontStyle: FontStyle.italic),
                              ),
                              // Text(
                              //   "Prayers:",
                              //   style: TextStyle(
                              //     fontSize: 17.0,
                              //     fontFamily: "lato",
                              //     fontWeight: FontWeight.bold,
                              //     color: Theme.of(context).accentColor,
                              //   ),
                              // ),
                              // Text(
                              //   prayer,
                              //   style: TextStyle(
                              //     fontSize: 15.0,
                              //     fontStyle: FontStyle.italic,
                              //     color: Theme.of(context).accentColor,
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
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
      ),
    );
  }
}
