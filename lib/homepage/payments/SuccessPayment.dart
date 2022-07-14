import 'package:WeightApp/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class SuccessPaymentPage extends StatefulWidget {
  final String month;
  final String type;

  const SuccessPaymentPage({
    Key key,
    @required this.month,
    @required this.type,
  }) : super(key: key);

  @override
  _SuccessPaymentPageState createState() => _SuccessPaymentPageState();
}

class _SuccessPaymentPageState extends State<SuccessPaymentPage> {
  @override
  void initState() {
    // TODO: implement initState
    send();
    sendnotification();
    super.initState();
  }

  Future<void> sendnotification() async {
    await FirebaseFirestore.instance
        .collection("notifications")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "title": 'Purchase successful',
      "content": 'Your Purchase for ${widget.type} was successful',
      "timestamp": FieldValue.serverTimestamp(),
      "postident": DateTime.now().millisecondsSinceEpoch.toString(),
      "read": false,
      'notiread': false,
      "data": {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "title": 'Purchase successful',
        "content": 'Your Purchase of ${widget.type} was successful',
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.green,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 120.0,
                      textDirection: TextDirection.ltr,
                      semanticLabel:
                          'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Success!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constant.mainColor,
                          borderRadius:
                              BorderRadius.circular(10), // radius of 10
                          border: Border.all(
                            color: Colors.white,
                          ), // green as background color
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'View ${widget.type} ',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> ShareLink() async {
    String type = 'sell';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://iwanpay.page.link',
        link: Uri.parse(
            'https://api.iwanpay/share?productid=${widget.month}&type=$type'),
        androidParameters:
            AndroidParameters(packageName: 'com.maradistudio.iwanpay'));

    // iosParameters: IosParameters(bundleId: 'com.dreamlabs.alumates01'));

    final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    final Uri shortUrl = shortenedLink.shortUrl;
    return 'https://iwanpay.page.link' + shortUrl.path;
  }

  void send() {
    var likeReference = FirebaseFirestore.instance
        .collection("Payments")
        .doc(widget.month)
        .collection(widget.type)
        .doc(FirebaseAuth.instance.currentUser.uid);

    likeReference.set({
      "user_id": FirebaseAuth.instance.currentUser.uid,
      "user_name": FirebaseAuth.instance.currentUser.displayName,
    });
  }
}
