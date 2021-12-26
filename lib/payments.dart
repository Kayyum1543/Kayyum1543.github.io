import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

import 'package:phonescoreweb/UiFake.dart' if (dart.library.html) 'dart:ui'
    as ui;
import 'package:phonescoreweb/screens/home/components/certificate.dart';

class Webpayment extends StatefulWidget {
  const Webpayment({Key? key}) : super(key: key);
  @override
  _Webpayment createState() => _Webpayment();
}

class _Webpayment extends State<Webpayment> {
  String selleruid = '';
  String buyerid = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  void getUid() {
    selleruid = Uri.base.queryParameters['id'].toString();
    FirebaseAuth auth = FirebaseAuth.instance;
    buyerid = auth.currentUser!.uid.toString();
    print('sellerid : $selleruid');
    print('buyerid : $buyerid');
  }

  @override
  void initState() {
    getUid();
    super.initState();
  }

  //final String? name;
  //final String? image;
  //final int? price;
  //Webpayment({this.name, this.price, this.image});
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();
      element.style.width = '100%';
      element.style.height = '100%';
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (element.data == 'SUCCESS') {
          Navigator.pushNamed(
            context,
            '/certificate/?id=$selleruid',
          );
          print('PAYMENT SUCCESSFULL!!!!!!!');
          FirebaseFirestore.instance
              .collection('buyer')
              .doc(buyerid)
              .set({selleruid: true});
        }
      });

      element.src = 'assets/payments.html';
      element.style.border = 'none';

      return element;
    });
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return const HtmlElementView(
        viewType: 'rzp-html',
      );
    }));
  }
}
