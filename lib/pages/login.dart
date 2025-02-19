import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        } else {
          print("Login Gagal di Backend! Status Code: ${response.statusCode}");
          print("Response dari server: ${response.body}");
        }
      }
    } catch (error) {
      print("Terjadi error saat login: $error");
    }
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
        currentIndex = (currentIndex + 1) % containers.length; // Mengulang A, B, C
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
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerA() {
    return Container(
      padding: EdgeInsets.all(16), // Tambahkan padding agar konten tidak terlalu menempel ke tepi
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar Column hanya mengambil ruang yang dibutuhkan
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
        crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan konten secara horizontal
        children: [
          Image.asset(
            'assets/images/caridata.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30), // Spasi antara gambar dan teks
          Text(
            "Cari data tak pernah semudah ini",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'SourceSans3', // Gunakan font yang sudah di-load
              fontSize: 24,
              fontWeight: FontWeight.w400, // Weight 400
              color: Color(0xFF705D54), // Warna #705D54
            ),
          ),
          SizedBox(height: 10), // Spasi antara teks pertama dan teks kedua
          Text(
            "Tak perlu pusing lagi mencari responden dan data, surveyor kami akan melakukannya untuk Anda",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFFA3948D),
            ),
          ),
          SizedBox(height: 20), // Spasi antara teks dan bulatan
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan bulatan secara horizontal
            children: [
              Container(
                width: 30, // Lebar elips (horizontal)
                height: 10, // Tinggi elips (vertikal)
                decoration: BoxDecoration(
                  color: Color(0xFF826754), // Warna elips
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), // Radius sudut kiri
                    right: Radius.circular(20), // Radius sudut kanan
                  ),
                ),
              ),
              SizedBox(width: 5), // Jarak antara bulatan
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
                ),
              ),
              SizedBox(width: 5), // Jarak antara bulatan
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
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
      padding: EdgeInsets.all(16), // Tambahkan padding agar konten tidak terlalu menempel ke tepi
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar Column hanya mengambil ruang yang dibutuhkan
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
        crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan konten secara horizontal
        children: [
          // Gambar
          Image.asset(
            'assets/images/kepuasananda.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30), // Spasi antara gambar dan teks
          Text(
            "Kepuasan Anda ada di setiap visi kami",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'SourceSans3', // Gunakan font yang sudah di-load
              fontSize: 24,
              fontWeight: FontWeight.w400, // Weight 400
              color: Color(0xFF705D54), // Warna #705D54
            ),
          ),
          SizedBox(height: 10), // Spasi antara teks pertama dan teks kedua
          Text(
            "Kami memastikan tenaga surveyor dan responden yang terpercaya dan andal dalam bidangnya",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFFA3948D),
            ),
          ),
          SizedBox(height: 20), // Spasi antara teks dan bulatan
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan bulatan secara horizontal
            children: [
              // Bulatan 1
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
                ),
              ),
              SizedBox(width: 5), // Jarak antara bulatan
              Container(
                width: 30, // Lebar elips (horizontal)
                height: 10, // Tinggi elips (vertikal)
                decoration: BoxDecoration(
                  color: Color(0xFF826754), // Warna elips
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), // Radius sudut kiri
                    right: Radius.circular(20), // Radius sudut kanan
                  ),
                ),
              ),
              SizedBox(width: 5), // Jarak antara bulatan
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
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
      padding: EdgeInsets.all(16), // Tambahkan padding agar konten tidak terlalu menempel ke tepi
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar Column hanya mengambil ruang yang dibutuhkan
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
        crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan konten secara horizontal
        children: [
          Image.asset(
            'assets/images/ataujadilah.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30), // Spasi antara gambar dan teks
          Text(
            "Atau, jadilah bagian dari kami dan dapatkan komisi",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'SourceSans3', // Gunakan font yang sudah di-load
              fontSize: 24,
              fontWeight: FontWeight.w400, // Weight 400
              color: Color(0xFF705D54), // Warna #705D54
            ),
          ),
          SizedBox(height: 10), // Spasi antara teks pertama dan teks kedua
          Text(
            "Anda dapat menjadi surveyor atau responden dan memperoleh komisi setelah melaksanakan tugas",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFFA3948D),
            ),
          ),
          SizedBox(height: 20), // Spasi antara teks dan bulatan
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan bulatan secara horizontal
            children: [
              // Bulatan 1
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
                ),
              ),
              SizedBox(width: 5), // Jarak antara bulatan
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
                ),
              ),
              SizedBox(width: 5), // Jarak antara bulatan
              Container(
                width: 30, // Lebar elips (horizontal)
                height: 10, // Tinggi elips (vertikal)
                decoration: BoxDecoration(
                  color: Color(0xFF826754), // Warna elips
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), // Radius sudut kiri
                    right: Radius.circular(20), // Radius sudut kanan
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