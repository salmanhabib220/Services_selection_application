// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:service_selection_app/Screens/Optcontroller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNum = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    "Phone Athentication",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "+923016443947",
                  labelText: "Enter Your Phone Number",
                  hintStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                  ),
                ),
                maxLength: 12,
                keyboardType: TextInputType.phone,
                controller: _phoneNum,
              ),
              Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OptTracker(_phoneNum.text, phone: '',);
                    }));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
