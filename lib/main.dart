import 'package:flutter/material.dart';
import 'Screens/splashscreen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
         primarySwatch: Colors.orange,
       ),
      home: Splashscreen(),      
    );
  }
}
