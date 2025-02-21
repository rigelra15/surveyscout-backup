import 'package:flutter/material.dart';
import 'package:surveyscout/pages/respondenprojects.dart';
import 'dart:async'; // Import untuk Future.delayed
import 'clientsignup.dart';
import 'surveyorprojects.dart';
import 'respondenprojects.dart';
import 'respondensignup.dart';
import 'surveyorsignup.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int currentIndex = 0;
  late List<Widget> containers;

  @override
  void initState() {
    super.initState();
    // Initialize containers inside initState
    containers = [containerA(), containerB(), containerC()];
    _startContainerLoop();
  }

  void _startContainerLoop() {
    Timer.periodic(Duration(seconds: 2), (timer) {
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

                // Menggunakan AnimatedSwitcher untuk transisi antar kontainer
                Center(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1), // Durasi animasi transisi
                    child: containers[currentIndex],
                  ),
                ),
              ],
            ),

            // Tombol di bagian bawah
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
                          // Show the bottom sheet when the button is pressed
                          _showGoogleSignupMenu(context);
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
                              height: 17,
                              width: 17,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Daftar Dengan Google",
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
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
                      print("Navigasi ke halaman login");
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isScrollControlled: true, // Allow bottom sheet to adjust based on its content
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // Apply rounded corners to the content
          child: Container(
            width: MediaQuery.of(context).size.width, // Make the width fill the screen
            padding: EdgeInsets.all(24),
            color: Color(0xFFF1E9E5),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Makes the bottom sheet take only necessary height
              children: [
                Divider(
                  thickness: 3, // Adjust thickness to make the line thicker
                  indent: 150,   // Make the line shorter by adding space from the start
                  endIndent: 150, // Make the line shorter by adding space from the end
                  color: Color(0xFFB0B0B0), // Optional: set a color for the divider
                ),
                SizedBox(height: 10), // Spasi antara garis dan tulisan
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
                // Kontainer pertama
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman clientsignup2.dart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClientSignUp()),
                    );
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
                              fontFamily: 'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w700, // Weight 700
                              color: Color(0xFF705D54), // Warna #705D54
                            ),
                          ),
                          SizedBox(height: 2), // Spasi antara dua teks
                          Text(
                            "Rekrut surveyor atau responden untuk membantu observasi Anda berjalan lancar dan efisien.",
                            style: TextStyle(
                              fontFamily: 'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w400, // Weight 400
                              color: Color(0xFF3A2B24), // Warna #3A2B24
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
                    // Navigasi ke halaman clientsignup2.dart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Surveyorsignup()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFD7CCC8),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/surveyor.png',
                        width: 50,
                        height: 50,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Surveyor",
                            style: TextStyle(
                              fontFamily: 'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w700, // Weight 700
                              color: Color(0xFF705D54), // Warna #705D54
                            ),
                          ),
                          SizedBox(height: 2), // Spasi antara dua teks
                          Text(
                            "Hasilkan uang dengan mencari data dengan wawancara, observasi, dan/atau lainnya hingga merekapnya.",
                            style: TextStyle(
                              fontFamily: 'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w400, // Weight 400
                              color: Color(0xFF3A2B24), // Warna #3A2B24
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
                    // Navigasi ke halaman SurveyorProjects
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Respondensignup()),
                    );
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
                          Text("Responden",
                            style: TextStyle(
                              fontFamily: 'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w700, // Weight 400
                              color: Color(0xFF705D54), // Warna #705D54
                            ),

                          ),
                          SizedBox(height: 2), // Spasi antara dua teks
                          Text("Hasilkan uang dengan menjadi narasumber. Anda akan mengisi survei, diwawancarai, dan lainnya.",
                            style: TextStyle(
                              fontFamily: 'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w400, // Weight 400
                              color: Color(0xFF3A2B24), // Warna #705D54
                            ),
                          ), // Teks kedua
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










  // Kontainer A
  Widget containerA() {
    return Container(
      padding: EdgeInsets.all(16), // Tambahkan padding agar konten tidak terlalu menempel ke tepi
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar Column hanya mengambil ruang yang dibutuhkan
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
        crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan konten secara horizontal
        children: [
          // Gambar
          Image.asset(
            'assets/images/caridata.png',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 30), // Spasi antara gambar dan teks

          // Teks pertama
          Text(
            "Cari data tak pernah semudah ini",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'SourceSans3', // Gunakan font yang sudah di-load
              fontSize: 20,
              fontWeight: FontWeight.w400, // Weight 400
              color: Color(0xFF705D54), // Warna #705D54
            ),
          ),

          SizedBox(height: 10), // Spasi antara teks pertama dan teks kedua

          // Teks kedua
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

          // 3 Bulatan kecil
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan bulatan secara horizontal
            children: [
              // Bulatan 1
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

              // Bulatan 2
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
                ),
              ),

              SizedBox(width: 5), // Jarak antara bulatan

              // Bulatan 3
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

  // Kontainer B
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
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 30), // Spasi antara gambar dan teks

          // Teks pertama
          Text(
            "Kepuasan Anda ada di setiap visi kami",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'SourceSans3', // Gunakan font yang sudah di-load
              fontSize: 20,
              fontWeight: FontWeight.w400, // Weight 400
              color: Color(0xFF705D54), // Warna #705D54
            ),
          ),

          SizedBox(height: 10), // Spasi antara teks pertama dan teks kedua

          // Teks kedua
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

          // 3 Bulatan kecil
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

              // Bulatan 2
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

              // Bulatan 3
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

  // Kontainer C
  Widget containerC() {
    return Container(
      padding: EdgeInsets.all(16), // Tambahkan padding agar konten tidak terlalu menempel ke tepi
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar Column hanya mengambil ruang yang dibutuhkan
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
        crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan konten secara horizontal
        children: [
          // Gambar
          Image.asset(
            'assets/images/ataujadilah.png',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 30), // Spasi antara gambar dan teks

          // Teks pertama
          Text(
            "Atau, jadilah bagian dari kami dan dapatkan komisi",
            textAlign: TextAlign.center, // Rata tengah teks
            style: TextStyle(
              fontFamily: 'SourceSans3', // Gunakan font yang sudah di-load
              fontSize: 20,
              fontWeight: FontWeight.w400, // Weight 400
              color: Color(0xFF705D54), // Warna #705D54
            ),
          ),

          SizedBox(height: 10), // Spasi antara teks pertama dan teks kedua

          // Teks kedua
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

          // 3 Bulatan kecil
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

              // Bulatan 2
              Container(
                width: 10, // Diameter bulatan
                height: 10, // Diameter bulatan
                decoration: BoxDecoration(
                  color: Color(0xFFC4B8B1), // Warna bulatan
                  shape: BoxShape.circle, // Bentuk lingkaran
                ),
              ),

              SizedBox(width: 5), // Jarak antara bulatan

              // Bulatan 3
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
