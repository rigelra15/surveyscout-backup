import 'package:flutter/material.dart';
import 'package:surveyscout/pages/respondenprojects.dart';
import 'dart:async'; // Import untuk Future.delayed
import 'clientsignup.dart';
import 'surveyorprojects.dart';
import 'respondenprojects.dart';

void main() {
  runApp(Surveyorproyekdetailbutuhtinjau());
}

class Surveyorproyekdetailbutuhtinjau extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF2EEE9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), // Tinggi total AppBar (50 + 10 padding)
          child: Container(
            padding: EdgeInsets.only(top: 20), // Padding atas 10
            color: Color(0xFFD7CCC8), // Warna background AppBar
            child: AppBar(
              backgroundColor: Colors.transparent, // Transparan agar tidak menimpa warna Container
              toolbarHeight: 50,
              centerTitle: true,
              elevation: 0, // Hilangkan shadow agar lebih rapi
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF705D54)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Detail Proyek Survey',
                style: TextStyle(
                  fontFamily: 'NutinoSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF705D54),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(27), // Padding di semua sisi
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Sejajar ke kiri
              mainAxisAlignment: MainAxisAlignment.start, // Tetap di atas
              children: [
                Text(
                  'Kepuasan Pengguna Transportasi Umum di Jakarta',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "SourceSans3",
                    color: Color(0xFF705D54),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10), // Spasi antar elemen
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding dalam container
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC107), // Warna latar belakang container
                    borderRadius: BorderRadius.circular(16), // Membuat sudut melengkung
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Sesuaikan ukuran Container dengan konten
                    children: [
                      Icon(
                        Icons.pause_circle_filled, // Ganti dengan ikon sesuai kebutuhan
                        color: Colors.white,
                        size: 14, // Ukuran ikon sesuai teks
                      ),
                      SizedBox(width: 6), // Jarak antara ikon dan teks
                      Text(
                        'Ditinjau',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NunitoSans",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Diunggah pada 12.31 WIB, Senin, 20 Jan. 2025',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "NunitoSans",
                    color: Color(0xFFA3948D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8), // Padding dalam container
                  decoration: BoxDecoration(
                    color: Color(0xFFA3948D), // Warna latar belakang container
                    borderRadius: BorderRadius.circular(8), // Membuat sudut melengkung
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Sesuaikan ukuran Container dengan konten
                    children: [
                      Icon(
                        Icons.punch_clock_rounded, // Ganti dengan ikon sesuai kebutuhan
                        color: Colors.white,
                        size: 14, // Ukuran ikon sesuai teks
                      ),
                      SizedBox(width: 6), // Jarak antara ikon dan teks
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tenggat Waktu',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "NunitoSans",
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '10.00 WIB, Kamis, 20 Februari 2025 (1 bulan lagi)',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NunitoSans",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width * 4.55/11,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFEDE7E2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max, // Memastikan Row mengikuti lebar Container
                          children: [
                            Icon(Icons.location_on, color: Color(0xFFA3948D), size: 20), // Ikon di kiri
                            SizedBox(width: 8), // Jarak antara ikon dan teks
                            Flexible( // Ganti Expanded dengan Flexible untuk menghindari unbounded width issue
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lokasi Survei',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "NunitoSans",
                                      color: Color(0xFFA3948D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Bundaran HI, Jakarta',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NunitoSans",
                                      color: Color(0xFFA3948D),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 3),
                      Container(
                        width:MediaQuery.of(context).size.width * 4.55/11,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFEDE7E2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max, // Memastikan Row mengikuti lebar Container
                          children: [
                            Icon(Icons.money, color: Color(0xFFA3948D), size: 20), // Ikon di kiri
                            SizedBox(width: 8), // Jarak antara ikon dan teks
                            Flexible( // Ganti Expanded dengan Flexible untuk menghindari unbounded width issue
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Komisi',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "NunitoSans",
                                      color: Color(0xFFA3948D),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Rp 600.000',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NunitoSans",
                                      color: Color(0xFFA3948D),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity, // Lebar penuh
                  height: 1, // Tinggi 1
                  color: Color(0xFFB0B0B0),
                ),
                SizedBox(height: 10),
                Container(
                  width:double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xFFEDE7E2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max, // Memastikan Row mengikuti lebar Container
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/Ellipse 2-2.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            SizedBox(width: 8), // Jarak antara ikon dan teks
                            Flexible( // Ganti Expanded dengan Flexible untuk menghindari unbounded width issue
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Agus Ginting',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "NunitoSans",
                                      color: Color(0xFF705D54),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Klien',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFFA3948D),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.location_on, color: Color(0xFFA3948D), size: 10),
                                      SizedBox(width: 4),
                                      Text(
                                        'Jakarta',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFFA3948D),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.check_circle, color: Color(0xFFA3948D), size: 10),
                                      SizedBox(width: 4),
                                      Text(
                                        'PT Widya Mandiri',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFFA3948D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Anda: ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: "NunitoSans",
                                color: Color(0xFF705D54),
                              ),
                            ),
                            TextSpan(
                              text: 'Untuk selanjutnya, saya coba untuk ke halte bus yang sebelah utara, Pak. Akan segera saya kabarkan ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "NunitoSans",
                                color: Color(0xFF705D54),
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Deskripsi',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "SourceSans3",
                    color: Color(0xFF705D54),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Surveyor diminta untuk mencatat jumlah kendaraan yang melewati Simpang Lima selama jam sibuk (07:00-09:00 dan 16:00-18:00). Data akan digunakan untuk analisis kepadatan lalu lintas guna mendukung rencana pembangunan jalan baru.',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "NunitoSans",
                    color: Color(0xFFA3948D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Kualifikasi',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "SourceSans3",
                    color: Color(0xFF705D54),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tenaga surveyor harus Cermat menghitung kendaraan secara manual, Mampu menggunakan Excel untuk rekap data, Nyaman bekerja di luar ruangan.',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "NunitoSans",
                    color: Color(0xFFA3948D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Luaran',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "SourceSans3",
                    color: Color(0xFF705D54),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Untuk dapat menyelesaikan proyek ini, surveyor diminta memberikan, File Excel berisi rekap jumlah kendaraan berdasarkan kategori (mobil, motor, bus), Foto kondisi simpang lima selama pengamatan.',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "NunitoSans",
                    color: Color(0xFFA3948D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ID #ASD1321',
                        textAlign: TextAlign.center, // Rata tengah
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "NunitoSans",
                          color: Color(0xFFB0B0B0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

              ],
            ),
          ),

        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFF3A2B24),
                ),
                child: Align(
                  alignment: Alignment.topCenter, // Menempatkan isi di atas
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Menghindari Column memenuhi seluruh ruang
                    children: [
                      Text(
                        'Kami telah memberitahu klien bahwa luaran Anda telah selesai. Mohon tunggu verifikasi dalam 3 hari.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'NutinoSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFF1E9E5),

                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF826754),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1E9E5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.chat, color: Color(0xFF826754)),
                          SizedBox(width: 10),
                          Text(
                            'Chat',
                            style: TextStyle(
                              fontFamily: 'NutinoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF826754),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF826754),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFEDE7E2), width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.text_snippet, color: Color(0xFFEDE7E2)),
                          SizedBox(width: 10),
                          Text(
                            'Luaran',
                            style: TextStyle(
                              fontFamily: 'NutinoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFFEDE7E2),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFFB3261E),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "3",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 60,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFF826754),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.more_vert, color: Color(0xFFEDE7E2)),
                      ],
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

  void _showPelamar(BuildContext context) {
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
                // Kontainer kedua
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman SurveyorProjects
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SurveyorProjects()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16), // Padding untuk kontainer
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFD7CCC8), // Warna latar belakang
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/surveyor.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 12), // Spasi antara gambar dan teks
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Surveyor",
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700, // Font tebal
                                  color: Color(0xFF705D54),
                                ),
                              ),
                              const SizedBox(height: 4), // Spasi antara judul dan deskripsi
                              const Text(
                                "Hasilkan uang dengan mencari data dengan wawancara, observasi, dan/atau lainnya hingga merekapnya.",
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 14, // Ukuran font deskripsi lebih kecil
                                  fontWeight: FontWeight.w400, // Font normal
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
                    // Navigasi ke halaman SurveyorProjects
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Respondenprojects()),
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

}