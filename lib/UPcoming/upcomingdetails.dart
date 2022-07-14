import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Upcomingdetails extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Upcomingdetails(this.data, this.time, this.ref);

  @override
  _UpcomingdetailsState createState() => _UpcomingdetailsState();
}

class _UpcomingdetailsState extends State<Upcomingdetails> {
  String age;
  String Upcoming;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    age = widget.data['age'];
    Upcoming = widget.data['Upcoming'];
    return SafeArea(
      child: Scaffold(
        //
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            age,
            // style: TextStyle(color: Colors.white),
          ),
          // backgroundColor: Constant.mainColor,
        ),

        resizeToAvoidBottomInset: false,
        //
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            size: 24.0,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey[700],
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                        ),
                        //
                        SizedBox(
                          width: 8.0,
                        ),
                        //
                        ElevatedButton(
                          onPressed: delete,
                          child: Icon(
                            Icons.delete_forever,
                            size: 24.0,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Constant.mainColor,
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //
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
                          hintText: "Upcoming(KG)",
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.black,
                        ),
                        initialValue: widget.data['Upcoming'],
                        enabled: edit,
                        onChanged: (_val) {
                          Upcoming = _val;
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
        {'age': age, 'Upcoming': Upcoming},
      );
      Navigator.of(context).pop();
    }
  }
}
