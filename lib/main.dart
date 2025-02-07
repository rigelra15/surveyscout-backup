import 'package:flutter/material.dart';
import 'pages/welcome.dart';
//import 'pages/second_page copy.dart';
//import 'pages/cobacoba.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multipage Example',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Welcome(),
      },
    );
  }
}
