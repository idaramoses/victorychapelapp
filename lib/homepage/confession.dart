import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants.dart';

class Confession extends StatefulWidget {
  const Confession({Key key}) : super(key: key);

  @override
  _ConfessionState createState() => _ConfessionState();
}

class _ConfessionState extends State<Confession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("confession")
          .doc("confessions")
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    direction: ShimmerDirection.ltr,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .25,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          default:
            if (snapshot.hasError)
              return Center(child: Text('Error in connections'));
            else if (!snapshot.hasData)
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      direction: ShimmerDirection.ltr,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            else
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.height * .25,
                    flexibleSpace: Container(
                      child: FlexibleSpaceBar(
                        background: Container(
                          height: 200,
                          child: Stack(
                            children: [
                              Container(
                                  // height: 450,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: '${snapshot.data["photo"]}' ==
                                                null
                                            ? AssetImage(
                                                "assets/images/cube.png",
                                              )
                                            : NetworkImage(
                                                '${snapshot.data["photo"]}')),
                                  )),
                              Container(
                                // height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Constant.mainColor.withOpacity(0.5),
                                    Constant.mainColor.withOpacity(0.7),
                                    // Colors.white,
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      // FutureBuilder(
                      //     future: _getGroupDetails(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasData) {
                      //         DocumentSnapshot groupDetails = snapshot.data;
                      //
                      //         return (groupDetails["createdUserId"] ==
                      //             context.read<AuthProvider>().userInfo.id)
                      //             ? FlatButton(
                      //             onPressed: () {
                      //               Navigator.of(context).push(
                      //                   MaterialPageRoute(builder: (context) {
                      //                     return NewGroup(
                      //                       isEdit: true,
                      //                       groupDetails: groupDetails,
                      //                     );
                      //                   }));
                      //             },
                      //             child: Text(
                      //               "EDIT",
                      //               style: TextStyle(
                      //                 color: Colors.white,
                      //               ),
                      //             ))
                      //             : SizedBox();
                      //       } else
                      //         return SizedBox();
                      //     })
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((
                      context,
                      index,
                    ) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    '${snapshot.data["title"]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Divider(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        '${snapshot.data["content"]}',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }, childCount: 1),
                  )
                ],
              );
        }
      },
    ));
  }
}
