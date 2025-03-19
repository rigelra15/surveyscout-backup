import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:surveyscout/pages/client/clientsignup.dart';
import 'package:surveyscout/pages/surveyor/surveyorsignup.dart';
import 'package:surveyscout/pages/responden/respondensignup.dart';
import 'package:surveyscout/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int currentIndex = 0;
  late List<Widget> containers;
  Timer? _timer;

  Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
    } catch (e) {
      print("Error menyimpan token: $e");
    }
  }

  Future<String?> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('jwt_token');
    } catch (e) {
      print("Error mengambil token: $e");
      return null;
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            "793947844120-od7vlmcqtbh7chhne8838t1er0nc6cnq.apps.googleusercontent.com",
        scopes: ['email', 'profile'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-In dibatalkan oleh pengguna.");
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        String? idToken = await user.getIdToken(true);
        print("ID Token dari Firebase: $idToken");
        final response = await http.post(
          Uri.parse(
              "https://surveyscoutbe.onrender.com/api/v1/users/GloginFirebase"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"idToken": idToken}),
        );
        if (response.statusCode == 200) {
          print("Backend response: ${response.body}");
          final data = jsonDecode(response.body);
          String status = data["status"];
          String token = data["token"];
          await _saveToken(token);
          if (status == "0") {
            _showGoogleSignupMenu(context);
          } else if (status == "1") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Akun Google sudah terdaftar"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
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

  Future<void> _sendSelectedRole(String role) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Token tidak ditemukan, harap login ulang."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
      final response = await http.post(
        Uri.parse(
            "https://surveyscoutbe.onrender.com/api/v1/users/selectRole"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"role": role}),
      );
      if (response.statusCode == 200) {
        print("Role berhasil diperbarui: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Berhasil memilih role sebagai $role"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        switch (role) {
          case "client":
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ClientSignUp()),
            );
            break;
          case "surveyor":
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SurveyorSignUp()),
            );
            break;
          case "responden":
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RespondenSignUp()),
            );
            break;
          default:
            print("Role tidak dikenali: $role");
        }
      } else {
        print("Gagal memilih role! Status Code: ${response.statusCode}");
        print("Response dari server: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal memilih role! Silakan coba lagi."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print("Terjadi error saat memilih role: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    containers = [containerA(), containerB(), containerC()];
    _startContainerLoop();
  }

  void _startContainerLoop() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!mounted) {
        _timer?.cancel();
        return;
      }
      setState(() {
        currentIndex = (currentIndex + 1) % containers.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                        onPressed: _handleGoogleSignIn,
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
                              "Daftar dengan Google",
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
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Sudah punya akun? ",
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFa3948d),
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "Masuk di sini",
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              color: Color(0xFFa3948d),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
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

  void _showGoogleSignupMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(24),
            color: Color(0xFFF1E9E5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  thickness: 3,
                  indent: 150,
                  endIndent: 150,
                  color: Color(0xFFB0B0B0),
                ),
                SizedBox(height: 10),
                Text(
                  "Daftar Sebagai",
                  style: TextStyle(
                    fontFamily: 'SourceSans3',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF705D54),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _sendSelectedRole("client");
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFD7CCC8),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/klien.png',
                        width: 50,
                        height: 50,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Klien",
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF705D54),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Rekrut surveyor atau responden untuk membantu observasi Anda berjalan lancar dan efisien.",
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3A2B24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _sendSelectedRole("surveyor");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFD7CCC8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/surveyor.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Surveyor",
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF705D54),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Hasilkan uang dengan mencari data dengan wawancara, observasi, dan/atau lainnya hingga merekapnya.",
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF3A2B24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _sendSelectedRole("responden");
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFD7CCC8),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/responden.png',
                        width: 50,
                        height: 50,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Responden",
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF705D54),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Hasilkan uang dengan menjadi narasumber. Anda akan mengisi survei, diwawancarai, dan lainnya.",
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3A2B24),
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
        );
      },
    );
  }

  Widget containerA() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/caridata.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Text(
            "Cari data tak pernah semudah ini",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SourceSans3',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Color(0xFF705D54),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Tak perlu pusing lagi mencari responden dan data, surveyor kami akan melakukannya untuk Anda",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFFA3948D),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFF826754),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget containerB() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/kepuasananda.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Text(
            "Kepuasan Anda ada di setiap visi kami",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SourceSans3',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Color(0xFF705D54),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Kami memastikan tenaga surveyor dan responden yang terpercaya dan andal dalam bidangnya",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFFA3948D),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 30,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFF826754),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget containerC() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ataujadilah.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Text(
            "Atau, jadilah bagian dari kami dan dapatkan komisi",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SourceSans3',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Color(0xFF705D54),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Anda dapat menjadi surveyor atau responden dan memperoleh komisi setelah melaksanakan tugas",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFFA3948D),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 30,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFF826754),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
