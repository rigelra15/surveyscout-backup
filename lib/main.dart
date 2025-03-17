import 'package:flutter/material.dart';
import 'package:surveyscout/pages/clientrespondenproyekdetaildikerjakan.dart';
import 'package:surveyscout/pages/clientrespondenproyekdetailmerekrut.dart';
import 'package:surveyscout/pages/clientsignup.dart';
import 'package:surveyscout/pages/respondenproyeksaya.dart';
import 'package:surveyscout/pages/surveyorproyekdetailkirimlamaran.dart';
import 'pages/clientsaya.dart';
import 'pages/clientchat.dart';
import 'pages/welcome.dart';
import 'pages/surveyorprojects.dart';
import 'pages/surveyorchat.dart';
import 'pages/surveyorakun.dart';
import 'pages/respondenprojects.dart';
import 'pages/respondenchat.dart';
import 'pages/respondenakun.dart';
import 'pages/clientsurveyorproyekdetailmerekrut.dart';
import 'pages/clientsurveyorproyekdetaildikerjakanchat.dart';
import 'pages/surveyorsignup.dart';
import 'pages/respondensignup.dart';
import 'pages/clientsurveyorproyekdetailbutuhtinjau.dart';
import 'pages/clientsurveyorproyekdetaildikerjakanluaran.dart';
import 'pages/clientsurveyorproyekdetailperingatan.dart';
import 'pages/clientsurveyorproyekdetailselesai.dart';
import 'pages/clientrespondenproyekdetailmerekrut.dart';
import 'pages/clientrespondenproyekdetailmerekrutdipilih.dart';
import 'pages/clientchatrichardsantoso.dart';
import 'pages/surveyorproyekdetailkirimlamaran.dart';
import 'pages/surveyorproyekdetailmendaftar.dart';
import 'pages/surveyorproyekdetailditolak.dart';
import 'pages/surveyorproyekdetailmengerjakan.dart';
import 'pages/surveyorproyekdetailbutuhtinjau.dart';
import 'pages/surveyorproyekdetailmengerjakanchatluaran.dart';
import 'pages/surveyorproyekdetailselesai.dart';
import 'pages/surveyorproyekdetaildeadline.dart';
import 'pages/respondenproyekdetailkirimlamaran.dart';
import 'pages/respondenproyekdetailmendaftar.dart';

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
        '/': (context) => Respondenproyekdetailmendaftar(),
      },
    );
  }
}
