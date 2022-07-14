import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/group/new_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddGallery extends StatefulWidget {
  @override
  _AddGalleryState createState() => new _AddGalleryState();
}

class _AddGalleryState extends State<AddGallery> {
  List<Asset> images = List<Asset>();
  TextEditingController descriptionController = TextEditingController();
  File coverPhoto;
  bool isLoading = false;
  String category;
  String location;
  List<String> locationarray = [
    "town campus",
    "permanent campus",
    "ediene abak",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          backgroundColor: Constant.mainColor,
          elevation: 0,
          title: Text(
            "Add Photo",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                addGallery();
              },
              child: !isLoading
                  ? Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : CircularProgressIndicator(),
            )
          ],
        ),
        body: addBody());
  }

  Widget addBody() {
    return ListView(
      children: [
        Container(
          height: 55.0,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            // color: Colors.white,
            border: Border.all(color: Colors.white, width: 0.5),
          ),
          child: DropdownButtonFormField<String>(
            itemHeight: 52.0,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            hint: Text(location ?? "Select Location"),
            isExpanded: true,
            value: location,
            items: locationarray.map((dynamic value) {
              return DropdownMenuItem<String>(
                value: value,
                child: new Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "lato",
                    // color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                location = value;
              });
            },
          ),
        ),
        TextWidget(
          label: "Events",
          controller: descriptionController,
          textInputType: TextInputType.text,
        ),
        FlatButton(
          child: Row(
            children: [
              Icon(Icons.add_a_photo),
              SizedBox(
                width: 5,
              ),
              Text('Add cover photo')
            ],
          ),
          onPressed: loadCoverPhoto,
        ),
        coverPhoto == null
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Image.file(
                      coverPhoto,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
        FlatButton(
          child: Row(
            children: [
              Icon(Icons.image),
              SizedBox(
                width: 5,
              ),
              Text('Add images')
            ],
          ),
          onPressed: loadAssets,
        ),
        images == null || images.length == 0
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildGridView(),
              ),
      ],
    );
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        materialOptions: MaterialOptions(
            actionBarColor: "#000000", statusBarColor: "#000000"),
        maxImages: 30,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future loadCoverPhoto() async {
    var image = await ImagePicker.pickImage(
      maxWidth: 1200,
      maxHeight: 1200,
      source: ImageSource.gallery,
    );
    setState(() {
      coverPhoto = image;
    });
  }

  void addGallery() async {
    //get user info

    String userName = FirebaseAuth.instance.currentUser.displayName;
    String userId = FirebaseAuth.instance.currentUser.uid;
    String userEmail = FirebaseAuth.instance.currentUser.email;

    //upload images
    int count = 0;
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 12; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    var ref = FirebaseFirestore.instance.collection("gallery").doc(rndnumber);

    //upload cover photo
    if (coverPhoto != null && images.length > 0) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("gallery")
          .child(ref.id)
          .child("images")
          .child("cover_img" + ".jpg");
      UploadTask uploadTask = storageReference.putFile(coverPhoto);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      storageTaskSnapshot.ref.getDownloadURL().then((value) {
        ref.set({
          "description": descriptionController.text,
          "user_name": userName,
          "user_id": userId,
          "user_email": userEmail,
          "cover_image": value,
          'location': location,
          'photo_id': rndnumber,
          "timestamp": DateTime.now().millisecondsSinceEpoch
        });
      });
      for (int i = 0; i < images.length; i++) {
        count++;
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child("gallery")
            .child(ref.id)
            .child("images")
            .child("img_" + count.toString() + ".jpg");
        UploadTask uploadTask = storageReference
            .putData((await images[i].getByteData()).buffer.asUint8List());
        TaskSnapshot storageTaskSnapshot = await uploadTask;
        storageTaskSnapshot.ref.getDownloadURL().then((value) {
          ref.set({
            "description": descriptionController.text,
            "user_name": userName,
            "user_id": userId,
            "user_email": userEmail,
            'location': location,
            "images": FieldValue.arrayUnion([value]),
            'photo_id': rndnumber,
            "timestamp": DateTime.now().millisecondsSinceEpoch
          }, SetOptions(merge: true));
        });
      }
      startTime();
      Fluttertoast.showToast(msg: "photo uploaded");
    } else {
      Fluttertoast.showToast(
          msg: "select at least one photo and a cover photo");
      setState(() {
        isLoading = false;
      });
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }
}
