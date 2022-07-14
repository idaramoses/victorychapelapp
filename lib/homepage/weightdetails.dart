import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Weightdetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Weightdetails(this.data, this.time, this.ref);

  @override
  _WeightdetailsState createState() => _WeightdetailsState();
}

class _WeightdetailsState extends State<Weightdetails> {
  String age;
  String weight;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    age = widget.data['age'];
    weight = widget.data['weight'];
    return SafeArea(
      child: Scaffold(
        //
        appBar: AppBar(
          title: const Text(""),
          // backgroundColor: Constant.mainColor,
        ),
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                child: Icon(
                  Icons.save_rounded,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey[700],
              )
            : null,
        //
        resizeToAvoidBottomInset: false,
        //
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 12.0,
                  ),
                  child: Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "lato",
                      color: Colors.grey,
                    ),
                  ),
                ),
                //
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "HEIGHT (CM)",
                        ),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        initialValue: widget.data['age'],
                        enabled: edit,
                        onChanged: (_val) {
                          age = _val;
                        },
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      //
                      SizedBox(
                        height: 12.0,
                      ),
                      //

                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "WEIGHT(KG)",
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.black,
                        ),
                        initialValue: widget.data['weight'],
                        enabled: edit,
                        onChanged: (_val) {
                          weight = _val;
                        },
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState.validate()) {
      // TODo : showing any kind of alert that new changes have been saved
      await widget.ref.update(
        {'age': age, 'weight': weight},
      );
      Navigator.of(context).pop();
    }
  }
}
