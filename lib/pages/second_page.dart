import 'package:flutter/material.dart';

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
      body: Padding(
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

                    Container(
                      padding: EdgeInsets.all(20), // Jarak padding luar
                      width: double.infinity, // Lebar penuh
                      decoration: BoxDecoration(
                        color: Color(0xFFF44336),
                        borderRadius: BorderRadius.circular(8), // Sudut melengkung
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Bayangan
                            blurRadius: 5, // Radius blur
                            offset: Offset(0, 2), // Posisi bayangan
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Ukuran kolom mengikuti konten
                        children: [
                          // Container atas
                          Container(
                            padding: EdgeInsets.all(16), // Padding luar container
                            width: double.infinity,
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
                                        "Studi Perilaku Konsumen Produk Blue Whale",
                                        style: TextStyle(
                                          fontFamily: 'SourceSans3', // Font-family
                                          fontSize: 24, // Font-size
                                          fontWeight: FontWeight.w400, // Font-weight
                                          color: Color(0xFF705D54), // Warna teks
                                        ),
                                        overflow: TextOverflow.visible, // Agar teks tidak dipotong
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
                                          'assets/images/duaharilalu.png',
                                          height: 24, // Sesuaikan ukuran gambar
                                          width: 24,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(width: 8), // Spasi horizontal antara gambar dan teks
                                      // Teks
                                      Text(
                                        "2 hari lalu",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'NunitoSans',
                                          color: Color(0xFFF44336),
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
                                          "PDF, Excel, Foto, Video",
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
                          // Container bawah
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur jarak antar kotak
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width - 47 * 2) / 2 - 4,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF44336),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft, // Menyelaraskan teks ke kiri
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan teks di dalam column ke kiri
                                      children: [
                                        Text(
                                          "Tenggat pengerjaan ",
                                          style: TextStyle(
                                            fontFamily: 'NunitoSans', // Pastikan font sudah terpasang di project
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700, // Bold
                                            color: Color(0xFFFFFFFF), // Warna putih
                                          ),
                                          textAlign: TextAlign.left, // Rata kiri
                                        ),
                                        SizedBox(height: 4), // Memberi jarak antara dua teks
                                        Text(
                                          "terlewat chat surveyor atau tindaklanjuti.",
                                          style: TextStyle(
                                            fontFamily: 'NunitoSans', // Pastikan font sudah terpasang di project
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400, // Regular
                                            color: Color(0xFFFFFFFF), // Warna putih
                                          ),
                                          textAlign: TextAlign.left, // Rata kiri
                                          overflow: TextOverflow.visible,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 47 * 2) * (1.5 / 5) - 4,
                                  padding: EdgeInsets.all(8), // Menambahkan padding 8 pada kontainer
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDE7E2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/chat.png',
                                        width: 24, // Atur ukuran gambar sesuai kebutuhan
                                        height: 24,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Chat",
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF3A2B24), // Warna teks
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 47 * 2) * (1.5 / 5) - 4,
                                  padding: EdgeInsets.all(8), // Menambahkan padding 8 pada kontainer
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF44336),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/aksi.png',
                                        width: 24, // Atur ukuran gambar sesuai kebutuhan
                                        height: 24,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Aksi",
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFFEDE7E2), // Warna teks
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFFD7CCC8), // Footer berwarna #D7CCC8
        padding: EdgeInsets.symmetric(vertical: 16), // Padding vertikal footer
        child: GestureDetector(
          onTap: () {
            // Navigasi atau aksi untuk footer
            print("Footer link clicked!");
          },
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Sudah punya akun? ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: "Masuk di sini",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
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
