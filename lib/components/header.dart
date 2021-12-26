import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phonescoreweb/responsive.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);
  @override
  Header_state createState() => Header_state();
}

class Header_state extends State<Header> {
  String uid = '';

  Future<void> getData() async {
    uid = Uri.base.queryParameters['id'].toString();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/PhoneScore_logo.png',
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phonescore",
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Device Status Report",
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                  )),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                child: const Text("Dashboard"),
              ),
              QrImage(
                data: uid,
                version: QrVersions.auto,
                size: 100.0,
              ),
              const SizedBox(width: 10),
              if (isDesktop(context) || isTab(context))
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("User Id :",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("896563564",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                      )),
                  Text("Date :",
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Text("12-07-2021",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                      ))
                ]),
              const SizedBox(width: 20),
              if (!isMobile(context)) const SizedBox(width: 50),
            ],
          ),
        ],
      ),
    );
  }
}
