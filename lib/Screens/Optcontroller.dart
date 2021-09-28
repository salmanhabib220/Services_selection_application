// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:service_selection_app/Screens/Homepage.dart';

class OptTracker extends StatefulWidget {
  final String phone;
  const OptTracker(String text, {Key? key, required this.phone})
      : super(key: key);

  @override
  _OptTrackerState createState() => _OptTrackerState();
}

class _OptTrackerState extends State<OptTracker> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late String _verficationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFoucus = FocusNode();
  final BoxDecoration pinPutdecoration = BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(126, 203, 224, 1),
      ));

  @override
  void initState() {
    super.initState();
    _varifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children: [
          Center(
            child: Text(
              "Varify +92-${widget.phone}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
          ),
          PinPut(
            fieldsCount: 6,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
            eachFieldWidth: 40.0,
            eachFieldHeight: 55.0,
            focusNode: _pinPutFoucus,
            controller: _pinPutController,
            submittedFieldDecoration: pinPutdecoration,
            selectedFieldDecoration: pinPutdecoration,
            pinAnimationType: PinAnimationType.fade,
            onSubmit: (pin) async {
              try {
                await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verficationCode, smsCode: pin))
                    .then((value) async {
                  if (value.user != null) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }), (route) => false);
                  }
                });
              } catch (e) {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Invalid Pin'),
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  _varifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+92${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          // ignore: avoid_print
          print(e.message);
        },
        codeSent: (String verficationID, [int? forceResendingToken]) {
          _verficationCode = verficationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verficationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
}
