import 'dart:io';

import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/utils/flushbar_mixin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewGroup extends StatefulWidget {
  final bool isEdit;
  final DocumentSnapshot groupDetails;

  const NewGroup({Key key, this.isEdit = false, this.groupDetails})
      : super(key: key);

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> with FlushBarMixin {
  final _groupNameController = TextEditingController();
  final _groupDescriptionController = TextEditingController();
  File image;
  bool isLoading = false;
  String token;
  String _photo;
  String userPhoto;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser.uid}')
        .get()
        .then((value) {
      setState(() {
        token = value.data()['token'].toString() ?? '';
        userPhoto = value.data()['profilepicture'].toString() ?? '';
      });
    });
    if (widget.isEdit) {
      _groupNameController.text = widget.groupDetails["name"];
      _groupDescriptionController.text = widget.groupDetails["description"];
      _photo = widget.groupDetails["photo"];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.isEdit ? "Edit Group" : "New Group",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          isLoading
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()),
                ))
              : FlatButton(
                  child: Text(
                    widget.isEdit ? "Edit" : "Create",
                    style: TextStyle(
                      color: Constant.mainColor,
                    ),
                  ),
                  onPressed: () {
                    if (widget.isEdit)
                      _editGroup();
                    else
                      _createGroup();
                  }),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _photo != null
                      ? NetworkImage(_photo)
                      : image == null
                          ? AssetImage(
                              "assets/images/cube.png",
                            )
                          : FileImage(this.image),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 50,
              child: OutlineButton(
                onPressed: () async {
                  var image = await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                  );
                  setState(() {
                    this.image = image;
                  });
                },
                color: Constant.mainColor,
                child: Text(
                  "Upload group photo",
                  style: TextStyle(
                    color: Constant.mainColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: TextWidget(
              controller: _groupNameController,
              textInputType: TextInputType.text,
              label: "Group Name",
            ),
          ),
          Center(
            child: TextWidget(
              controller: _groupDescriptionController,
              textInputType: TextInputType.text,
              label: "Group Description",
            ),
          ),
        ],
      ),
    );
  }

  void _createGroup() async {
    if (_groupNameController.text.isEmpty) {
      showErrorNotification(context, "Enter group name");
      return;
    }
    if (_groupDescriptionController.text.isEmpty) {
      showErrorNotification(context, "Enter group description");
      return;
    }
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        if (image != null) {
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child("generalGroupImages")
              .child("$timestamp")
              .child("images")
              .child("img_" + timestamp.toString() + ".jpg");
          UploadTask uploadTask = storageReference.putFile(image);
          TaskSnapshot storageTaskSnapshot = await uploadTask;
          storageTaskSnapshot.ref.getDownloadURL().then((value) async {
            String downloadUrl = value;
            var ref = FirebaseFirestore.instance
                .collection("generalGroups")
                .doc(timestamp);
            Map<String, dynamic> credentials = {
              "name": _groupNameController.text,
              "description": _groupDescriptionController.text,
              "photo": downloadUrl,
              "year": DateTime.now().year,
              'approved': false,
              "createdUserId": FirebaseAuth.instance.currentUser.uid
            };
            ref.set(credentials).then((value) async {
              await FirebaseFirestore.instance
                  .collection("generalGroups")
                  .doc(timestamp)
                  .collection("members")
                  .doc(FirebaseAuth.instance.currentUser.uid.toString())
                  .set({
                'name': FirebaseAuth.instance.currentUser.displayName,
                "photo": userPhoto,
                'pending': false,
                "isAdmin": true,
                "profession": FirebaseAuth.instance.currentUser.displayName,
                'token': token,
              });
              await FirebaseFirestore.instance
                  .collection("usersGeneralGroups")
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection("groups")
                  .doc(ref.id)
                  .set({
                "userId": FirebaseAuth.instance.currentUser.uid,
                "isAdmin": true,
                'pending': false,
                "joined": DateTime.now(),
                "name": _groupNameController.text,
                "description": _groupDescriptionController.text,
                "photo": downloadUrl
              });
              // next(int.parse(timestamp));
              showSuccessNotification(context, "Added new group");
            }).catchError((e) => print(e));
          }, onError: (err) {
            print(err);
          });
        } else {
          var ref = FirebaseFirestore.instance
              .collection("generalGroups")
              .doc(timestamp);
          Map<String, dynamic> credentials = {
            "name": _groupNameController.text,
            "description": _groupDescriptionController.text,
            "photo": "",
            'approved': false,
            "year": DateTime.now().year,
            "createdUserId": FirebaseAuth.instance.currentUser.uid
          };
          ref.set(credentials).then((value) async {
            await FirebaseFirestore.instance
                .collection("generalGroups")
                .doc(timestamp)
                .collection("members")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .set({
              'name': FirebaseAuth.instance.currentUser.displayName,
              "photo": userPhoto,
              'pending': false,
              "profession": FirebaseAuth.instance.currentUser.displayName,
              'token': token,
            });
            await FirebaseFirestore.instance
                .collection("usersGeneralGroups")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection("groups")
                .doc(ref.id)
                .set({
              "userId": FirebaseAuth.instance.currentUser.uid,
              "isAdmin": true,
              'pending': false,
              "joined": DateTime.now(),
              "name": _groupNameController.text,
              "description": _groupDescriptionController.text,
              "photo": ""
            });
            showSuccessNotification(context, "Added new group");
          }).catchError((e) => print(e));
        }
      } catch (e) {
        print(e);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void _editGroup() async {
    if (_groupNameController.text.isEmpty) {
      showErrorNotification(context, "Enter group name");
      return;
    }
    if (_groupDescriptionController.text.isEmpty) {
      showErrorNotification(context, "Enter group description");
      return;
    }
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        String timestamp = widget.groupDetails.id;
        if (image != null) {
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child("generalGroupImages")
              .child("$timestamp")
              .child("images")
              .child("img_" + timestamp.toString() + ".jpg");
          UploadTask uploadTask = storageReference.putFile(image);
          TaskSnapshot storageTaskSnapshot = await uploadTask;
          storageTaskSnapshot.ref.getDownloadURL().then((value) async {
            String downloadUrl = value;
            var ref = FirebaseFirestore.instance
                .collection("generalGroups")
                .doc(timestamp);
            Map<String, dynamic> credentials = {
              "name": _groupNameController.text,
              "description": _groupDescriptionController.text,
              "photo": downloadUrl,
              // "year": DateTime.now().year,
              // "createdUserId": context.read<AuthProvider>().userInfo.id
            };
            ref.update(credentials).then((value) async {
              // await FirebaseFirestore.instance
              //     .collection("generalGroups")
              //     .document(timestamp)
              //     .collection("members")
              //     .document(context.read<AuthProvider>().userInfo.id.toString())
              //     .setData({
              //   'name': context.read<AuthProvider>().userInfo.name,
              //   "photo": context.read<AuthProvider>().userInfo.photo,
              //   "profession": context.read<AuthProvider>().userInfo.profession,
              //   'token': token,
              // });
              QuerySnapshot q = await FirebaseFirestore.instance
                  .collection("usersGeneralGroups")
                  .get();
              List<DocumentSnapshot> docs = q.docs;
              docs.forEach((document) async {
                await FirebaseFirestore.instance
                    .collection("usersGeneralGroups")
                    .doc(document.id)
                    .collection("groups")
                    .doc(timestamp)
                    .update({
                  "name": _groupNameController.text,
                  "description": _groupDescriptionController.text,
                  "photo": downloadUrl
                });
              });

              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);

              showSuccessNotification(context, "Edited Group");
            }).catchError((e) => print(e));
          }, onError: (err) {
            print(err);
          });
        } else {
          var ref = FirebaseFirestore.instance
              .collection("generalGroups")
              .doc(timestamp);
          Map<String, dynamic> credentials = {
            "name": _groupNameController.text,
            "description": _groupDescriptionController.text,
            "photo": "",
            // "year": DateTime.now().year,
            // "createdUserId": context.read<AuthProvider>().userInfo.id
          };
          ref.update(credentials).then((value) async {
            // await FirebaseFirestore.instance
            //     .collection("generalGroups")
            //     .document(timestamp)
            //     .collection("members")
            //     .document(context.read<AuthProvider>().userInfo.id.toString())
            //     .setData({
            //   'name': context.read<AuthProvider>().userInfo.name,
            //   "photo": context.read<AuthProvider>().userInfo.photo,
            //   "profession": context.read<AuthProvider>().userInfo.profession,
            //   'token': token,
            // });
            QuerySnapshot q = await FirebaseFirestore.instance
                .collection("usersGeneralGroups")
                .get();
            List<DocumentSnapshot> docs = q.docs;
            docs.forEach((document) async {
              await FirebaseFirestore.instance
                  .collection("usersGeneralGroups")
                  .doc(document.id)
                  .collection("groups")
                  .doc(timestamp)
                  .update({
                "name": _groupNameController.text,
                "description": _groupDescriptionController.text,
                "photo": ""
              });
            });

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);

            showSuccessNotification(context, "Edited Group");
          }).catchError((e) => print(e));
        }
      } catch (e) {
        print(e);
      }

      setState(() {
        isLoading = false;
      });
    }
  }
}

class TextWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function validator;
  final String label;
  final int minLines;
  final int maxLines;
  final TextInputAction textInputAction;

  const TextWidget({
    Key key,
    @required this.controller,
    @required this.textInputType,
    this.validator,
    this.minLines,
    this.maxLines,
    this.textInputAction,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(fontSize: 14),
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        validator: validator == null ? null : validator,
        // cursorColor: Colors.black,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          filled: true,
          // fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: label,
          // labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: new BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 0.5, color: Colors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 0.5, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 0.5, color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 0.5, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 0.5, color: Colors.redAccent)),
        ),
      ),
    );
  }
}
