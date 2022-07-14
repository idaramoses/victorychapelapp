import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/homepage/payments/newpaystack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.appbarColor,
          title: Text(
            'Give',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                new Image.asset(
                  "assets/images/donation.png",
                  height: 300.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Give',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(70)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'You can make donation to our bank details.',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(40)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                // Divider(
                //   color: Theme.of(context).accentColor,
                // ),
                // ListTile(
                //   onTap: () {
                //     showBottom();
                //   },
                //   title: Text(
                //     'Pay via app',
                //     style: new TextStyle(
                //         fontWeight: FontWeight.bold, color: Constant.mainColor),
                //   ),
                //   subtitle: Text(
                //     'click here pay',
                //     style: TextStyle(color: Constant.mainColor),
                //   ),
                // ),
                ListTile(
                  tileColor: Constant.mainColor.withOpacity(0.6),
                  onTap: () {
                    showBottom();
                  },
                  title: Text(
                    'Pay via app',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    'click here pay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Divider(
                //   color: Theme.of(context).accentColor,
                // ),
                ListTile(
                  title: Text(
                    'Victory Chapel Uniuyo',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '1003284204',
                  ),
                  trailing: Text(
                    'UBA',
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  color: Theme.of(context).accentColor,
                ),
                ListTile(
                  title: Text(
                    'Victory Chapel Building Project',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '0087697033',
                  ),
                  trailing: Text(
                    'Sterling Bank',
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }

  showBottom() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: donateonline(),
            ),
          );
        });
  }
}

class donateonline extends StatefulWidget {
  const donateonline({Key key}) : super(key: key);

  @override
  _donateonlineState createState() => _donateonlineState();
}

class _donateonlineState extends State<donateonline> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mainpurpose, purpose;
  bool ispurpose = false;
  String _amount;
  final _amoutcon = TextEditingController();

  List<String> mainpurposearray = [
    "Offering",
    "Tithe",
    "Building support",
    "I love my pastors",
    "Others"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Constant.mainColor, // set border color
                    width: 0.5), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // set rounded corner radius
              ),
              child: TextField(
                controller: _amoutcon,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  // fontFamily: "lato",
                  // fontWeight: FontWeight.w600,
                  // color: Colors.black,
                ),
                onChanged: (_val) {
                  _amount = _val;
                },
              ),
            ),
            mainpurpose != 'Others'
                ? Container(
                    height: 55.0,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // color: Colors.white,
                      border: Border.all(color: Constant.mainColor, width: 0.5),
                    ),
                    child: DropdownButtonFormField<String>(
                      itemHeight: 52.0,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      hint: Text(mainpurpose ?? "Purpose of payments"),
                      isExpanded: true,
                      value: mainpurpose,
                      items: mainpurposearray.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "lato",
                              // color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          mainpurpose = value;
                        });
                      },
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                          color: Constant.mainColor, // set border color
                          width: 0.5), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Others',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "lato",
                        // fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                      onChanged: (_val) {
                        mainpurpose = _val;
                      },
                    ),
                  ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Makedonation(
                          ctx: context,
                          email: FirebaseAuth.instance.currentUser.email,
                          des: mainpurpose.toString(),
                          price: int.parse(_amount))
                      .chargeCardAndMakePayment();
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // radius of 10
                      color: Constant.mainColor.withOpacity(0.7)
                      // green as background color
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pay",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Please switch to light theme when inputing you card",
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
