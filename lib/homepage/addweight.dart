import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add_weight extends StatefulWidget {
  @override
  _Add_weightState createState() => _Add_weightState();
}

class _Add_weightState extends State<Add_weight> {
  String age;
  String weight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'PLEASE INPUT YOUR WEIGHT AND HEIGHT',
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
            //
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
                          width: 3.0), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'HEIGHT (CM)',
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
                          width: 3.0), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'WEIGHT (KG)',
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
              height: 50.0,
            ),
            ElevatedButton(
              // padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
              onPressed: add,
              child: Text('ADD',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              // color: Constant.mainColor,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
            )
          ],
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc("12")
        .collection('message');

    var data = {
      'messagetitle': age,
      'messagecontent': weight,
      'messagelocation': "",
      'messageimage': "",
      'messagedate': "",
      'created': DateTime.now(),
    };
    ref.add(data);
    Navigator.pushReplacementNamed(context, "/home");
  }
}
