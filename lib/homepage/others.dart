import 'package:WeightApp/homepage/PrayerRequest.dart';
import 'package:WeightApp/homepage/Socialmedia.dart';
import 'package:flutter/material.dart';

class Others extends StatefulWidget {
  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Other Features',
          // style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Constant.mainColor,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: <Widget>[
          new Card(
            child: InkWell(
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Image.asset(
                      "assets/images/pray.png",
                      height: 90.0,
                      width: 90.0,
                    ),
                    Text('\n PRAYER REQUEST',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrayerRequest()),
                ),
              },
            ),
          ),
          new Card(
            child: InkWell(
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Image.asset(
                      "assets/images/social-media.png",
                      height: 90.0,
                      width: 90.0,
                    ),
                    Text('\n CONTACT US',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocialMedia()),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
