import 'package:flutter/material.dart';
import 'surveyormyprojects.dart';
import 'surveyorchat.dart';
import 'surveyorakun.dart';


class SurveyorProjects extends StatefulWidget {
  @override
  _SurveyorProjects createState() => _SurveyorProjects();
}

class _SurveyorProjects extends State<SurveyorProjects> {
  int activeButton = -1; // Tombol default yang tidak aktif
  bool _isSaved = false;
  bool _isSaved2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFF1E9E5), // Background berwarna #F1E9E5
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95), // Tinggi AppBar diatur menjadi 130
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD7CCC8), // Header berwarna #D7CCC8
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(27.0), // Padding diatur menjadi 27
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TextInput dengan panjang setengah dari layar
                Container(
                  width: (MediaQuery.of(context).size.width-54)*2/3, // Setengah dari lebar layar
                  height: 40, // Tinggi dari kotak teks
                  decoration: BoxDecoration(
                    color: Color(0xFFF1E9E5), // Warna latar belakang
                    borderRadius: BorderRadius.circular(8), // Sudut melengkung
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari dari 100+ proyek...", // Placeholder teks
                      filled: true,
                      fillColor: Color(0xFFF1E9E5), // Warna latar belakang
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // Sudut melengkung
                        borderSide: BorderSide(
                          color: Color(0xFF757575), // Warna border #757575
                          width: 0.1, // Lebar border 0.1px
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xFF705D54), // Warna border tetap saat fokus
                          width: 2.0, // Lebar border saat fokus
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xFF705D54), // Warna border tetap saat tidak fokus
                          width: 1.0, // Lebar border saat tidak fokus
                        ),
                      ),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF826754)), // Ikon pencarian
                      hintStyle: TextStyle(
                        color: Color(0xFFB0B0B0), // Warna teks #B0B0B0
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w300, // Ketebalan font 300
                        fontSize: 14, // Ukuran font 14px
                      ),
                    ),
                  ),
                ),
                // Kotak pertama
                Container(
                  width: 40, // Lebar kotak
                  height: 40, // Tinggi kotak
                  decoration: BoxDecoration(
                    //color: Color(0xFFD9D9D9), // Warna kotak
                    borderRadius: BorderRadius.circular(8), // Sudut melengkung
                    border: Border.all(
                      color: Color(0xFF705D54), // Warna border
                      width: 1, // Lebar border
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/caridari100.png', // Ganti dengan path gambar Anda
                      width: 24, // Lebar gambar
                      height: 24, // Tinggi gambar
                      fit: BoxFit.contain, // Agar gambar sesuai
                    ),
                  ),
                ),

                // Kotak kedua
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSaved = !_isSaved; // Toggle status saat diklik
                    });
                  },
                  child: Container(
                    width: 40, // Lebar kotak
                    height: 40, // Tinggi kotak
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // Sudut melengkung
                      border: Border.all(
                        color: Color(0xFF705D54), // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _isSaved ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah
                        color: Color(0xFF705D54), // Warna ikon
                        size: 24, // Ukuran ikon
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF2EEE9),
        child: SingleChildScrollView(

          child: Align(

            alignment: Alignment.topCenter, // Menempatkan kontainer di bagian atas
            child: Container(
              color: const Color(0xFFF2EEE9),

              padding: EdgeInsets.all(27),
              //color: Colors.grey[200], // Warna background Container utama
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Border radius 8
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  height: 60, // Tinggi container
                                  padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                                  child: Text(
                                    "Pengamatan Lalu Lintas di Simpang Lima Semarang",
                                    maxLines: 2, // Maksimal hanya 2 baris
                                    overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                                    style: TextStyle(
                                      color: Color(0xFF705D54), // Warna teks
                                      fontSize: 16, // Ukuran font
                                      fontWeight: FontWeight.w700, // Tebal teks
                                      fontFamily: "SourceSans3",
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSaved2 = !_isSaved2; // Toggle status saat diklik
                                  });
                                },
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  width: 50, // Lebar kotak
                                  height: 60, // Tinggi kotak
                                  child: Center(
                                    child: Icon(
                                      _isSaved2 ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah
                                      color: Color(0xFF705D54), // Warna ikon
                                      size: 30, // Ukuran ikon
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              Container(
                                width: 50,
                                //color: Colors.red,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/titik32.png', // Ganti dengan path gambar Anda
                                    width: 24, // Lebar gambar
                                    height: 24, // Tinggi gambar
                                    fit: BoxFit.contain, // Agar gambar sesuai
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.red, // Warna background
                          height: 70, // Tinggi container
                          padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                          child: Text(
                            "Surveyor diminta untuk mencatat jumlah kendaraan yang melewati Simpang Lima selama jam sibuk (07:00-09:00 dan 16:00-18:00). Data akan digunakan untuk analisis kepadatan lalu lintas guna mendukung rencana pembangunan jalan baru.",
                            maxLines: 3, // Maksimal hanya 3 baris
                            overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                            style: TextStyle(
                              color: Color(0xFFA3948D), // Warna teks
                              fontSize: 12, // Ukuran font
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),


                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: SizedBox(
                            width: double.infinity, // Memberikan batasan lebar
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan elemen dengan jarak yang sama
                              children: [
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/2bulanlagi2.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "2 bulan lagi",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/semarang.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Semarang",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A7C59),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/limaratus.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Rp 500.000",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Border radius 8
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  height: 60, // Tinggi container
                                  padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                                  child: Text(
                                    "Survei Kepuasan Pelanggan Restoran Cepat Saji",
                                    maxLines: 2, // Maksimal hanya 2 baris
                                    overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                                    style: TextStyle(
                                      color: Color(0xFF705D54), // Warna teks
                                      fontSize: 16, // Ukuran font
                                      fontWeight: FontWeight.w700, // Tebal teks
                                      fontFamily: "SourceSans3",
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSaved2 = !_isSaved2; // Toggle status saat diklik
                                  });
                                },
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  width: 50, // Lebar kotak
                                  height: 60, // Tinggi kotak
                                  child: Center(
                                    child: Icon(
                                      _isSaved2 ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah
                                      color: Color(0xFF705D54), // Warna ikon
                                      size: 30, // Ukuran ikon
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              Container(
                                width: 50,
                                //color: Colors.red,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/titik32.png', // Ganti dengan path gambar Anda
                                    width: 24, // Lebar gambar
                                    height: 24, // Tinggi gambar
                                    fit: BoxFit.contain, // Agar gambar sesuai
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.red, // Warna background
                          height: 70, // Tinggi container
                          padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                          child: Text(
                            "Surveyor akan mengumpulkan data dari pelanggan di restoran cepat saji mengenai pengalaman mereka. Survei meliputi aspek seperti pelayanan, kebersihan, dan kualitas makanan.",
                            maxLines: 3, // Maksimal hanya 3 baris
                            overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                            style: TextStyle(
                              color: Color(0xFFA3948D), // Warna teks
                              fontSize: 12, // Ukuran font
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),


                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: SizedBox(
                            width: double.infinity, // Memberikan batasan lebar
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan elemen dengan jarak yang sama
                              children: [
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF44336),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/2bulanlagi2.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "20 hari lagi",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/semarang.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Jakarta Sel.",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A7C59),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/limaratus.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Rp 750.000",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Border radius 8
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  height: 60, // Tinggi container
                                  padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                                  child: Text(
                                    "Pemantauan Kualitas Udara di Wilayah Industri Bekasi",
                                    maxLines: 2, // Maksimal hanya 2 baris
                                    overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                                    style: TextStyle(
                                      color: Color(0xFF705D54), // Warna teks
                                      fontSize: 16, // Ukuran font
                                      fontWeight: FontWeight.w700, // Tebal teks
                                      fontFamily: "SourceSans3",
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSaved2 = !_isSaved2; // Toggle status saat diklik
                                  });
                                },
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  width: 50, // Lebar kotak
                                  height: 60, // Tinggi kotak
                                  child: Center(
                                    child: Icon(
                                      _isSaved2 ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah
                                      color: Color(0xFF705D54), // Warna ikon
                                      size: 30, // Ukuran ikon
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              Container(
                                width: 50,
                                //color: Colors.red,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/titik32.png', // Ganti dengan path gambar Anda
                                    width: 24, // Lebar gambar
                                    height: 24, // Tinggi gambar
                                    fit: BoxFit.contain, // Agar gambar sesuai
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.red, // Warna background
                          height: 70, // Tinggi container
                          padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                          child: Text(
                            "Surveyor diminta untuk mencatat data kualitas udara (PM2.5, PM10) di beberapa titik pemantauan di area industri Bekasi. Data ini akan digunakan untuk evaluasi lingkungan oleh pemerintah daerah.",
                            maxLines: 3, // Maksimal hanya 3 baris
                            overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                            style: TextStyle(
                              color: Color(0xFFA3948D), // Warna teks
                              fontSize: 12, // Ukuran font
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),


                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: SizedBox(
                            width: double.infinity, // Memberikan batasan lebar
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan elemen dengan jarak yang sama
                              children: [
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/2bulanlagi2.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "1 bulan lagi",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/semarang.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Bekasi",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A7C59),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/limaratus.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Rp 1.000.000",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Border radius 8
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  height: 60, // Tinggi container
                                  padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                                  child: Text(
                                    "Studi Pola Konsumsi Produk Ramah Lingkungan",
                                    maxLines: 2, // Maksimal hanya 2 baris
                                    overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                                    style: TextStyle(
                                      color: Color(0xFF705D54), // Warna teks
                                      fontSize: 16, // Ukuran font
                                      fontWeight: FontWeight.w700, // Tebal teks
                                      fontFamily: "SourceSans3",
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSaved2 = !_isSaved2; // Toggle status saat diklik
                                  });
                                },
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  width: 50, // Lebar kotak
                                  height: 60, // Tinggi kotak
                                  child: Center(
                                    child: Icon(
                                      _isSaved2 ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah
                                      color: Color(0xFF705D54), // Warna ikon
                                      size: 30, // Ukuran ikon
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              Container(
                                width: 50,
                                //color: Colors.red,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/titik32.png', // Ganti dengan path gambar Anda
                                    width: 24, // Lebar gambar
                                    height: 24, // Tinggi gambar
                                    fit: BoxFit.contain, // Agar gambar sesuai
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.red, // Warna background
                          height: 70, // Tinggi container
                          padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                          child: Text(
                            "Surveyor akan melakukan wawancara dengan pelanggan di pusat perbelanjaan terkait minat mereka pada produk ramah lingkungan. Hasil survei akan digunakan untuk strategi pemasaran produk berkelanjutan.",
                            maxLines: 3, // Maksimal hanya 3 baris
                            overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                            style: TextStyle(
                              color: Color(0xFFA3948D), // Warna teks
                              fontSize: 12, // Ukuran font
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),


                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: SizedBox(
                            width: double.infinity, // Memberikan batasan lebar
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan elemen dengan jarak yang sama
                              children: [
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/2bulanlagi2.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "2 bulan lagi",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/semarang.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Semarang",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A7C59),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/limaratus.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Rp 500.000",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Border radius 8
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  height: 60, // Tinggi container
                                  padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                                  child: Text(
                                    "Pemetaan Infrastruktur Jalan di Wilayah Perkotaan",
                                    maxLines: 2, // Maksimal hanya 2 baris
                                    overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                                    style: TextStyle(
                                      color: Color(0xFF705D54), // Warna teks
                                      fontSize: 16, // Ukuran font
                                      fontWeight: FontWeight.w700, // Tebal teks
                                      fontFamily: "SourceSans3",
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSaved2 = !_isSaved2; // Toggle status saat diklik
                                  });
                                },
                                child: Container(
                                  //color: Colors.red, // Warna background
                                  width: 50, // Lebar kotak
                                  height: 60, // Tinggi kotak
                                  child: Center(
                                    child: Icon(
                                      _isSaved2 ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah
                                      color: Color(0xFF705D54), // Warna ikon
                                      size: 30, // Ukuran ikon
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              Container(
                                width: 50,
                                //color: Colors.red,
                                height: 60,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/titik32.png', // Ganti dengan path gambar Anda
                                    width: 24, // Lebar gambar
                                    height: 24, // Tinggi gambar
                                    fit: BoxFit.contain, // Agar gambar sesuai
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.red, // Warna background
                          height: 70, // Tinggi container
                          padding: EdgeInsets.all(8.0), // Padding untuk memberi ruang di dalam container
                          child: Text(
                            "Surveyor ditugaskan untuk mengukur dan mencatat kondisi jalan raya di beberapa kecamatan. Data ini akan membantu dalam perencanaan proyek perbaikan infrastruktur.",
                            maxLines: 3, // Maksimal hanya 3 baris
                            overflow: TextOverflow.ellipsis, // Teks yang kelebihan akan dipotong dengan ...
                            style: TextStyle(
                              color: Color(0xFFA3948D), // Warna teks
                              fontSize: 12, // Ukuran font
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),


                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          //color: Colors.blue,
                          child: SizedBox(
                            width: double.infinity, // Memberikan batasan lebar
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan elemen dengan jarak yang sama
                              children: [
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/2bulanlagi2.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "3 bulan lagi",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA3948D),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/semarang.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Yogyakarta",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A7C59),
                                    borderRadius: BorderRadius.circular(4), // Border radius 8
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran minimum
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          'assets/images/limaratus.png',
                                          height: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Rp 1.200.000",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
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
          ),

        ),
      ),



      bottomNavigationBar:
      Container(
        color: Color(0xffD7CCC8), // Footer berwarna #D7CCC8
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8), // Padding horizontal dan vertikal
        child: GestureDetector(
          onTap: () {
            // Navigasi atau aksi untuk footer
            print("Footer link clicked!");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Jarak antar container dibuat maksimal
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurveyorMyProjects()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/tersedia.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(height: 4), // Memberikan jarak antara gambar dan teks
                      Text(
                        'Tersedia',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NunitoSans',
                          color: Color(0xFF705D54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurveyorMyProjects()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 100,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/proyeksaya.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(height: 4), // Memberikan jarak antara gambar dan teks
                      Text(
                        'Proyek Saya',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NunitoSans',
                          color: Color(0xFFB8ADA5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),




              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurveyorChat()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/chat3.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(height: 4), // Memberikan jarak antara gambar dan teks
                      Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NunitoSans',
                          color: Color(0xFFB8ADA5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurveyorAccount()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/saya.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(height: 4), // Memberikan jarak antara gambar dan teks
                      Text(
                        'Akun',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NunitoSans',
                          color: Color(0xFFB8ADA5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> options, {required String selectedValue, required ValueChanged<String?> onChanged, bool isWide = false}) {
    return Container(
      width: isWide ? 300 : 200, // Conditional width based on isWide parameter
      height: 40, // Set the total height of the dropdown to 40
      child: DropdownButtonFormField<String>(
        isDense: true, // Make the dropdown more compact
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0), // Padding to control internal spacing
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
            borderSide: BorderSide(
              color: Color(0xFF705D54), // Default border color
              width: 1, // Border width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xFF705D54), // Warna border saat fokus
              width: 2.0, // Lebar border saat fokus
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xFF705D54), // Warna border saat tidak fokus
              width: 1.0, // Lebar border saat tidak fokus
            ),
          ),
        ),
        hint: Text(
          hint,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 21.82 / 16, // line-height calculated as ratio of font-size
            decoration: TextDecoration.none, // No underline decoration
            color: Color(0xFF705D54), // Text color
          ),
        ),
        value: selectedValue, // Set the current selected value
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 21.82 / 16,
                decoration: TextDecoration.none,
                color: Color(0xFF705D54), // Text color
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged, // Set the onChanged callback
        icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF705D54)), // Icon color
      ),
    );
  }

  Widget _buildIconBox() {
    return GestureDetector(

      child: Container(
        width: 40,
        height: 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Rounded corners
          border: Border.all(
            color: Color(0xFF705D54), // Border color
            width: 1, // Border width of 1px
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
          crossAxisAlignment: CrossAxisAlignment.start, // Center align horizontally
          children: [
            // Top line (full width)
            Container(
              width: double.infinity, // Max width
              height: 2,
              color: Color(0xFF705D54),
            ),
            SizedBox(height: 4), // Add spacing between lines
            // Middle line (2/3 of the box width)
            Container(
              width: 2 / 3 * 20, // 2/3 width of the box
              height: 2,
              color: Color(0xFF705D54),
            ),
            SizedBox(height: 4), // Add spacing between lines
            // Bottom line (half the width of the box)
            Container(
              width: 1 / 2 * 20, // 1/2 width of the box
              height: 2,
              color: Color(0xFF705D54),
            ),
          ],
        ),
      ),
    );
  }
}