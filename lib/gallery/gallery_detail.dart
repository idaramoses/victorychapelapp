import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GalleryDetail extends StatefulWidget {
  final String id;

  const GalleryDetail({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _GalleryDetailState createState() => _GalleryDetailState();
}

class _GalleryDetailState extends State<GalleryDetail> {
  bool isReporting = false;
  int reportedPostId;
  String reportReason;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black54,
          body: _body(),
          bottomSheet: isReporting
              ? Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text("Reporting..."),
                  ),
                )
              : SizedBox.shrink()),
    );
  }

  Widget _body() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("gallery")
          .doc("${widget.id}")
          .snapshots(),
      builder: (context, snapshot) {
        String coverImage = snapshot.data['cover_image'];

        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Hero(
                  tag: "cover_${snapshot.data['photo_id']}",
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.black,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              child: Stack(
                                children: [
                                  Center(
                                    child: CachedNetworkImage(
                                      placeholder: (_, string) {
                                        return SpinKitThreeBounce(
                                          color: Colors.white,
                                          size: 30,
                                        );
                                      },
                                      imageUrl: coverImage,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        '${snapshot.data["description"]}',
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: CachedNetworkImage(
                      imageUrl: coverImage,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data['images'].length,
                itemBuilder: (context, index) {
                  String image = snapshot.data['images'][index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.black,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: CachedNetworkImage(
                                        placeholder: (_, string) {
                                          return SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 30,
                                          );
                                        },
                                        imageUrl: image,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          '${snapshot.data["description"]}',
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: CachedNetworkImage(
                        placeholder: (_, string) {
                          return Container(
                            height: 500,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        imageUrl: image,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          );
      },
    );
  }

  showReportDialog(int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
          height: 200,
          width: 200,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                  child: Text(
                "Why are you reporting this post?",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 10),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      reportReason = "Its spam";
                      reportedPostId = postId;
                    });
                    Navigator.pop(context);
                    reportPost();
                  },
                  child: Text("Its spam")),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      reportReason = "Its inappropriate";
                      reportedPostId = postId;
                    });
                    Navigator.pop(context);
                    reportPost();
                  },
                  child: Text("Its inappropriate")),
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
            ],
          ),
        ));
      },
    );
  }

  void reportPost() async {}
}
