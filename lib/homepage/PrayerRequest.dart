import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PrayerRequest extends StatefulWidget {
  @override
  _PrayerRequestState createState() => _PrayerRequestState();
}

class _PrayerRequestState extends State<PrayerRequest> {
  String age;
  String weight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Prayer Requests',
            // style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                add();
              },
              child: Text(
                'Send',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    'Send your prayer request us, we will remember you in prayer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      // color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.all(10),
                    //   padding: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     border: Border.all(
                    //         color: Constant.mainColor, // set border color
                    //         width: 1.0), // set border width
                    //     borderRadius: BorderRadius.all(
                    //         Radius.circular(10.0)), // set rounded corner radius
                    //   ),
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       hintText: 'FULL NAME',
                    //       border: InputBorder.none,
                    //     ),
                    //     style: TextStyle(
                    //       fontSize: 18.0,
                    //       fontFamily: "lato",
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //     ),
                    //     onChanged: (_val) {
                    //       age = _val;
                    //     },
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(
                            color: Constant.mainColor, // set border color
                            width: 1.0), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: TextField(
                        minLines: 15,
                        maxLines: 15,
                        decoration: InputDecoration(
                          hintText: 'PAYER REQUEST',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
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
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref =
        FirebaseFirestore.instance.collection('prayerrequest');

    var data = {
      'prayerrequestname': FirebaseAuth.instance.currentUser.displayName,
      'prayerrequestid': FirebaseAuth.instance.currentUser.uid,
      'prayerrequestcontent': weight,
      'prayerrequestimage': FirebaseAuth.instance.currentUser.photoURL,
      'created': DateTime.now(),
    };
    ref.add(data);
    Fluttertoast.showToast(
        msg: "Prayer request sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pop(context);
  }
}
