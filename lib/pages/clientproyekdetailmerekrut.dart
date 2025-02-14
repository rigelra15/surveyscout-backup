import 'package:flutter/material.dart';

void main() {
  runApp(Clientproyekdetailmerekrut());
}

class Clientproyekdetailmerekrut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF2EEE9), // Warna latar belakang
        appBar: AppBar(
          backgroundColor: Color(0xFFD7CCC8),
          toolbarHeight: 80,
          centerTitle: true,
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
        body: Padding(
          padding: EdgeInsets.all(27), // Padding di semua sisi
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Sejajar ke kiri
            mainAxisAlignment: MainAxisAlignment.start, // Tetap di atas
            children: [
              Text(
                'Pengamatan Lalu Lintas di Simpang Lima Semarang',
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
                  color: Color(0xFF826754), // Warna latar belakang container
                  borderRadius: BorderRadius.circular(16), // Membuat sudut melengkung
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Sesuaikan ukuran Container dengan konten
                  children: [
                    Icon(
                      Icons.search, // Ganti dengan ikon sesuai kebutuhan
                      color: Colors.white,
                      size: 14, // Ukuran ikon sesuai teks
                    ),
                    SizedBox(width: 6), // Jarak antara ikon dan teks
                    Text(
                      'Merekrut',
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
                              '10.00 WIB, Kamis, 20 Maret 2025 (2 bulan lagi)',
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
                                  'Simpang Lima, Semarang',
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
                                  'Rp 500.000',
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
                            '20 pelamar telah mendaftar',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: "NunitoSans",
                              color: Color(0xFFA3948D),
                            ),
                          ),
                          SizedBox(height: 4),
                          Wrap(
                            children: [
                              Text(
                                'Tinjau pengalaman mereka atau mulai chat untuk screening',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NunitoSans",
                                  color: Color(0xFFA3948D),
                                ),

                              ),
                            ],
                          ),

                          SizedBox(height: 4),
                          Wrap(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Opsional untuk memberi ruang dalam kontainer
                                decoration: BoxDecoration(
                                  color: Colors.white, // Sesuaikan warna latar belakang jika perlu
                                  borderRadius: BorderRadius.circular(8), // Opsional untuk sudut melengkung
                                ),
                                child: Text(
                                  'Rp 500.000',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "NunitoSans",
                                    color: Color(0xFFA3948D),
                                  ),

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
            ],
          ),
        ),
      ),

    );
  }
}