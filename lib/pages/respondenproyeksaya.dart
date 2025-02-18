import 'package:flutter/material.dart';
import 'respondenprojects.dart';
import 'respondenchat.dart';
import 'respondenakun.dart';

class Respondenproyeksaya extends StatefulWidget {
  @override
  _Respondenproyeksaya createState() => _Respondenproyeksaya();
}

class _Respondenproyeksaya extends State<Respondenproyeksaya> {
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
                      hintText: "Cari proyek Anda", // Placeholder teks
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
                      'assets/images/download2.png', // Ganti dengan path gambar Anda
                      width: 24, // Lebar gambar
                      height: 24, // Tinggi gambar
                      fit: BoxFit.contain, // Agar gambar sesuai
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
                    padding: EdgeInsets.all(20), // Jarak padding luar
                    width: double.infinity, // Lebar penuh
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Sudut melengkun
                    ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container kiri
                        Container(
                          padding: EdgeInsets.all(0), // Padding luar container
                          width: (MediaQuery.of(context).size.width - 27 * 2) * (1/2) - 4,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE7E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Ukuran mengikuti konten
                            children: [
                              // Kotak 1
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.zero, // Padding diatur ke 0
                                    child: Text(
                                      "Survei Kepuasan Pengguna Transportasi Umum",
                                      style: TextStyle(
                                        fontFamily: 'SourceSans3', // Font-family
                                        fontSize: 24, // Font-size
                                        fontWeight: FontWeight.w700, // Font-weight
                                        color: Color(0xFF705D54), // Warna teks
                                      ),
                                      maxLines: 3, // Membatasi teks hanya satu baris
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),

                              // Kotak 2
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4), // Padding atas dan bawah 3
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Rata kiri
                                  crossAxisAlignment: CrossAxisAlignment.center, // Vertikal tengah
                                  children: [
                                    // Gambar
                                    Padding(
                                      padding: const EdgeInsets.all(0), // Tambahkan sedikit jarak dari tepi kiri
                                      child: Image.asset(
                                        'assets/images/online.png',
                                        height: 18, // Sesuaikan ukuran gambar
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                    // Teks
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'NunitoSans',
                                        color: Color(0xFFA3948D),
                                      ),
                                      softWrap: true, // Agar teks bisa membungkus
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),

                              // Kotak 3
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4), // Padding atas dan bawah 3
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Rata kiri
                                  crossAxisAlignment: CrossAxisAlignment.center, // Vertikal tengah
                                  children: [
                                    // Gambar
                                    Padding(
                                      padding: const EdgeInsets.all(0), // Tambahkan sedikit jarak dari tepi kiri
                                      child: Image.asset(
                                        'assets/images/uang.png',
                                        height: 18, // Sesuaikan ukuran gambar
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                    // Teks
                                    Flexible(
                                      child: Text(
                                        "Rp. 50.000",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'NunitoSans',
                                          color: Color(0xFFA3948D),
                                        ),
                                        softWrap: true, // Agar teks bisa membungkus
                                        overflow: TextOverflow.visible, // Agar teks tidak dipotong
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 10), // Spasi antar kotak
                        // Container kanan
                        Container(
                          width: (MediaQuery.of(context).size.width - 27 * 2) * (1/3) - 4,
                          decoration: BoxDecoration(
                            //color: Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8), // Menambahkan padding untuk teks di dalam kontainer
                                decoration: BoxDecoration(
                                  color: Color(0xFF2196F3), // Warna background #FF9800
                                  borderRadius: BorderRadius.circular(16), // Border radius 16
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.start, // Menyusun elemen dari kiri
                                  spacing: 8, // Jarak horizontal antara gambar dan teks
                                  runSpacing: 4, // Jarak antar baris
                                  children: [
                                    // Gambar di sisi kiri
                                    Image.asset(
                                      'assets/images/taskantor2.png', // Gambar yang ingin ditampilkan
                                      width: 15, // Ukuran gambar, sesuaikan dengan kebutuhan
                                      height: 15,
                                    ),

                                    // Teks di sisi kanan
                                    Text(
                                      "Mendaftar",
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF), // Warna teks putih (#FFFFFF)
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 100),


                              Container(
                                width: (MediaQuery.of(context).size.width - 27 * 2) * (1 / 2) - 4,
                                padding: EdgeInsets.all(0), // Padding diatur menjadi 0
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end, // Posisi rata kanan
                                  children: [
                                    SizedBox(width: 8), // Gap antar lingkaran
                                    // Lingkaran kedua
                                    Container(
                                      width: 42.2, // Diameter lingkaran
                                      height: 42.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF826754), // Warna border
                                          width: 1, // Ketebalan border 1px
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/titik3.png',
                                          width: 21, // Ukuran gambar dalam lingkaran (sesuaikan jika perlu)
                                          height: 21,
                                          fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
                                        ),
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
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(20), // Jarak padding luar
                    width: double.infinity, // Lebar penuh
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Sudut melengkun
                    ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container kiri
                        Container(
                          padding: EdgeInsets.all(0), // Padding luar container
                          width: (MediaQuery.of(context).size.width - 27 * 2) * (1/2) - 4,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE7E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Ukuran mengikuti konten
                            children: [
                              // Kotak 1
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.zero, // Padding diatur ke 0
                                    child: Text(
                                      "Wawancara Konsumen Produk Skincare",
                                      style: TextStyle(
                                        fontFamily: 'SourceSans3', // Font-family
                                        fontSize: 24, // Font-size
                                        fontWeight: FontWeight.w700, // Font-weight
                                        color: Color(0xFF705D54), // Warna teks
                                      ),
                                      maxLines: 3, // Membatasi teks hanya satu baris
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),

                              // Kotak 2
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4), // Padding atas dan bawah 3
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Rata kiri
                                  crossAxisAlignment: CrossAxisAlignment.center, // Vertikal tengah
                                  children: [
                                    // Gambar
                                    Padding(
                                      padding: const EdgeInsets.all(0), // Tambahkan sedikit jarak dari tepi kiri
                                      child: Image.asset(
                                        'assets/images/online.png',
                                        height: 18, // Sesuaikan ukuran gambar
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                    // Teks
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'NunitoSans',
                                        color: Color(0xFFA3948D),
                                      ),
                                      softWrap: true, // Agar teks bisa membungkus
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),

                              // Kotak 3
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4), // Padding atas dan bawah 3
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Rata kiri
                                  crossAxisAlignment: CrossAxisAlignment.center, // Vertikal tengah
                                  children: [
                                    // Gambar
                                    Padding(
                                      padding: const EdgeInsets.all(0), // Tambahkan sedikit jarak dari tepi kiri
                                      child: Image.asset(
                                        'assets/images/uang.png',
                                        height: 18, // Sesuaikan ukuran gambar
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                    // Teks
                                    Flexible(
                                      child: Text(
                                        "Rp. 75.000",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'NunitoSans',
                                          color: Color(0xFFA3948D),
                                        ),
                                        softWrap: true, // Agar teks bisa membungkus
                                        overflow: TextOverflow.visible, // Agar teks tidak dipotong
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 10), // Spasi antar kotak
                        // Container kanan
                        Container(
                          width: (MediaQuery.of(context).size.width - 27 * 2) * (1/3) - 4,
                          decoration: BoxDecoration(
                            //color: Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8), // Menambahkan padding untuk teks di dalam kontainer
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF9800), // Warna background #FF9800
                                  borderRadius: BorderRadius.circular(16), // Border radius 16
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.start, // Menyusun elemen dari kiri
                                  spacing: 8, // Jarak horizontal antara gambar dan teks
                                  runSpacing: 4, // Jarak antar baris
                                  children: [
                                    // Gambar di sisi kiri
                                    Image.asset(
                                      'assets/images/taskantorjam.png', // Gambar yang ingin ditampilkan
                                      width: 15, // Ukuran gambar, sesuaikan dengan kebutuhan
                                      height: 15,
                                    ),

                                    // Teks di sisi kanan
                                    Text(
                                      "Mengerjakan",
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF), // Warna teks putih (#FFFFFF)
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 100),


                              Container(
                                width: (MediaQuery.of(context).size.width - 27 * 2) * (1 / 2) - 4,
                                padding: EdgeInsets.all(0), // Padding diatur menjadi 0
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end, // Posisi rata kanan
                                  children: [
                                    // Lingkaran pertama
                                    Stack(
                                      alignment: Alignment.center, // Menjaga elemen di tengah
                                      children: [
                                        // Lingkaran utama
                                        Container(
                                          width: 42.2, // Diameter lingkaran utama
                                          height: 42.2,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFF826754), // Warna border
                                              width: 1, // Ketebalan border
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/chat.png',
                                              width: 21, // Ukuran gambar dalam lingkaran utama
                                              height: 21,
                                              fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
                                            ),
                                          ),
                                        ),
                                        // Lingkaran kecil (notifikasi)
                                        Positioned(
                                          top: 0, // Posisi lingkaran kecil di kanan atas
                                          right: 0,
                                          child: Container(
                                            width: 13, // Diameter lingkaran kecil
                                            height: 13,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFB3261E), // Warna lingkaran kecil (notifikasi)
                                              shape: BoxShape.circle, // Membuat lingkaran
                                            ),
                                            child: Center(
                                              child: Text(
                                                "3", // Teks yang ditampilkan di tengah
                                                style: TextStyle(
                                                  fontSize: 8, // Ukuran teks
                                                  color: Colors.white, // Warna teks
                                                  fontWeight: FontWeight.bold, // Tebal teks
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 8), // Gap antar lingkaran
                                    // Lingkaran kedua
                                    Container(
                                      width: 42.2, // Diameter lingkaran
                                      height: 42.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF826754), // Warna border
                                          width: 1, // Ketebalan border 1px
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/titik3.png',
                                          width: 21, // Ukuran gambar dalam lingkaran (sesuaikan jika perlu)
                                          height: 21,
                                          fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
                                        ),
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
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(20), // Jarak padding luar
                    width: double.infinity, // Lebar penuh
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8), // Sudut melengkun
                    ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container kiri
                        Container(
                          padding: EdgeInsets.all(0), // Padding luar container
                          width: (MediaQuery.of(context).size.width - 27 * 2) * (1/2) - 4,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE7E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Ukuran mengikuti konten
                            children: [
                              // Kotak 1
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.zero, // Padding diatur ke 0
                                    child: Text(
                                      "Survei Preferensi Konsumen untuk Produk Ramah Lingkungan",
                                      style: TextStyle(
                                        fontFamily: 'SourceSans3', // Font-family
                                        fontSize: 24, // Font-size
                                        fontWeight: FontWeight.w700, // Font-weight
                                        color: Color(0xFF705D54), // Warna teks
                                      ),
                                      maxLines: 3, // Membatasi teks hanya satu baris
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),

                              // Kotak 2
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4), // Padding atas dan bawah 3
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Rata kiri
                                  crossAxisAlignment: CrossAxisAlignment.center, // Vertikal tengah
                                  children: [
                                    // Gambar
                                    Padding(
                                      padding: const EdgeInsets.all(0), // Tambahkan sedikit jarak dari tepi kiri
                                      child: Image.asset(
                                        'assets/images/online.png',
                                        height: 18, // Sesuaikan ukuran gambar
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                    // Teks
                                    Expanded(
                                      child: Text(
                                        "Jakarta",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'NunitoSans',
                                          color: Color(0xFFA3948D),
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Kotak 3
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4), // Padding atas dan bawah 3
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Rata kiri
                                  crossAxisAlignment: CrossAxisAlignment.center, // Vertikal tengah
                                  children: [
                                    // Gambar
                                    Padding(
                                      padding: const EdgeInsets.all(0), // Tambahkan sedikit jarak dari tepi kiri
                                      child: Image.asset(
                                        'assets/images/uang.png',
                                        height: 18, // Sesuaikan ukuran gambar
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                    // Teks
                                    Flexible(
                                      child: Text(
                                        "Rp. 50.000",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'NunitoSans',
                                          color: Color(0xFFA3948D),
                                        ),
                                        softWrap: true, // Agar teks bisa membungkus
                                        overflow: TextOverflow.visible, // Agar teks tidak dipotong
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 10), // Spasi antar kotak
                        // Container kanan
                        Container(
                          width: (MediaQuery.of(context).size.width - 27 * 2) * (1/3) - 4,
                          decoration: BoxDecoration(
                            //color: Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8), // Menambahkan padding untuk teks di dalam kontainer
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50), // Warna background #FF9800
                                  borderRadius: BorderRadius.circular(16), // Border radius 16
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.start, // Menyusun elemen dari kiri
                                  spacing: 8, // Jarak horizontal antara gambar dan teks
                                  runSpacing: 4, // Jarak antar baris
                                  children: [
                                    // Gambar di sisi kiri
                                    Image.asset(
                                      'assets/images/centang2.png', // Gambar yang ingin ditampilkan
                                      width: 15, // Ukuran gambar, sesuaikan dengan kebutuhan
                                      height: 15,
                                    ),

                                    // Teks di sisi kanan
                                    Text(
                                      "Selesai",
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF), // Warna teks putih (#FFFFFF)
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 100),


                              Container(
                                width: (MediaQuery.of(context).size.width - 27 * 2) * (1 / 2) - 4,
                                padding: EdgeInsets.all(0), // Padding diatur menjadi 0
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end, // Posisi rata kanan
                                  children: [
                                    // Lingkaran pertama
                                    Stack(
                                      alignment: Alignment.center, // Menjaga elemen di tengah
                                      children: [
                                        // Lingkaran utama
                                        Container(
                                          width: 42.2, // Diameter lingkaran utama
                                          height: 42.2,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFF826754), // Warna border
                                              width: 1, // Ketebalan border
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/download2.png',
                                              width: 21, // Ukuran gambar dalam lingkaran utama
                                              height: 21,
                                              fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
                                            ),
                                          ),
                                        ),
                                        // Lingkaran kecil (notifikasi)

                                      ],
                                    ),
                                    SizedBox(width: 8), // Gap antar lingkaran
                                    // Lingkaran kedua
                                    Container(
                                      width: 42.2, // Diameter lingkaran
                                      height: 42.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF826754), // Warna border
                                          width: 1, // Ketebalan border 1px
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/titik3.png',
                                          width: 21, // Ukuran gambar dalam lingkaran (sesuaikan jika perlu)
                                          height: 21,
                                          fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
                                        ),
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
                    MaterialPageRoute(builder: (context) => Respondenprojects()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/tersedia2.png', // Path ke gambar
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
                          color: Color(0xFFB8ADA5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Container(
                width: 100,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi secara vertikal
                  children: [
                    Image.asset(
                      'assets/images/proyeksaya2.png', // Path ke gambar
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
                        color: Color(0xFF705D54),
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Respondenchat()), // Ganti dengan nama halaman Anda
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
                    MaterialPageRoute(builder: (context) => Respondenakun()), // Ganti dengan nama halaman Anda
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