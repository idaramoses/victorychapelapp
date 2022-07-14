import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Bookappointment extends StatefulWidget {
  @override
  _BookappointmentState createState() => _BookappointmentState();
}

class _BookappointmentState extends State<Bookappointment> {
  String age;
  String weight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BOOK AN APPOINTMENT"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'BOOK AND APPOINTMENT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Constant.mainColor, // set border color
                            width: 2.0), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'FULL NAME',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
                        color: Colors.white,
                        border: Border.all(
                            color: Constant.mainColor, // set border color
                            width: 2.0), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: TextField(
                        minLines: 5,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'REASON FOR APPOINTMENT',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
            ],
          ),
        ),
      ),
    );
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('appointment')
        .doc("appointment")
        .collection('appointment');
    var data = {
      'appointmenttitle': age,
      'appointmentcontent': weight,
      'appointmentlocation': "",
      'appointmentimage': FirebaseAuth.instance.currentUser.photoURL,
      'appointmentdate': "",
      'created': DateTime.now(),
    };
    ref.add(data);
    Navigator.pushReplacementNamed(context, "/home");
  }
}
