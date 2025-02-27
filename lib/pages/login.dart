import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/custom_container.dart';
import 'package:surveyscout/pages/client/clientprojects.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';
import 'package:surveyscout/pages/welcome.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  int currentIndex = 0;
  late List<Widget> containers;

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: "793947844120-od7vlmcqtbh7chhne8838t1er0nc6cnq.apps.googleusercontent.com",
        scopes: ['email', 'profile'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-In dibatalkan oleh pengguna.");
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        String? idToken = await user.getIdToken(true);
        print("ID Token dari Firebase: $idToken");
        final response = await http.post(
          Uri.parse("https://bcbf-118-99-84-39.ngrok-free.app/api/v1/users/GloginFirebase"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"idToken": idToken}),
        );
        if (response.statusCode == 200) {
          print("Backend response: ${response.body}");
          final data = jsonDecode(response.body);
          String status = data["status"];
          String role = data["role"];
          String token = data["token"];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);
          await prefs.setString('user_role', role);
          if (status == "0") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Welcome()),
            );
          } else {
            _navigateToRolePage(role);
          }
        } else {
          print("Login Gagal di Backend! Status Code: ${response.statusCode}");
          print("Response dari server: ${response.body}");
        }
      }
    } catch (error) {
      print("Terjadi error saat login: $error");
    }
  }

  void _navigateToRolePage(String role) {
    Widget nextPage;
    switch (role) {
      case "client":
        nextPage = ClientProjects();
        break;
      case "surveyor":
        nextPage = SurveyorProjects();
        break;
      case "responden":
        nextPage = RespondenProjects();
        break;
      default:
        nextPage = Login();
        break;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    containers = [containerA(), containerB(), containerC()];
    _startContainerLoop();
  }

  void _startContainerLoop() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % containers.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF1E9E5),
        padding: EdgeInsets.all(27),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/surveyscoutlogo.png',
                  width: 90,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 100),
                Center(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: containers[currentIndex],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          _handleGoogleSignIn();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF3A2B24),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Login Dengan Google",
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Color(0xFFf1e9e5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerA() {
    return CustomContainer(
      imagePath: "assets/images/caridata.png",
      title: "Cari data tak pernah semudah ini",
      description: "Tak perlu pusing lagi mencari responden dan data, surveyor kami akan melakukannya untuk Anda",
    );
  }

  Widget containerB() {
    return CustomContainer(
      imagePath: "assets/images/kepuasananda.png",
      title: "Kepuasan Anda ada di setiap visi kami",
      description: "Kami memastikan tenaga surveyor dan responden yang terpercaya dan andal dalam bidangnya",
    );
  }

  Widget containerC() {
    return CustomContainer(
      imagePath: "assets/images/ataujadilah.png",
      title: "Atau, jadilah bagian dari kami dan dapatkan komisi!",
      description: "Anda dapat menjadi surveyor atau responden dan memperoleh komisi setelah melaksanakan tugas",
    );
  }
}