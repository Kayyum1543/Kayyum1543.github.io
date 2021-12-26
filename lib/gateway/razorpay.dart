import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:js/js.dart';

import 'package:js/js.dart';
import 'package:phonescoreweb/payments.dart';
import 'dart:js_util';

import 'package:phonescoreweb/screens/home/components/certificate.dart';

@JS()
external dynamic paymentProcess(uid);

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Payment> {
  String uid = '';
  @override
  void initState() {
    getUid();
    super.initState();
  }

  void payment() {
    //js.context.callMethod('paymentProcess', [uid]);
  }

  void getUid() {
    uid = Uri.base.queryParameters['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Payment"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/PhoneScore_logo.png',
              height: 100,
            ),
            const Text(
              'Get Phonescore pro version',
            ),
            const Text(
              'pay 320 INR',
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () async {
                  //js.JsObject jsObject =
                  // await promiseToFuture(paymentProcess(uid)).then((value) =>
                  Navigator.pushNamed(context, '/webpayment/?id=$uid');
                  //payment();
                  //Navigator.push(context,
                  //  MaterialPageRoute(builder: (context) => Webpayment()));

                  // print(a);
                },
                child: const Text("Pay Now")),
            const SizedBox(height: 10.0),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("See old payments"),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Log in'),
                ),
              ],
            ),*/
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
