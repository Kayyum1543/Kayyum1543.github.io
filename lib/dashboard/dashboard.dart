import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonescoreweb/components/header.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String buyerid = '';
  void getUser() {
    buyerid = auth.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('buyer')
        .doc(buyerid)
        .collection('success')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        buyerid = result['sellerid'];
        print(result['sellerid']);
      });
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        //child: SideMenu(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: size.width,
            constraints: BoxConstraints(minHeight: size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Header(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 450,
                      width: 325,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 236, 235, 235),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text("1. User id : " + buyerid),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
