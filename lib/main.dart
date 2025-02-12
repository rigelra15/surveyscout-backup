import 'package:flutter/material.dart';
import 'pages/clientsaya.dart';
import 'pages/welcome.dart';
import 'pages/surveyorprojects.dart';
import 'pages/surveyorproyeksaya.dart';

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
        '/': (context) => SurveyorProyekSaya(),
      },
    );
  }
}
