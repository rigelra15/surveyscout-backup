import 'package:flutter/material.dart';
import 'clientchat.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // Variabel untuk menyimpan pilihan dropdown
  String selectedStatus = "Semua status";
  String selectedPeran = "Semua peran";
  String selectedLokasi = "Semua lokasi";
  String selectedKomisi = "Semua komisi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5), // Background berwarna #F1E9E5
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(165), // Tinggi AppBar diatur menjadi 130
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD7CCC8), // Header berwarna #D7CCC8
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(27.0), // Padding diatur menjadi 27
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Search Bar
                Container(
                  height: 40, // Tinggi dari kotak teks
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E9E5), // Warna latar belakang
                      borderRadius: BorderRadius.circular(8), // Sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000), // Warna shadow (semi-transparent hitam)
                          offset: Offset(0, 4), // Posisi shadow (horizontal, vertikal)
                          blurRadius: 4, // Blur radius
                          spreadRadius: 0, // Radius sebaran shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari proyek Anda...", // Placeholder teks
                        filled: true,
                        fillColor: Color(0xFFF1E9E5), // Warna latar belakang
                        contentPadding: const EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // Sudut melengkung
                          borderSide: BorderSide(
                            color: Color(0xFF757575), // Warna border #757575
                            width: 0.1, // Lebar border 0.5px
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
                ),
                SizedBox(height: 17), // Jarak antara Search Bar dan Dropdowns

                // Horizontal Scrollable Dropdowns
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildIconBox(),
                      SizedBox(width: 8), // Spasi antara kotak dan dropdown
                      _buildDropdown("Semua Status", [
                        "Semua status",
                        "Peringatan",
                        "Dikerjakan",
                        "Butuh konfirmasi",
                        "Selesai",
                        "Kadaluwarsa",
                        "Draft",
                        "Menunggu bayar"
                      ], selectedValue: selectedStatus, onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      }),
                      SizedBox(width: 8), // Spasi antar dropdown
                      _buildDropdown("Semua Peran", [
                        "Semua peran",
                        "Surveyor",
                        "Responden"
                      ], selectedValue: selectedPeran, onChanged: (value) {
                        setState(() {
                          selectedPeran = value!;
                        });
                      }),
                      SizedBox(width: 8),
                      _buildDropdown("Semua Lokasi", [
                        "Semua lokasi",
                        "Sidoarjo",
                        "Surabaya"
                      ], selectedValue: selectedLokasi, onChanged: (value) {
                        setState(() {
                          selectedLokasi = value!;
                        });
                      }),
                      SizedBox(width: 8),
                      _buildDropdown("Semua Komisi", [
                        "Semua komisi",
                        "0 - 100.000 rupiah",
                        "100.000 - 200.000 rupiah",
                        "200.000 - 500.000 rupiah",
                        "500.000 - 1.000.000 rupiah",
                        "1.000.000 - 5.000.000 rupiah",
                        "5.000.000 - 10.000.000 rupiah",
                        "10.000.000 - 20.000.000 rupiah",
                        "20.000.000 - 30.000.000 rupiah",
                        "> 30.000.000 rupiah"
                      ], selectedValue: selectedKomisi, onChanged: (value) {
                        setState(() {
                          selectedKomisi = value!;
                        });
                      }, isWide: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10),

                          Container(
                            width: double.infinity, // Frame will stretch across the available width
                            height: 100, // Set height for the frame
                            padding: EdgeInsets.all(0), // No padding inside the frame
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Evenly space the boxes
                              children: [
                                // First box with two smaller boxes inside
                                Container(
                                  width: (MediaQuery.of(context).size.width - 54) / 4, // Dynamic width based on screen width
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start, // Space between top and bottom boxes
                                    children: [
                                      // Top box with padding and two smaller boxes inside
                                      Container(

                                        width: double.infinity, // Max width
                                        height: 50, // Height of top box
                                        padding: EdgeInsets.only(top: 10), // Padding for the top box
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the two boxes inside the top box
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerRight, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Image.asset(
                                                  'assets/images/dikerjakan.png', // Gambar yang akan ditampilkan
                                                  fit: BoxFit.contain, // Sesuaikan ukuran gambar
                                                  width: 20, // Atur lebar gambar
                                                  height: 20, // Atur tinggi gambar
                                                ),
                                              ),

                                            ),

                                            Container(
                                              padding: EdgeInsets.all(3),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerLeft, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Text(
                                                  '1', // Teks yang ditampilkan
                                                  style: TextStyle(
                                                    fontFamily: 'SourceSans3',
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,

                                                    decoration: TextDecoration.none, // Tidak ada dekorasi tambahan
                                                    color: Color(0xFF705D54), // Warna teks
                                                  ),
                                                  textAlign: TextAlign.left, // Teks diratakan ke kanan
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bottom box with text centered inside
                                      Container(
                                        width: double.infinity, // Max width
                                        height: 20, // Bottom box height

                                        child: Center(
                                          child: Text(
                                            'Merekrut', // Text to display in the bottom box
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              height: 16.37 / 12, // Line height calculation
                                              decorationColor: Color(0xFFA3948D),
                                              decorationStyle: TextDecorationStyle.solid,
                                              color: Color(0xFFA3948D),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Second box with two smaller boxes inside
                                Container(
                                  width: (MediaQuery.of(context).size.width - 54) / 4, // Dynamic width based on screen width
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start, // Space between top and bottom boxes
                                    children: [
                                      // Top box with padding and two smaller boxes inside
                                      Container(

                                        width: double.infinity, // Max width
                                        height: 50, // Height of top box
                                        padding: EdgeInsets.only(top: 10), // Padding for the top box
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the two boxes inside the top box
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerRight, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Image.asset(
                                                  'assets/images/merekrut.png', // Gambar yang akan ditampilkan
                                                  fit: BoxFit.contain, // Sesuaikan ukuran gambar
                                                  width: 20, // Atur lebar gambar
                                                  height: 20, // Atur tinggi gambar
                                                ),
                                              ),

                                            ),

                                            Container(
                                              padding: EdgeInsets.all(3),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerLeft, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Text(
                                                  '1', // Teks yang ditampilkan
                                                  style: TextStyle(
                                                    fontFamily: 'SourceSans3',
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,

                                                    decoration: TextDecoration.none, // Tidak ada dekorasi tambahan
                                                    color: Color(0xFF705D54), // Warna teks
                                                  ),
                                                  textAlign: TextAlign.left, // Teks diratakan ke kanan
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bottom box with text centered inside
                                      Container(
                                        width: double.infinity, // Max width
                                        height: 20, // Bottom box height

                                        child: Center(
                                          child: Text(
                                            'Dikerjakan', // Text to display in the bottom box
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              height: 16.37 / 12, // Line height calculation
                                              decorationColor: Color(0xFFA3948D),
                                              decorationStyle: TextDecorationStyle.solid,
                                              color: Color(0xFFA3948D),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Third box with two smaller boxes inside
                                Container(
                                  width: (MediaQuery.of(context).size.width - 54) / 4, // Dynamic width based on screen width
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start, // Space between top and bottom boxes
                                    children: [
                                      // Top box with padding and two smaller boxes inside
                                      Container(

                                        width: double.infinity, // Max width
                                        height: 50, // Height of top box
                                        padding: EdgeInsets.only(top: 10), // Padding for the top box
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the two boxes inside the top box
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerRight, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Image.asset(
                                                  'assets/images/butuhtinjau.png', // Gambar yang akan ditampilkan
                                                  fit: BoxFit.contain, // Sesuaikan ukuran gambar
                                                  width: 20, // Atur lebar gambar
                                                  height: 20, // Atur tinggi gambar
                                                ),
                                              ),

                                            ),

                                            Container(
                                              padding: EdgeInsets.all(3),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerLeft, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Text(
                                                  '1', // Teks yang ditampilkan
                                                  style: TextStyle(
                                                    fontFamily: 'SourceSans3',
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,

                                                    decoration: TextDecoration.none, // Tidak ada dekorasi tambahan
                                                    color: Color(0xFF705D54), // Warna teks
                                                  ),
                                                  textAlign: TextAlign.left, // Teks diratakan ke kanan
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bottom box with text centered inside
                                      Container(
                                        width: double.infinity, // Max width
                                        height: 20, // Bottom box height

                                        child: Center(
                                          child: Text(
                                            'Butuh Tinjau', // Text to display in the bottom box
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              height: 16.37 / 12, // Line height calculation
                                              decorationColor: Color(0xFFA3948D),
                                              decorationStyle: TextDecorationStyle.solid,
                                              color: Color(0xFFA3948D),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Fourth box with two smaller boxes inside
                                Container(
                                  width: (MediaQuery.of(context).size.width - 54) / 4, // Dynamic width based on screen width
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start, // Space between top and bottom boxes
                                    children: [
                                      // Top box with padding and two smaller boxes inside
                                      Container(

                                        width: double.infinity, // Max width
                                        height: 50, // Height of top box
                                        padding: EdgeInsets.only(top: 10), // Padding for the top box
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the two boxes inside the top box
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerRight, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Image.asset(
                                                  'assets/images/selesai.png', // Gambar yang akan ditampilkan
                                                  fit: BoxFit.contain, // Sesuaikan ukuran gambar
                                                  width: 20, // Atur lebar gambar
                                                  height: 20, // Atur tinggi gambar
                                                ),
                                              ),

                                            ),

                                            Container(
                                              padding: EdgeInsets.all(3),
                                              width: (MediaQuery.of(context).size.width - 54) / 8, // Each inner box takes up max width
                                              height: double.infinity,
                                              // color: Colors.red, // Set color for visibility

                                              child: Align(
                                                alignment: Alignment.centerLeft, // Pusatkan secara vertikal, rata kanan secara horizontal
                                                child: Text(
                                                  '3', // Teks yang ditampilkan
                                                  style: TextStyle(
                                                    fontFamily: 'SourceSans3',
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,

                                                    decoration: TextDecoration.none, // Tidak ada dekorasi tambahan
                                                    color: Color(0xFF705D54), // Warna teks
                                                  ),
                                                  textAlign: TextAlign.left, // Teks diratakan ke kanan
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bottom box with text centered inside
                                      Container(
                                        width: double.infinity, // Max width
                                        height: 20, // Bottom box height

                                        child: Center(
                                          child: Text(
                                            'Selesai', // Text to display in the bottom box
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              height: 16.37 / 12, // Line height calculation
                                              decorationColor: Color(0xFFA3948D),
                                              decorationStyle: TextDecorationStyle.solid,
                                              color: Color(0xFFA3948D),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              // Kontainer utama
                              Container(
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF44336), // Warna utama
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1), // Bayangan
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Container atas
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEDE7E2), // Warna sekunder
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        children: [
                                          // Konten utama (Text dan lainnya)
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Kotak 1
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "Studi Perilaku Konsumen Produk Blue Whale",
                                                    style: TextStyle(
                                                      fontFamily: 'SourceSans3',
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF705D54), // Warna teks
                                                    ),
                                                    maxLines: 3, // Membatasi teks hanya satu baris
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8), // Spasi antar konten
                                              // Kotak 2
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/duaharilalu.png',
                                                    height: 24,
                                                    width: 24,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    "2 hari lalu",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'NunitoSans',
                                                      color: Color(0xFFF44336), // Warna utama
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              // Kotak 3
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/pdfexcel.png',
                                                    height: 24,
                                                    width: 24,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Flexible(
                                                    child: Text(
                                                      "PDF, Excel, Foto, Video",
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
                                            ],
                                          ),
                                          // Gambar gradienmerah.png di kanan bawah

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    // Container bawah
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF44336), // Warna utama
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: (MediaQuery.of(context).size.width - 47 * 2) * (2 / 5) - 4,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Tenggat pengerjaan",
                                                  style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  "terlewat chat surveyor atau tindaklanjuti.",
                                                  style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context).size.width - 47 * 2) * (1.5 / 5) - 4,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEDE7E2), // Warna sekunder
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/images/chat.png',
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                Text(
                                                  "Chat",
                                                  style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF3A2B24),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context).size.width - 47 * 2) * (1.5 / 5) - 4,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF44336), // Warna utama
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Color(0xFFEDE7E2), // Warna sekunder
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/images/aksi.png',
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                Text(
                                                  "Aksi",
                                                  style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFFEDE7E2), // Warna sekunder
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
                              Positioned(
                                top: 0, // Gambar keluar dari bawah kontainer
                                right: 0,  // Gambar keluar dari kanan kontainer
                                child: Image.asset(
                                  'assets/images/gradienmerah.png',
                                  height: 300, // Ukuran gambar (sesuaikan sesuai kebutuhan)
                                  width: 300,  // Ukuran gambar (sesuaikan sesuai kebutuhan)
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF44336),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20), // Kiri bawah dengan radius 20
                                      bottomRight: Radius.zero,        // Kanan bawah tanpa radius
                                      topLeft: Radius.zero,            // Kiri atas tanpa radius
                                      topRight: Radius.zero,           // Kanan atas tanpa radius
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10), // Padding kanan dan kiri sebanyak 5
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran Row sesuai kontennya
                                      children: [
                                        Image.asset(
                                          'assets/images/peringatan.png', // Path ke file gambar
                                          width: 16, // Sesuaikan ukuran gambar
                                          height: 16, // Sesuaikan ukuran gambar
                                        ),
                                        const SizedBox(width: 8), // Jarak antara gambar dan teks
                                        Text(
                                          "Peringatan",
                                          style: TextStyle(
                                            fontFamily: 'NunitoSans', // Mengatur font-family
                                            fontSize: 12, // Ukuran font 12px
                                            fontWeight: FontWeight.w400, // Berat font 400 (normal)
                                            color: Colors.white, // Warna teks putih
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ),
                            ],
                          ),
                          //KONTAINER KEDUA
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(20), // Jarak padding luar
                            width: double.infinity, // Lebar penuh
                            decoration: BoxDecoration(
                              color: Color(0xFFEDE7E2),
                              borderRadius: BorderRadius.circular(8), // Sudut melengkung

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
                                              "Pengamatan Lalu Lintas di Simpang Lima Semarang",
                                              style: TextStyle(
                                                fontFamily: 'SourceSans3', // Font-family
                                                fontSize: 24, // Font-size
                                                fontWeight: FontWeight.w400, // Font-weight
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
                                                'assets/images/2bulanlagi.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Text(
                                              "2 bulan lagi",
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
                                                'assets/images/pdfexcel.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Flexible(
                                              child: Text(
                                                "PDF, Excel",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: (MediaQuery.of(context).size.width - 27 * 2) * (1 / 3) - 4,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          //color: Color(0xFFFF9800),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Stack(
                                            clipBehavior: Clip.hardEdge,
                                            children: List.generate(4, (index) {
                                              List<Color> colors = [
                                                Color(0x1F625B71), // hijau 0
                                                Color(0xFFF44336), // merah 1
                                                Color(0xFF2196F3), // biru 2
                                                Color(0xFFFFEB3B), // kuning 3
                                              ];

                                              return Positioned(
                                                right: (index == 0)
                                                    ? 0.0
                                                    : (index == 1)
                                                    ? 29.0
                                                    : (index == 2)
                                                    ? 39.0
                                                    : 49.0,
                                                top: 0,
                                                child: index == 0
                                                    ? Container(
                                                  width: 80,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: colors[index],
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.circular(22),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      // Tulisan "20" rata kanan
                                                      Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(right: 8), // Jarak ke sisi kanan
                                                          child: Text(
                                                            "20",
                                                            style: TextStyle(
                                                              fontFamily: 'NunitoSans', // Font-family
                                                              fontSize: 12, // Ukuran font tulisan
                                                              fontWeight: FontWeight.w700, // Gaya font
                                                              color: Color(0xFF826754), // Warna teks
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                    : Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x66000000), // #00000040
                                                        offset: Offset(4, 0), // 4px horizontal offset
                                                        blurRadius: 4, // Blur radius
                                                      ),
                                                    ],
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor: colors[index],
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        index == 1
                                                            ? 'assets/images/surveyscout1.png'
                                                            : index == 2
                                                            ? 'assets/images/surveyscout1.png'
                                                            : index == 3
                                                            ? 'assets/images/surveyscout1.png'
                                                            : '',
                                                        width: 44,
                                                        height: 44,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: (MediaQuery.of(context).size.width - 27 * 2) * (1 / 3) - 4,
                                        padding: EdgeInsets.all(0), // Menambahkan padding 8 pada kontainer
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end, // Memindahkan teks ke kanan
                                          crossAxisAlignment: CrossAxisAlignment.start, // Memastikan teks berada di atas
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Lowongan dibuka",
                                                style: TextStyle(
                                                  fontFamily: 'NunitoSans',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF3A2B24), // Warna teks
                                                ),
                                                overflow: TextOverflow.visible, // Biarkan teks melanjutkan jika tidak ada cukup ruang
                                                softWrap: true, // Membuat teks bisa turun baris
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),

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
                                                  'assets/images/taskantor.png',
                                                  width: 21, // Ukuran gambar dalam lingkaran (sesuaikan jika perlu)
                                                  height: 21,
                                                  fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
                                                ),
                                              ),
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

                          //KONTAINER KETIGA
                          SizedBox(height: 8),
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
                                              "Kepuasan Pengguna Transportasi Umum di Jakarta",
                                              style: TextStyle(
                                                fontFamily: 'SourceSans3', // Font-family
                                                fontSize: 24, // Font-size
                                                fontWeight: FontWeight.w400, // Font-weight
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
                                                'assets/images/2bulanlagi.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Text(
                                              "1 bulan lagi",
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
                                                'assets/images/pdfexcel.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Flexible(
                                              child: Text(
                                                "Excel",
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
                                              "Dikerjakan",
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

                          //KONTAINER KEEMPAT
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(2), // Padding sebesar 3
                            decoration: BoxDecoration(
                              color: Color(0xFF826754), // Warna latar belakang (#826754)
                              borderRadius: BorderRadius.circular(8), // Sudut melengkung
                            ),
                            width: double.infinity,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start, // Jarak rata antar kontainer
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
                                                      "Studi Perilaku Mahasiswa Akhir Tahun di Jakarta",
                                                      style: TextStyle(
                                                        fontFamily: 'SourceSans3', // Font-family
                                                        fontSize: 24, // Font-size
                                                        fontWeight: FontWeight.w400, // Font-weight
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
                                                        'assets/images/2bulanlagi.png',
                                                        height: 24, // Sesuaikan ukuran gambar
                                                        width: 24,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                                    // Teks
                                                    Text(
                                                      "Hari Ini",
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
                                                        'assets/images/pdfexcel.png',
                                                        height: 24, // Sesuaikan ukuran gambar
                                                        width: 24,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                                    // Teks
                                                    Flexible(
                                                      child: Text(
                                                        "Excel",
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
                                                  color: Color(0xFFFFC107), // Warna background #FF9800
                                                  borderRadius: BorderRadius.circular(16), // Border radius 16
                                                ),
                                                child: Wrap(
                                                  alignment: WrapAlignment.start, // Menyusun elemen dari kiri
                                                  spacing: 8, // Jarak horizontal antara gambar dan teks
                                                  runSpacing: 4, // Jarak antar baris
                                                  children: [
                                                    // Gambar di sisi kiri
                                                    Image.asset(
                                                      'assets/images/butuhtinjau2.png', // Gambar yang ingin ditampilkan
                                                      width: 15, // Ukuran gambar, sesuaikan dengan kebutuhan
                                                      height: 15,
                                                    ),

                                                    // Teks di sisi kanan
                                                    Text(
                                                      "Butuh Tinjau",
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
                                  Container(
                                    //color: Colors.green, // Warna kontainer kedua
                                    width: double.infinity, // Lebar penuh
                                    padding: EdgeInsets.all(8), // Padding kiri dan kanan
                                    child: Center(
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 4, // Jarak antar teks
                                        children: [
                                          Text(
                                            'Konfirmasi', // Teks "Konfirmasi"
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF), // Warna teks putih
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              height: 14.4 / 12, // Line height (14.4px dibagi font size)
                                              decoration: TextDecoration.underline,
                                              decorationStyle: TextDecorationStyle.solid,
                                              decorationColor: Color(0xFFFFFFFF),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'luaran atau ajukan revisi dalam 3 hari ke depan', // Teks kedua
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF), // Warna teks putih
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              height: 14.4 / 12, // Line height
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                            ),
                          ),

                          //KONTAINER KELIMA
                          SizedBox(height: 8),
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
                                              "Studi Perilaku Mahasiswa Akhir Tahun di Surabaya",
                                              style: TextStyle(
                                                fontFamily: 'SourceSans3', // Font-family
                                                fontSize: 24, // Font-size
                                                fontWeight: FontWeight.w400, // Font-weight
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
                                                'assets/images/2bulanlagi.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Text(
                                              "1 hari lalu",
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
                                                'assets/images/pdfexcel.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Flexible(
                                              child: Text(
                                                "Excel",
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
                                              'assets/images/selesai2.png', // Gambar yang ingin ditampilkan
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
                                                      'assets/images/download.png',
                                                      width: 21, // Ukuran gambar dalam lingkaran utama
                                                      height: 21,
                                                      fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
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

                          //KONTAINER KEENAM
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(2), // Padding sebesar 3
                            decoration: BoxDecoration(
                              color: Color(0xFF826754), // Warna latar belakang (#826754)
                              borderRadius: BorderRadius.circular(8), // Sudut melengkung
                            ),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start, // Jarak rata antar kontainer
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
                                                    "Studi Preferensi Konsumen terhadap Produk Ramah Lingkungan",
                                                    style: TextStyle(
                                                      fontFamily: 'SourceSans3', // Font-family
                                                      fontSize: 24, // Font-size
                                                      fontWeight: FontWeight.w400, // Font-weight
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
                                                      'assets/images/2bulanlagi.png',
                                                      height: 24, // Sesuaikan ukuran gambar
                                                      width: 24,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                                  // Teks
                                                  Expanded(  // Wrap the Text widget with Expanded
                                                    child: Text(
                                                      "Seminggu lalu",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily: 'NunitoSans',
                                                        color: Color(0xFFA3948D),
                                                      ),
                                                      softWrap: true,
                                                      overflow: TextOverflow.ellipsis,
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
                                                      'assets/images/pdfexcel.png',
                                                      height: 24, // Sesuaikan ukuran gambar
                                                      width: 24,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                                  // Teks
                                                  Flexible(
                                                    child: Text(
                                                      "Excel",
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
                                                    'assets/images/selesai2.png', // Gambar yang ingin ditampilkan
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
                                                            'assets/images/download.png',
                                                            width: 21, // Ukuran gambar dalam lingkaran utama
                                                            height: 21,
                                                            fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
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
                                Container(
                                  width: double.infinity, // Lebar penuh
                                  padding: EdgeInsets.all(8), // Padding untuk kontainer utama
                                  child: Column(
                                    children: [
                                      // Kontainer atas
                                      Container(
                                        width: double.infinity, // Lebar penuh

                                        child: Center(
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            spacing: 4, // Jarak antar teks
                                            children: [
                                              Text(
                                                'Berikan penilaian terhadap surveyor', // Teks "Konfirmasi"
                                                style: TextStyle(
                                                  color: Color(0xFFFFFFFF), // Warna teks putih
                                                  fontFamily: 'NunitoSans',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Kontainer bawah
                                      Container(
                                        width: double.infinity, // Lebar penuh
                                        padding: EdgeInsets.all(8), // Padding untuk kontainer
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center, // Menjajarkan bintang di tengah
                                            children: [
                                              Icon(
                                                Icons.star_border_rounded,
                                                size: 30, // Ukuran bintang
                                                color: Color(0xFFD7CCC8), // Warna bintang (border)
                                              ),
                                              SizedBox(width: 3), // Jarak antar bintang
                                              Icon(
                                                Icons.star_border_rounded,
                                                size: 30, // Ukuran bintang
                                                color: Color(0xFFD7CCC8), // Warna bintang (border)
                                              ),
                                              SizedBox(width: 3), // Jarak antar bintang
                                              Icon(
                                                Icons.star_border_rounded,
                                                size: 30, // Ukuran bintang
                                                color: Color(0xFFD7CCC8), // Warna bintang (border)
                                              ),
                                              SizedBox(width: 3), // Jarak antar bintang
                                              Icon(
                                                Icons.star_border_rounded,
                                                size: 30, // Ukuran bintang
                                                color: Color(0xFFD7CCC8), // Warna bintang (border)
                                              ),
                                              SizedBox(width: 3), // Jarak antar bintang
                                              Icon(
                                                Icons.star_border_rounded,
                                                size: 30, // Ukuran bintang
                                                color: Color(0xFFD7CCC8), // Warna bintang (border)
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

                          //KONTAINER KETUJUH
                          SizedBox(height: 8),
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
                                              "Pengamatan Lalu Lintas Bundaran ITS saat Busy Hour",
                                              style: TextStyle(
                                                fontFamily: 'SourceSans3', // Font-family
                                                fontSize: 24, // Font-size
                                                fontWeight: FontWeight.w400, // Font-weight
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
                                                'assets/images/2bulanlagi.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Expanded(  // Wrap the Text widget with Expanded
                                              child: Text(
                                                "Sebulan lalu",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'NunitoSans',
                                                  color: Color(0xFFA3948D),
                                                ),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
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
                                                'assets/images/pdfexcel.png',
                                                height: 24, // Sesuaikan ukuran gambar
                                                width: 24,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                            // Teks
                                            Flexible(
                                              child: Text(
                                                "Excel",
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
                                              'assets/images/selesai2.png', // Gambar yang ingin ditampilkan
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
                                                      'assets/images/download.png',
                                                      width: 21, // Ukuran gambar dalam lingkaran utama
                                                      height: 21,
                                                      fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
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


                          SizedBox(height: 40),

                          Center(
                            child: Container(
                              width: double.infinity, // Atur lebar sesuai kebutuhan
                              child: Center(
                                child: Text(
                                  'Anda memiliki total 7 proyek',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFA3948D), // Warna teks
                                    fontFamily: 'NunitoSans', // Font family
                                    fontSize: 12, // Ukuran font
                                    fontWeight: FontWeight.w400, // Berat font
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),


                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ),
            Positioned(
              bottom: 32,
              right: 32,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF3A2B24), // Warna background
                  borderRadius: BorderRadius.circular(16), // Membuat button bulat
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40000000), // Warna shadow dengan opasitas 40%
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent, // Background dibiarkan transparan
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    print('Custom FAB Terklik!');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white, // Warna ikon
                      ),
                      SizedBox(width: 4), // Gap antara ikon dan teks
                      Text(
                        "Buat Baru",
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none, // Tidak ada dekorasi tambahan
                          color: Color(0xFFffffff),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
                Container(
                  width: 80,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/proyek.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(height: 4), // Memberikan jarak antara gambar dan teks
                      Text(
                        'Proyek',
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
                    // Navigasi ke halaman baru
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Clientchat()), // Ganti dengan nama halaman Anda
                    );
                  },
                  child: Container(
                    width: 80,
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
                            color: Color(0xFFC4B8B1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: 80,
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
                        'Saya',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NunitoSans',
                          color: Color(0xFFC4B8B1),
                        ),
                      ),
                    ],
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
      onTap: () {
        setState(() {
          // Reset the status, role, location, and commission selections when the icon box is tapped
          selectedStatus = "Semua status";
          selectedPeran = "Semua peran";
          selectedLokasi = "Semua lokasi";
          selectedKomisi = "Semua komisi";
        });
      },
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
