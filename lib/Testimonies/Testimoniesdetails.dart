import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Testimoniesdetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Testimoniesdetails(this.data, this.time, this.ref);

  @override
  _TestimoniesdetailsState createState() => _TestimoniesdetailsState();
}

class _TestimoniesdetailsState extends State<Testimoniesdetails> {
  String title;
  String content;
  String location;
  String image;
  String date;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data['Testimoniestitle'];
    content = widget.data['Testimoniescontent'];
    location = widget.data['Testimonieslocation'];
    date = widget.data['Testimoniesdate'];
    image = widget.data['Testimoniesimage'];
    return SafeArea(
      child: Scaffold(
        //
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            title,
            // style: TextStyle(color: Colors.white),
          ),
          // backgroundColor: Constant.mainColor,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Constant.mainColor,
          child: Icon(
            Icons.play_arrow,
          ),
        ),
        resizeToAvoidBottomInset: false,
        //
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              10.0,
            ),
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
                      Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
