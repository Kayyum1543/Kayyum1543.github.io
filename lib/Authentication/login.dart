import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phonescoreweb/constants.dart';
import 'package:phonescoreweb/responsive.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _phonecontroller = TextEditingController();
  // final TextEditingController _otpcontroller = TextEditingController();
  String uid = '';

  bool otpChecked = false;
  String isOTPSent = ' ';
  bool isLoggedin = false;
  bool otpSent = false;
  int r = 128, g = 128, b = 128;

  FirebaseAuth auth = FirebaseAuth.instance;
  late ConfirmationResult confirmationResult;
  @override
  void initState() {
    getUid();
    super.initState();
  }

  @override
  void dispose() {
    _phonecontroller.dispose();
    super.dispose();
  }

  void getUid() {
    uid = Uri.base.queryParameters['id'].toString();
  }

  void sendOtp() async {
    FirebaseAuth auth = FirebaseAuth.instance;

// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
    confirmationResult = await auth
        .signInWithPhoneNumber('+91${_phonecontroller.text}')
        .whenComplete(() => {
              setState(() {
                isOTPSent = 'OTP sent succesfully.';
                print('true');
              })
            });
  }

  Future<void> verify(String otp) async {
    try {
      UserCredential userCredential = await confirmationResult.confirm(otp);
      if (userCredential.user?.uid != null) {
        setState(() {
          otpChecked = true;
          r = 0;
          g = 128;
          b = 0;
          isOTPSent = 'OTP verified succesfully.';
        });

        print(" ====================== Done ===============");
      } else {
        setState(() {
          print('wrong');
          otpChecked = false;
          r = 128;
          g = 128;
          b = 128;
          isOTPSent = 'OTP verification failed.';
        });
      }
      print(userCredential);
    } catch (e) {
      setState(() {
        print('wrong');
        otpChecked = false;
        r = 128;
        g = 128;
        b = 128;
        isOTPSent = 'OTP verification failed.';
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFF8A2387),
              Color.fromARGB(255, 185, 80, 182)
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            if (isDesktop(context) || isTab(context))
              Image.asset(
                'assets/images/PhoneScore_logo.png',
                height: 80,
              ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Phonescore",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 450,
              width: 325,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Hello',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Please Log in to Your Account',
                      style: TextStyle(fontSize: 15, color: Colors.grey)),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: _phonecontroller,
                      decoration: InputDecoration(
                          labelText: 'Enter Phone no',
                          prefixIcon: const Icon(FontAwesomeIcons.phone),
                          suffix: TextButton(
                            onPressed: () {
                              sendOtp();
                            },
                            child: const Text('send OTP'),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      // controller: _otpcontroller,
                      onChanged: (String value) {
                        if (value.length == 6) {
                          print(value);
                          verify(value);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
                        prefixIcon: Icon(FontAwesomeIcons.key),
                        suffixIcon: Icon(
                          FontAwesomeIcons.checkCircle,
                          color: Color.fromRGBO(r, g, b, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(isOTPSent),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (otpChecked) {
                        Navigator.pushNamed(context, '/payment/?id=$uid');
                      }
                      //verify(otp);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue, Colors.blue]),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
