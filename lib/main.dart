import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:surveyscout/pages/client/clientprojects.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';
import 'package:surveyscout/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD1ekwsstJihsdmT3rcru4JoBPYEJL2Fno',
      appId: '1:793947844120:android:d1cde851c970a793c55d6d',
      messagingSenderId: '793947844120',
      projectId: 'surveyscout-9146c',
    ),
  )
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Widget> _determineStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt_token');
    final String? role = prefs.getString('user_role');

    if (token != null && role != null) {
      return _getRolePage(role);
    }
    return Welcome();
  }

  Widget _getRolePage(String role) {
    switch (role) {
      case "client":
        return ClientProjects();
      case "surveyor":
        return SurveyorProjects();
      case "responden":
        return RespondenProjects();
      default:
        return Welcome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _determineStartPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.brown),
            home: Scaffold(
              backgroundColor: Color(0xFFF1E9E5),
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.brown),
          home: snapshot.data ?? Welcome(),
        );
      },
    );
  }
}