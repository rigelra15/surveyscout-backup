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
import 'package:surveyscout/pages/client/clientprojects.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:surveyscout/components/role_option_card.dart';
import 'dart:ui';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int currentIndex = 0;
  late List<Widget> containers;
  Timer? _timer;

  bool isLoading = false;

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

  Future<void> _enterDemoMode() async {
    const String demoToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiM2JmODgxYmMtMmNmZi00YTc4LTgxNGUtMDM3YjhmMzI1NzIzIiwiZW1haWwiOiJzdXJ2ZXlzY291dGRldmVsb3BlckBnbWFpbC5jb20iLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNzQyNDg1OTU3fQ.bJhxhRHWBjtEOcMXQR9VyC7wiJ5FA5lQg5Cp95VLNiY";
    await _saveToken(demoToken);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ClientProjects()),
    );
  }

  void _showDemoModeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Buka mode demo"),
          content: Text("Apakah Anda ingin masuk ke mode demo?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _enterDemoMode();
              },
              child: Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            "793947844120-od7vlmcqtbh7chhne8838t1er0nc6cnq.apps.googleusercontent.com",
        scopes: ['email', 'profile'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-In dibatalkan oleh pengguna.");
        setState(() {
          isLoading = false;
        });
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

          setState(() {
            isLoading = false;
          });

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
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login gagal. Silakan coba lagi."),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (error) {
      print("Terjadi error saat login: $error");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat login: $error'),
          backgroundColor: Colors.red,
        ),
      );
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
        Uri.parse("https://surveyscoutbe.onrender.com/api/v1/users/selectRole"),
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
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xFFF1E9E5),
              child: Padding(
                padding: EdgeInsets.all(27),
                child: Column(
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
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _handleGoogleSignIn,
                        onLongPress: _showDemoModeDialog,
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 60,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Sedang memproses...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
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
                RoleOptionCard(
                    title: "Klient",
                    description:
                        "Rekrut surveyor atau responden untuk membantu observasi Anda berjalan lancar dan efisien.",
                    imagePath: 'assets/images/klien.png',
                    onTap: () {
                      _sendSelectedRole("client");
                    }),
                SizedBox(height: 10),
                RoleOptionCard(
                    title: "Surveyor",
                    description:
                        "Hasilkan uang dengan mencari data dengan wawancara, observasi, dan/atau lainnya hingga merekapnya.",
                    imagePath: 'assets/images/surveyor.png',
                    onTap: () {
                      _sendSelectedRole("surveyor");
                    }),
                SizedBox(height: 10),
                RoleOptionCard(
                  title: "Responden",
                  description:
                      "Hasilkan uang dengan menjadi narasumber. Anda akan mengisi survei, diwawancarai, dan lainnya.",
                  imagePath: 'assets/images/responden.png',
                  onTap: () {
                    _sendSelectedRole("responden");
                  },
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
