import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:surveyscout/pages/client/clientpages.dart';
import 'package:surveyscout/pages/responden/respondenpages.dart';
import 'package:surveyscout/pages/surveyor/surveyorpages.dart';
import 'package:surveyscout/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFF3A2B24),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  await initializeDateFormatting('id_ID', null);

  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? const FirebaseOptions(
            apiKey: 'AIzaSyD1ekwsstJihsdmT3rcru4JoBPYEJL2Fno',
            appId: '1:793947844120:android:d1cde851c970a793c55d6d',
            messagingSenderId: '793947844120',
            projectId: 'surveyscout-9146c',
          )
        : null,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _determineStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt_token');
    final String? role = prefs.getString('user_role');
    print("Token: $token, Role: $role");

    if (token != null && role != null) {
      return _getRolePage(role);
    }

    return Welcome(); // fallback
  }

  Widget _getRolePage(String role) {
    switch (role) {
      case "client":
        return ClientPages();
      case "surveyor":
        return SurveyorPages();
      case "responden":
        return RespondenPages();
      default:
        return Welcome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SurveyScout',
      home: FutureBuilder<Widget>(
        future: _determineStartPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Something went wrong')),
            );
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}
