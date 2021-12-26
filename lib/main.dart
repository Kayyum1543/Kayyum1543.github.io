import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:phonescoreweb/Authentication/login.dart';
import 'package:phonescoreweb/constants.dart';
import 'package:phonescoreweb/dashboard/dashboard.dart';
import 'package:phonescoreweb/gateway/razorpay.dart';
import 'package:phonescoreweb/payments.dart';
import 'package:phonescoreweb/screens/home/home.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var origin;
  @override
  void initState() {
    super.initState();
    getParams();
  }

  void getParams() {
    var uri = Uri.dataFromString(window.location.href);
    Map<String, String> params = uri.queryParameters;
    print(params);
    origin = params['id'];
    print(origin);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonescore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      initialRoute: '/certificate/?id=$origin',
      routes: {
        '/login/?id=$origin': (context) => Login(),
        '/dashboard': (context) => dashboard(),
        // When navigating to the "/" route, build the FirstScreen widget.
        '/certificate/?id=$origin': (context) => const HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/payment/?id=$origin': (context) => const Payment(),
        '/webpayment/?id=$origin': (context) => const Webpayment(),
      },
    );
  }
}
