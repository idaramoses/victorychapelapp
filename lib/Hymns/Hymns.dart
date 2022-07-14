import 'dart:math';

import 'package:WeightApp/Hymns/HymnsDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Constants.dart';

class hymns extends StatefulWidget {
  @override
  hymnsState createState() => hymnsState();
}

class hymnsState extends State<hymns> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('hymns')
      .doc("hymns")
      .collection('hymns');
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
          'Hymns',
          // style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Constant.mainColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hymns')
            .doc("hymns")
            .collection('hymns')
            .orderBy("order", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text(
                  "No hymns available",
                  style: TextStyle(
                      color: Constant.mainColor, fontWeight: FontWeight.bold),
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

                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => Hymnsdetails(
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
                        leading: CircleAvatar(
                          child: Text(
                            "${data['order']}",
                          ),
                          backgroundColor: bg,
                        ),
                        title: Text(
                          "${data['hymnstitle']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context)
                    //         .push(
                    //       MaterialPageRoute(
                    //         builder: (context) => Hymnsdetails(
                    //           data,
                    //           formattedTime,
                    //           snapshot.data.docs[index].reference,
                    //         ),
                    //       ),
                    //     )
                    //         .then((value) {
                    //       setState(() {});
                    //     });
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 5.0),
                    //     child: SizedBox(
                    //       height: 100,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(top: 10),
                    //         child: Card(
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 SizedBox(
                    //                   height: 5,
                    //                 ),
                    //                 Row(
                    //                   children: [
                    //                     Text(
                    //                       "${data['order']}",
                    //                       style: TextStyle(
                    //                         fontSize: 17.0,
                    //                         fontFamily: "lato",
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Colors.black87,
                    //                       ),
                    //                       maxLines: 3,
                    //                     ),
                    //                     SizedBox(
                    //                       width: 10,
                    //                     ),
                    //                     Text(
                    //                       "${data['hymnstitle']}",
                    //                       style: TextStyle(
                    //                         fontSize: 17.0,
                    //                         fontFamily: "lato",
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Colors.black87,
                    //                       ),
                    //                       maxLines: 3,
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10,
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
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
