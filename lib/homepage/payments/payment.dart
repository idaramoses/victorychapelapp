import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'newpaystack.dart';

String backendUrl = '{YOUR_BACKEND_URL}';
// Set this to a public key that matches the secret key you supplied while creating the heroku instance
String paystackPublicKey = '{YOUR_PAYSTACK_PUBLIC_KEY}';
const String appName = 'Paystack Example';

class payment extends StatefulWidget {
  final String month;
  final String type;

  const payment({
    Key key,
    @required this.month,
    @required this.type,
  }) : super(key: key);

  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  int selectedIndex;

  int price = 0;

  String email = "//User Email Here";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            //GridView
            Icon(
              Icons.lock,
              color: Constant.mainColor,
              size: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Thanks for your interest in our app!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Upgrade to get access to  the app content.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),

            GestureDetector(
              onTap: () {
                MakePayment(
                        ctx: context,
                        email: FirebaseAuth.instance.currentUser.email,
                        type: widget.type,
                        month: widget.month,
                        price: 200)
                    .chargeCardAndMakePayment();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.green),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //icon
                    Icon(Icons.security, color: Colors.white),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Proceed to payment",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
