import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';
import 'feedback.dart';

class SocialMedia extends StatefulWidget {
  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contact us"),
          // backgroundColor: Constant.mainColor,
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/img1.JPG',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
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
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                _openmap(5.04362, 7.92420);
              },
              leading: Icon(
                Icons.location_on,
                color: Colors.orange,
              ),
              title: Text(
                'Addresss',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Victory Chapel (Church on Campus), University of Uyo, Ikpa Road,Uyo, Akwa Ibom State',
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
            ),
            ListTile(
              onTap: () {
                _opennumber();
              },
              leading: Icon(
                Icons.phone,
                color: Colors.red,
              ),
              title: Text(
                'Phone number',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '08035511061',
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
            ),
            ListTile(
              onTap: () {
                _launchWhatsapp();
              },
              leading: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.green,
              ),
              title: Text(
                'Whatsapp',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '08026646405',
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
            ),
            ListTile(
              onTap: () {
                _openFacebook();
              },
              leading: FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              title: Text(
                'Facebook',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Victory Chapel Uniuyo',
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Feebackpage()),
                );
              },
              leading: Icon(Icons.email),
              title: Text(
                'Email',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'victorychapeluyo@gmail.com',
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
            ),
          ],
        ));
  }

  Future<void> _launchWhatsapp() async {
    const url = "https://wa.me/2348026646405?text=Hey!";
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/604449633043067';
    } else {
      fbProtocolUrl = 'fb://page/604449633043067';
    }

    String fallbackUrl = 'https://www.facebook.com/Vic3chapel';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  Future<void> openmap() async {
    // const String lat = "42.3540";
    // const String lng = "71.0586";
    // const String mapUrl = "geo:$lat,$lng";
    // if (await canLaunch(mapUrl)) {
    //   await launch(mapUrl);
    // } else {
    //   throw "Couldn't launch Map";
    // }
    if (await MapLauncher.isMapAvailable(MapType.google)) {
      await MapLauncher.launchMap(
        mapType: MapType.google,
        coords: Coords(5.04362, 7.92420),
        title: "Victory Chapel Uniuyo",
        description: "Church on Campus",
      );
    }
  }

  Future<void> _openmap(double latitude, double longitude) async {
    // String googleUrl =
    //     'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // if (await canLaunch(googleUrl) != null) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
    if (await MapLauncher.isMapAvailable(MapType.google)) {
      await MapLauncher.launchMap(
        mapType: MapType.google,
        coords: Coords(latitude, longitude),
        title: "Victory Chapel Uniuyo",
        description: "Church on Campus",
      );
    }
  }

  Future<void> _opennumber() async {
    const url = "tel:08035511061";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
