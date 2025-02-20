import 'package:flutter/material.dart';
import 'package:surveyscout/pages/respondenproyeksaya.dart';
import 'pages/clientsaya.dart';
import 'pages/welcome.dart';
import 'pages/surveyorprojects.dart';
import 'pages/surveyorchat.dart';
import 'pages/surveyorakun.dart';
import 'pages/respondenprojects.dart';
import 'pages/respondenchat.dart';
import 'pages/respondenakun.dart';
import 'pages/clientproyekdetailmerekrut.dart';
import 'pages/surveyorsignup.dart';
import 'pages/respondensignup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/': (context) => Respondensignup(),
      },
    );
  }
}
