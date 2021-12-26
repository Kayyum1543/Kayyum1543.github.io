import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:phonescoreweb/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  bool paymentdone = false;
  DateTime dateTimeNow = DateTime.now();
  String vibrationTime = "",
      earpieceTime = "",
      speakerTime = "",
      proximityTime = "",
      gyroscopeTime = "",
      multitouchTime = "",
      brand = "",
      model = "",
      osVersion = "",
      securityPatch = "",
      accelerometerTime = "";
  String accelerometerResult = '-',
      vibrationResult = '-',
      earpieceResult = '-',
      speakerResult = '-',
      proximityResult = '-',
      gyroscopeResult = '-',
      multitouchResult = '-';
  String uid = '';
  String buyerid = '';

  /*void getParams() {
    String uri = Uri.dataFromString(window.location.href);
    Map<String, String> params = uri.queryParameters;
    origin = params['id'];
    //print(origin);
  } */

  Future<void> getData() async {
    uid = Uri.base.queryParameters['id'].toString();

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      buyerid = auth.currentUser!.uid.toString();
    } catch (e) {
      print(e);
    }

    if (uid.isNotEmpty) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('uid', uid);
    }
    if (uid.isEmpty) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      uid = preferences.getString('uid').toString();
    }
    print(uid);
    print("buyer ud is : - $buyerid");

    DocumentSnapshot accelerometer = await FirebaseFirestore.instance
        .collection(uid)
        .doc("accelerometer")
        .get();
    DocumentSnapshot vibration =
        await FirebaseFirestore.instance.collection(uid).doc("vibration").get();
    DocumentSnapshot earpiece =
        await FirebaseFirestore.instance.collection(uid).doc("earpiece").get();

    DocumentSnapshot speaker =
        await FirebaseFirestore.instance.collection(uid).doc("speaker").get();
    DocumentSnapshot proximity =
        await FirebaseFirestore.instance.collection(uid).doc("proximity").get();
    DocumentSnapshot gyroscope =
        await FirebaseFirestore.instance.collection(uid).doc("gyroscope").get();
    DocumentSnapshot multitouch = await FirebaseFirestore.instance
        .collection(uid)
        .doc("multitouch")
        .get();
    DocumentSnapshot deviceInfo = await FirebaseFirestore.instance
        .collection(uid)
        .doc("deviceInfo")
        .get();

    if (buyerid != null) {
      try {
        DocumentSnapshot payment = await FirebaseFirestore.instance
            .collection('buyer')
            .doc(buyerid)
            .get();
        print('Status ---- ${payment[uid]}');
        setState(() {
          paymentdone = payment[uid];
        });
      } catch (e) {
        // print(e.hashCode);
        setState(() {
          paymentdone = false;
        });
      }
    }
    setState(() {
      if (paymentdone) {
        // accelerometerTime = accelerometer["time"];

        //print('$differenceInDays');

        if (accelerometer["testResult"] == 1) {
          accelerometerResult = "Successful";
          DateTime dateTimeCreatedAt = DateTime.parse(accelerometer["time"]);
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;
          accelerometerTime = differenceInDays.toString();
        } else if (accelerometer["testResult"] == 0) {
          accelerometerResult = "UnSuccessful";
        } else {
          accelerometerResult = "Not taken yet";
          accelerometerTime = "-";
        }

        if (vibration["testResult"] == 1) {
          vibrationResult = "Successful";
          DateTime dateTimeCreatedAt = DateTime.parse(vibration["time"]);
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;
          vibrationTime = differenceInDays.toString();
        } else if (vibration["testResult"] == 0) {
          vibrationResult = "UnSuccessful";
        } else {
          vibrationResult = "Not taken yet";
          vibrationTime = "-";
        }

        if (earpiece["testResult"] == 1) {
          earpieceResult = "Successful";
          DateTime dateTimeCreatedAt = DateTime.parse(earpiece["time"]);
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;
          earpieceTime = differenceInDays.toString();
        } else if (earpiece["testResult"] == 0) {
          earpieceResult = "UnSuccessful";
        } else {
          earpieceResult = "Not taken yet";
          earpieceTime = "-";
        }

        if (speaker["testResult"] == 1) {
          speakerResult = "Successful";
          DateTime dateTimeCreatedAt = DateTime.parse(speaker["time"]);
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;
          speakerTime = differenceInDays.toString();
        } else if (speaker["testResult"] == 0) {
          speakerResult = "UnSuccessful";
        } else {
          speakerResult = "Not taken yet";
          speakerTime = "-";
        }

        if (proximity["testResult"] == 1) {
          proximityResult = "Successful";
          DateTime dateTimeCreatedAt = DateTime.parse(proximity["time"]);
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;
          proximityTime = differenceInDays.toString();
        } else if (proximity["testResult"] == 0) {
          proximityResult = "UnSuccessful";
        } else {
          proximityResult = "Not taken yet";
          proximityTime = "-";
        }

        if (gyroscope["testResult"] == 1) {
          gyroscopeResult = "Successful";
          DateTime dateTimeCreatedAt = DateTime.parse(gyroscope["time"]);
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;
          gyroscopeTime = differenceInDays.toString();
        } else if (gyroscope["testResult"] == 0) {
          gyroscopeResult = "UnSuccessful";
        } else {
          gyroscopeResult = "Not taken yet";
          gyroscopeTime = "-";
        }

        if (multitouch["testResult"] == 1) {
          multitouchResult = "Successful";
          DateTime dateTimeCreatedAt = DateTime.parse(multitouch["time"]);
          final differenceInDays =
              dateTimeNow.difference(dateTimeCreatedAt).inDays;
          multitouchTime = differenceInDays.toString();
        } else if (multitouch["testResult"] == 0) {
          multitouchResult = "UnSuccessful";
        } else {
          multitouchResult = "Not taken yet";
          multitouchTime = "-";
        }
        brand = deviceInfo['brand'];
        model = deviceInfo['model'];
        osVersion = deviceInfo['osVersion'];
        securityPatch = deviceInfo['securityPatch'];
      } else {
        accelerometerTime = "-";
        vibrationTime = '-';
        earpieceTime = "-";
        speakerTime = "-";
        proximityTime = "-";
        gyroscopeTime = "-";
        multitouchTime = "-";

        if (accelerometer["testResult"] == 1) {
          accelerometerResult = "Successful";
        } else if (accelerometer["testResult"] == 0) {
          accelerometerResult = "UnSuccessful";
        } else {
          accelerometerResult = "Not taken yet";
        }

        if (vibration["testResult"] == 1) {
          vibrationResult = "Successful";
        } else if (vibration["testResult"] == 0) {
          vibrationResult = "UnSuccessful";
        } else {
          vibrationResult = "Not taken yet";
        }

        if (earpiece["testResult"] == 1) {
          earpieceResult = "Successful";
        } else if (earpiece["testResult"] == 0) {
          earpieceResult = "UnSuccessful";
        } else {
          earpieceResult = "Not taken yet";
        }

        if (speaker["testResult"] == 1) {
          speakerResult = "Successful";
        } else if (speaker["testResult"] == 0) {
          speakerResult = "UnSuccessful";
        } else {
          speakerResult = "Not taken yet";
        }

        if (proximity["testResult"] == 1) {
          proximityResult = "Successful";
        } else if (proximity["testResult"] == 0) {
          proximityResult = "UnSuccessful";
        } else {
          proximityResult = "Not taken yet";
        }

        if (gyroscope["testResult"] == 1) {
          gyroscopeResult = "Successful";
        } else if (gyroscope["testResult"] == 0) {
          gyroscopeResult = "UnSuccessful";
        } else {
          gyroscopeResult = "Not taken yet";
        }

        if (multitouch["testResult"] == 1) {
          multitouchResult = "Successful";
        } else if (multitouch["testResult"] == 0) {
          multitouchResult = "UnSuccessful";
        } else {
          multitouchResult = "Not taken yet";
        }
        brand = deviceInfo['brand'];
        model = deviceInfo['model'];
        osVersion = deviceInfo['osVersion'];
        securityPatch = deviceInfo['securityPatch'];
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
                child: Column(
                  mainAxisAlignment: !isMobile(context)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: !isMobile(context)
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    if (isMobile(context))
                      Image.asset(
                        'assets/images/mobile.png',
                        height: size.height * 0.5,
                      ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Device info :',
                              style: TextStyle(
                                fontSize: isDesktop(context) ? 32 : 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Brand : $brand',
                              style: TextStyle(
                                fontSize: isDesktop(context) ? 16 : 12,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Model : $model',
                              style: TextStyle(
                                fontSize: isDesktop(context) ? 16 : 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'OS version : $osVersion',
                              style: TextStyle(
                                fontSize: isDesktop(context) ? 16 : 12,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Security Patch : $securityPatch',
                              style: TextStyle(
                                fontSize: isDesktop(context) ? 16 : 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      runSpacing: 10,
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Device status :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 25 : 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Mutitouch',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 20 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test result',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  multitouchResult,
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                if (paymentdone == false)
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/login/?id=$uid');
                                    },
                                    child: Text(
                                      'view test recency',
                                      style: TextStyle(
                                        fontSize: isDesktop(context) ? 16 : 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test recency',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  multitouchTime + " days ago",
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Vibration',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 20 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test result',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  vibrationResult,
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                if (paymentdone == false)
                                  Text(
                                    'view test recency',
                                    style: TextStyle(
                                      fontSize: isDesktop(context) ? 16 : 12,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test recency',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  vibrationTime + " days ago",
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Earpiece',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 20 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test result',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  earpieceResult,
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                if (paymentdone == false)
                                  Text(
                                    'view test recency',
                                    style: TextStyle(
                                      fontSize: isDesktop(context) ? 16 : 12,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test recency',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  earpieceTime + " days ago",
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Speaker',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 20 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test result',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  speakerResult,
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                if (paymentdone == false)
                                  Text(
                                    'view test recency',
                                    style: TextStyle(
                                      fontSize: isDesktop(context) ? 16 : 12,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test recency',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  speakerTime + " days ago",
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Accelerometer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 20 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test result',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  accelerometerResult,
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                if (paymentdone == false)
                                  Text(
                                    'view test recency',
                                    style: TextStyle(
                                      fontSize: isDesktop(context) ? 16 : 12,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test recency',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  accelerometerTime + " days ago",
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Gyroscope',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 20 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test result',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  gyroscopeResult,
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                if (paymentdone == false)
                                  Text(
                                    'view test recency',
                                    style: TextStyle(
                                      fontSize: isDesktop(context) ? 16 : 12,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test recency',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  gyroscopeTime + " days ago",
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Proximity',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop(context) ? 20 : 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test result',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  proximityResult,
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                if (paymentdone == false)
                                  Text(
                                    'view test recency',
                                    style: TextStyle(
                                      fontSize: isDesktop(context) ? 16 : 12,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Test recency',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  proximityTime + " days ago",
                                  style: TextStyle(
                                    fontSize: isDesktop(context) ? 16 : 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )),
              if (isDesktop(context) || isTab(context))
                Expanded(
                    child: Image.asset(
                  'assets/images/mobile.png',
                  height: size.height * 0.8,
                ))
            ],
          ),
        ],
      ),
    );
  }
}
