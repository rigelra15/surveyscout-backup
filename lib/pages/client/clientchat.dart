import 'package:flutter/material.dart';

class ClientChat extends StatefulWidget {
  @override
  _ClientChat createState() => _ClientChat();
}

class _ClientChat extends State<ClientChat> {
  int activeButton = -1;

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
                      borderRadius:
                          BorderRadius.circular(8), // Sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                              0x40000000), // Warna shadow (semi-transparent hitam)
                          offset: Offset(
                              0, 4), // Posisi shadow (horizontal, vertikal)
                          blurRadius: 4, // Blur radius
                          spreadRadius: 0, // Radius sebaran shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari percakapan...", // Placeholder teks
                        filled: true,
                        fillColor: Color(0xFFF1E9E5), // Warna latar belakang
                        contentPadding: const EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Sudut melengkung
                          borderSide: BorderSide(
                            color: Color(0xFF757575), // Warna border #757575
                            width: 0.1, // Lebar border 0.5px
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(
                                0xFF705D54), // Warna border tetap saat fokus
                            width: 2.0, // Lebar border saat fokus
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(
                                0xFF705D54), // Warna border tetap saat tidak fokus
                            width: 1.0, // Lebar border saat tidak fokus
                          ),
                        ),
                        prefixIcon: Icon(Icons.search,
                            color: Color(0xFF826754)), // Ikon pencarian
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: activeButton == 0
                              ? Color(0xFF826754)
                              : Color(0xFFD7CCC8),
                          foregroundColor: activeButton == 0
                              ? Color(0xFFEDE7E2)
                              : Color(0xFF705D54),
                          overlayColor: Colors.transparent, // Hilangkan overlay
                          shadowColor: Colors.transparent, // Hilangkan bayangan
                          elevation: 0, // Elevasi tombol 0
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: activeButton == 0
                                  ? Color(0xFFEDE7E2)
                                  : Color(0xFF705D54),
                              width: 1,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeButton = 0;
                          });
                        },
                        child: Text(
                          "Semua",
                          style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: activeButton == 1
                              ? Color(0xFF826754)
                              : Color(0xFFD7CCC8),
                          foregroundColor: activeButton == 1
                              ? Color(0xFFEDE7E2)
                              : Color(0xFF705D54),
                          overlayColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: activeButton == 1
                                  ? Color(0xFFEDE7E2)
                                  : Color(0xFF705D54),
                              width: 1,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeButton = 1;
                          });
                        },
                        child: Text(
                          "Belum Dibaca",
                          style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: activeButton == 2
                              ? Color(0xFF826754)
                              : Color(0xFFD7CCC8),
                          foregroundColor: activeButton == 2
                              ? Color(0xFFEDE7E2)
                              : Color(0xFF705D54),
                          overlayColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: activeButton == 2
                                  ? Color(0xFFEDE7E2)
                                  : Color(0xFF705D54),
                              width: 1,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeButton = 2;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              activeButton == 2
                                  ? 'assets/images/dikerjakan3.png' // Gambar saat diklik
                                  : 'assets/images/dikerjakan2.png', // Gambar saat tidak diklik
                              width: 24, // Sesuaikan ukuran gambar
                              height: 24, // Sesuaikan ukuran gambar
                            ),
                            SizedBox(width: 8), // Jarak antara gambar dan teks
                            Text(
                              "Dikerjakan",
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: activeButton == 3
                              ? Color(0xFF826754)
                              : Color(0xFFD7CCC8),
                          foregroundColor: activeButton == 3
                              ? Color(0xFFEDE7E2)
                              : Color(0xFF705D54),
                          overlayColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: activeButton == 3
                                  ? Color(0xFFEDE7E2)
                                  : Color(0xFF705D54),
                              width: 1,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeButton = 3;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              activeButton == 3
                                  ? 'assets/images/rekrutmen2.png' // Gambar saat diklik
                                  : 'assets/images/rekrutmen.png', // Gambar saat tidak diklik
                              width: 24, // Sesuaikan ukuran gambar
                              height: 24, // Sesuaikan ukuran gambar
                            ),
                            SizedBox(width: 8), // Jarak antara gambar dan teks
                            Text(
                              "Rekrutmen",
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF2EEE9),
        child: SingleChildScrollView(
          child: Align(
            alignment:
                Alignment.topCenter, // Menempatkan kontainer di bagian atas
            child: Container(
              color: const Color(0xFFF2EEE9),

              padding: EdgeInsets.all(27),
              //color: Colors.grey[200], // Warna background Container utama
              child: Column(
                children: [
                  //herman walton
                  Container(
                    //color: Colors.white24,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KONTEN UTAMA (Kiri)
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Gambar Lingkaran
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/hermanwalton.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Konten Teks
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Baris Pertama
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 24, // Lebar Container
                                                  height:
                                                      24, // Tinggi Container
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    // Untuk menempatkan isi di tengah
                                                    child: Image.asset(
                                                      'assets/images/hermanwalton2.png',
                                                      width: 24, // Lebar gambar
                                                      height:
                                                          24, // Tinggi gambar
                                                      fit: BoxFit
                                                          .contain, // Menyesuaikan gambar dengan area yang tersedia
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Herman Walton".length > 10
                                                        ? "Herman Walton"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Herman Walton",
                                                    style: TextStyle(
                                                      color: Color(0xFF705D54),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 0), // Jarak antar baris
                                        // Baris Kedua
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 24, // Lebar Container
                                                  height:
                                                      24, // Tinggi Container
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    // Untuk menempatkan isi di tengah
                                                    child: Image.asset(
                                                      'assets/images/centang.png',
                                                      width: 24, // Lebar gambar
                                                      height:
                                                          24, // Tinggi gambar
                                                      fit: BoxFit
                                                          .contain, // Menyesuaikan gambar dengan area yang tersedia
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Oke, ditunggu ya, ini nanti untuk linknya zoom.us/InterviewWonderesearch"
                                                                .length >
                                                            10
                                                        ? "Oke, ditunggu ya, ini nanti untuk linknya zoom.us/InterviewWonderesearch"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Oke, ditunggu ya, ini nanti untuk linknya zoom.us/InterviewWonderesearch",
                                                    style: TextStyle(
                                                      color: Color(0xFFA3948D),
                                                      fontFamily: "NunitoSans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
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
                              ],
                            ),
                          ),
                        ),

                        // Elemen Tambahan (Kanan)
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment
                                .topCenter, // Menempatkan konten di bagian atas kiri
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      20), // Tambahkan padding agar tidak terlalu mepet
                              child: Text(
                                "08.00",
                                style: TextStyle(
                                  color: Color(0xFFB8ADA5),
                                  fontSize: 12,
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //bagaskara putra
                  Container(
                    //color: Colors.white24,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KONTEN UTAMA (Kiri)
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Gambar Lingkaran
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/bagaskaraputra.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Konten Teks
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Baris Pertama
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 24, // Lebar Container
                                                  height:
                                                      24, // Tinggi Container
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    // Untuk menempatkan isi di tengah
                                                    child: Image.asset(
                                                      'assets/images/hermanwalton2.png',
                                                      width: 24, // Lebar gambar
                                                      height:
                                                          24, // Tinggi gambar
                                                      fit: BoxFit
                                                          .contain, // Menyesuaikan gambar dengan area yang tersedia
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Bagaskara Putra".length >
                                                            10
                                                        ? "Bagaskara Putra"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Bagaskara Putra",
                                                    style: TextStyle(
                                                      color: Color(0xFF705D54),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 0), // Jarak antar baris
                                        // Baris Kedua
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Baik, Pak/Bu, saya bersedia untuk Zoom interview besok pagi"
                                                                .length >
                                                            10
                                                        ? "Baik, Pak/Bu, saya bersedia untuk Zoom interview besok pagi"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Baik, Pak/Bu, saya bersedia untuk Zoom interview besok pagi",
                                                    style: TextStyle(
                                                      color: Color(0xFFA3948D),
                                                      fontFamily: "NunitoSans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
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
                              ],
                            ),
                          ),
                        ),

                        // Elemen Tambahan (Kanan)
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment
                                .topCenter, // Menempatkan konten di bagian atas kiri
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      20), // Tambahkan padding agar tidak terlalu mepet
                              child: Text(
                                "07.00",
                                style: TextStyle(
                                  color: Color(0xFFB8ADA5),
                                  fontSize: 12,
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //richard santoso
                  Container(
                    //color: Colors.white24,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KONTEN UTAMA (Kiri)
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Gambar Lingkaran
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/richardsantoso2.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Konten Teks
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Baris Pertama
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 24, // Lebar Container
                                                  height:
                                                      24, // Tinggi Container
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    // Untuk menempatkan isi di tengah
                                                    child: Image.asset(
                                                      'assets/images/richardsantoso.png',
                                                      width: 24, // Lebar gambar
                                                      height:
                                                          24, // Tinggi gambar
                                                      fit: BoxFit
                                                          .contain, // Menyesuaikan gambar dengan area yang tersedia
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Richard Santoso".length > 7
                                                        ? "Richard Santoso"
                                                                .substring(
                                                                    0, 7) +
                                                            "..."
                                                        : "Richard Santoso",
                                                    style: TextStyle(
                                                      color: Color(0xFF705D54),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 0), // Jarak antar baris
                                        // Baris Kedua
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Untuk selanjutnya, saya coba untuk ke halte bus yang sebelah utara, Pak. Akan segera saya kabarkan kembali untuk progressnya."
                                                                .length >
                                                            10
                                                        ? "Untuk selanjutnya, saya coba untuk ke halte bus yang sebelah utara, Pak. Akan segera saya kabarkan kembali untuk progressnya."
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Untuk selanjutnya, saya coba untuk ke halte bus yang sebelah utara, Pak. Akan segera saya kabarkan kembali untuk progressnya.",
                                                    style: TextStyle(
                                                      color: Color(0xFFA3948D),
                                                      fontFamily: "NunitoSans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
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
                              ],
                            ),
                          ),
                        ),

                        // Elemen Tambahan (Kanan)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          width: 100, // Lebar utama kontainer
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Kontainer atas
                              Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  //color: Colors.amber, // Warna background kontainer atas
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      0), // Menambahkan padding ke teks
                                  child: Text(
                                    "Kemarin",
                                    textAlign: TextAlign
                                        .end, // Menyelaraskan teks ke tengah
                                    style: TextStyle(
                                      color: Color(0xFFB8ADA5),
                                      fontSize: 12,
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      10), // Memberi jarak antara kontainer atas dan bawah

                              // Kontainer bawah
                              Container(
                                width: 20,
                                height:
                                    20, // Disesuaikan agar lebih proporsional
                                decoration: BoxDecoration(
                                  color: Colors
                                      .red, // Warna background kontainer bawah
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                      color:
                                          Colors.white, // Warna tulisan putih
                                      fontSize:
                                          10, // Ukuran font disesuaikan agar lebih jelas
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //layanan pelanggan
                  Container(
                    //color: Colors.white24,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KONTEN UTAMA (Kiri)
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Gambar Lingkaran
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/layananpelanggan.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Konten Teks
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Baris Pertama
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 24, // Lebar Container
                                                  height:
                                                      24, // Tinggi Container
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    // Untuk menempatkan isi di tengah
                                                    child: Image.asset(
                                                      'assets/images/layananpelanggan2.png',
                                                      width: 24, // Lebar gambar
                                                      height:
                                                          24, // Tinggi gambar
                                                      fit: BoxFit
                                                          .contain, // Menyesuaikan gambar dengan area yang tersedia
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Layanan Pelanggan".length >
                                                            10
                                                        ? "Layanan Pelanggan"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Layanan Pelanggan",
                                                    style: TextStyle(
                                                      color: Color(0xFF705D54),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 0), // Jarak antar baris
                                        // Baris Kedua
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Apabila sudah tidak ada pertanyaan lagi, kami izin menutup percakapan ini. Terima kasih telah menghubungi Layanan Pelanggan SurveyScout!"
                                                                .length >
                                                            10
                                                        ? "Apabila sudah tidak ada pertanyaan lagi, kami izin menutup percakapan ini. Terima kasih telah menghubungi Layanan Pelanggan SurveyScout!"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Apabila sudah tidak ada pertanyaan lagi, kami izin menutup percakapan ini. Terima kasih telah menghubungi Layanan Pelanggan SurveyScout!",
                                                    style: TextStyle(
                                                      color: Color(0xFFA3948D),
                                                      fontFamily: "NunitoSans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
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
                              ],
                            ),
                          ),
                        ),

                        // Elemen Tambahan (Kanan)
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment
                                .topCenter, // Menempatkan konten di bagian atas kiri
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      20), // Tambahkan padding agar tidak terlalu mepet
                              child: Text(
                                "Kemarin",
                                style: TextStyle(
                                  color: Color(0xFFB8ADA5),
                                  fontSize: 12,
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //notifikasi pembayaran
                  Container(
                    //color: Colors.white24,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KONTEN UTAMA (Kiri)
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Gambar Lingkaran
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/notifikasipembayaran.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Konten Teks
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Baris Pertama
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 24, // Lebar Container
                                                  height:
                                                      24, // Tinggi Container
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    // Untuk menempatkan isi di tengah
                                                    child: Image.asset(
                                                      'assets/images/layananpelanggan2.png',
                                                      width: 24, // Lebar gambar
                                                      height:
                                                          24, // Tinggi gambar
                                                      fit: BoxFit
                                                          .contain, // Menyesuaikan gambar dengan area yang tersedia
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Notifikasi Pembayaran"
                                                                .length >
                                                            10
                                                        ? "Notifikasi Pembayaran"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Notifikasi Pembayaran",
                                                    style: TextStyle(
                                                      color: Color(0xFF705D54),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 0), // Jarak antar baris
                                        // Baris Kedua
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 2),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(
                                                    "Pembayaran QRIS Anda untuk “Pengamatan Lalu Lintas di Simpang Lima Semarang” sudah kami terima. Proses rekrutmen untuk proyek tersebut telah dimulai. Terima kasih!"
                                                                .length >
                                                            10
                                                        ? "Pembayaran QRIS Anda untuk “Pengamatan Lalu Lintas di Simpang Lima Semarang” sudah kami terima. Proses rekrutmen untuk proyek tersebut telah dimulai. Terima kasih!"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Pembayaran QRIS Anda untuk “Pengamatan Lalu Lintas di Simpang Lima Semarang” sudah kami terima. Proses rekrutmen untuk proyek tersebut telah dimulai. Terima kasih!",
                                                    style: TextStyle(
                                                      color: Color(0xFFA3948D),
                                                      fontFamily: "NunitoSans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
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
                              ],
                            ),
                          ),
                        ),

                        // Elemen Tambahan (Kanan)
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment
                                .topCenter, // Menempatkan konten di bagian atas kiri
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      20), // Tambahkan padding agar tidak terlalu mepet
                              child: Text(
                                "Kemarin",
                                style: TextStyle(
                                  color: Color(0xFFB8ADA5),
                                  fontSize: 12,
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
    );
  }

  Widget _buildDropdown(String hint, List<String> options,
      {required String selectedValue,
      required ValueChanged<String?> onChanged,
      bool isWide = false}) {
    return Container(
      width: isWide ? 300 : 200, // Conditional width based on isWide parameter
      height: 40, // Set the total height of the dropdown to 40
      child: DropdownButtonFormField<String>(
        isDense: true, // Make the dropdown more compact
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0), // Padding to control internal spacing
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
        icon: Icon(Icons.keyboard_arrow_down,
            color: Color(0xFF705D54)), // Icon color
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
          mainAxisAlignment:
              MainAxisAlignment.center, // Center align vertically
          crossAxisAlignment:
              CrossAxisAlignment.start, // Center align horizontally
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
