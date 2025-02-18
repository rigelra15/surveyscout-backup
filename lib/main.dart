import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:surveyscout/pages/welcome.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyD1ekwsstJihsdmT3rcru4JoBPYEJL2Fno',
          appId: '1:793947844120:android:d1cde851c970a793c55d6d',
          messagingSenderId: '793947844120',
          projectId: 'surveyscout-9146c'
      )
  ) : await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyD1ekwsstJihsdmT3rcru4JoBPYEJL2Fno',
          appId: '1:793947844120:android:d1cde851c970a793c55d6d',
          messagingSenderId: '793947844120',
          projectId: 'surveyscout-9146c'
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Welcome(),
      },
    );
  }
}