import 'package:flutter/material.dart';
//import 'pages/coba.dart';
import 'pages/proyekpovklien.dart';
//import 'pages/cobacoba.dart';
import 'pages/clientsignup2.dart';
import 'pages/clientchat.dart';
import 'pages/welcome.dart';

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
        '/': (context) => Clientchat(),
      },
    );
  }
}
