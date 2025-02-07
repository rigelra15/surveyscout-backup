import 'package:flutter/material.dart';
import 'second_page.dart'; // Import halaman kedua

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Lebar penuh
        height: double.infinity, // Tinggi penuh
        color: Color(0xFFF1E9E5), // Warna latar belakang
        padding: EdgeInsets.all(27), // Padding 27px
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start, // Mulai dari atas
              crossAxisAlignment: CrossAxisAlignment.center, // Tengahkan elemen secara horizontal
              children: [
                // Logo di atas
                Image.asset(
                  'assets/images/surveyscoutlogo.png',
                  width: 90,
                  height: 40,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 100), // Jarak antar elemen

                Center(
                  child: Container(
                    padding: EdgeInsets.all(16), // Tambahkan padding agar konten tidak terlalu menempel ke tepi
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Agar Column hanya mengambil ruang yang dibutuhkan
                      mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
                      crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan konten secara horizontal
                      children: [
                        // Gambar
                        Image.asset(
                          'assets/images/surveyscout1.png',
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
                  ),
                ),
              ],
            ),

            // Tombol di bagian bawah
            Positioned(
              bottom: 20, // Jarak dari bawah layar
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox(
                      width: double.infinity, // Lebar penuh
                      child: TextButton(
                        onPressed: () {
                          // Aksi yang akan dilakukan saat tombol ditekan
                          print("Tombol ditekan!");
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF3A2B24), // Warna latar belakang tombol (#3A2B24)
                          foregroundColor: Colors.white, // Warna teks tombol
                          padding: EdgeInsets.all(20), // Padding tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Sudut tombol yang melengkung
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum Row
                          children: [
                            Image.asset(
                              'assets/images/google.png', // Path ke gambar
                              height: 17, // Tinggi gambar
                              width: 17, // Lebar gambar
                            ),
                            SizedBox(width: 8), // Jarak antara gambar dan teks
                            Text(
                              "Daftar Dengan Google", // Teks yang ditampilkan di tombol
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
                  SizedBox(height: 16), // Jarak antara tombol dan teks bawah
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman lain
                      print("Navigasi ke halaman login");
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                              color: Color(0xFFa3948d), // Warna teks
                              fontWeight: FontWeight.bold, // Teks tebal
                              decoration: TextDecoration.underline, // Garis bawah
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
}