import 'dart:math';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/Testimonies/Testimoniesdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Testimonies extends StatefulWidget {
  @override
  _TestimoniesState createState() => _TestimoniesState();
}

class _TestimoniesState extends State<Testimonies> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc("12")
      .collection('Testimonies');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Testimonies",
          // style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Constant.mainColor,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text(
                  "No Testimoniess",
                  style: TextStyle(
                    color: Constant.mainColor,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(4)];
                Map data = snapshot.data.docs[index].data();
                DateTime mydateTime = data['created'].toDate();
                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => Testimoniesdetails(
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
                  child: SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage("${data['Testimoniesimage']}"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${data['Testimoniestitle']}",
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: "lato",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Text(
                                                  "${data['Testimonieslocation']}",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: "lato",
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "${data['Testimoniesdate']}",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily: "lato",
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: IconButton(
                                                iconSize: 40,
                                                icon: Icon(
                                                  Icons.play_circle_fill,
                                                  color: Constant.mainColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}
