import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'SuccessPayment.dart';

class MakePayment {
  MakePayment({this.ctx, this.price, this.email, this.month, this.type});

  BuildContext ctx;

  int price;

  String email;
  String month;
  String type;

  //Reference

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  //GetUi
  PaymentCard _getCardUI() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await PaystackPlugin.initialize(publicKey: ConstantKey.PAYSTACK_KEY);
  }

  //Method Charging card
  chargeCardAndMakePayment() async {
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = _getReference()
        ..putCustomField('Charged From', '$type')
        ..card = _getCardUI();

      CheckoutResponse response = await PaystackPlugin.checkout(
        ctx,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        logo: Image.asset(
          'assets/images/victorychapel_bg.png',
          height: 75.0,
        ),
      );

      print("Response $response");

      if (response.status == true) {
        print("Transaction successful");
        Navigator.of(ctx).pushReplacement(MaterialPageRoute(
            builder: (context) => SuccessPaymentPage(
                  month: month,
                  type: type,
                )));
      } else {
        Navigator.of(ctx)
            .pushReplacement(MaterialPageRoute(builder: (context) => Fail()));
      }
    });
  }
}

class Makedonation {
  Makedonation(
      {this.ctx, this.price, this.email, this.month, this.type, this.des});

  BuildContext ctx;

  int price;

  String email;
  String des;
  String month;
  String type;

  //Reference

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom $des ${DateTime.now().millisecondsSinceEpoch}';
  }

  //GetUi
  PaymentCard _getCardUI() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await PaystackPlugin.initialize(publicKey: ConstantKey.PAYSTACK_KEY);
  }

  //Method Charging card
  chargeCardAndMakePayment() async {
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = _getReference()
        ..putCustomField('Charged From', des)
        ..card = _getCardUI();

      CheckoutResponse response = await PaystackPlugin.checkout(
        ctx,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        logo: Image.asset(
          'assets/images/victorychapel_bg.png',
          height: 24.0,
        ),
      );

      print("Response $response");

      if (response.status == true) {
        print("Transaction successful");
        Navigator.of(ctx).pushReplacement(MaterialPageRoute(
            builder: (context) => SuccessPayment(
                  month: price,
                  type: des,
                )));
      } else {
        Navigator.of(ctx)
            .pushReplacement(MaterialPageRoute(builder: (context) => Fail()));
      }
    });
  }
}

class SuccessPayment extends StatefulWidget {
  final int month;
  final String type;

  const SuccessPayment({
    Key key,
    @required this.month,
    @required this.type,
  }) : super(key: key);

  @override
  _SuccessPaymentState createState() => _SuccessPaymentState();
}

class _SuccessPaymentState extends State<SuccessPayment> {
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
      "title": 'Payment of N${widget.month} successful ',
      "content": 'Your payment for ${widget.type} was successful',
      "timestamp": FieldValue.serverTimestamp(),
      "postident": DateTime.now().millisecondsSinceEpoch.toString(),
      "read": false,
      'notiread': false,
      "data": {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "title": 'Payment of N${widget.month} successful ',
        "content": 'Your payment of ${widget.type} was successful',
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
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void send() {
    var likeReference = FirebaseFirestore.instance
        .collection("Payments")
        .doc(widget.type)
        .collection(widget.type)
        .doc(FirebaseAuth.instance.currentUser.uid);

    likeReference.set({
      "user_id": FirebaseAuth.instance.currentUser.uid,
      "user_name": FirebaseAuth.instance.currentUser.displayName,
    });
  }
}

class Fail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('X',
                  style: TextStyle(
                      fontSize: 100,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sorry,an error occurred while processing payment',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'PAYMENT DECLINED',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  color: Colors.green,
                  child: Text(
                    "Try Again",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class ConstantKey {
  static const String PAYSTACK_KEY =
      "pk_test_4bab8c69e8dfd3e06f9a7b0515ca6a9707c7f727";
}
