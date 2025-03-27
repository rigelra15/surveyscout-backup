import 'package:flutter/material.dart';

class RespondenChat extends StatefulWidget {
  @override
  _RespondenChat createState() => _RespondenChat();
}

class _RespondenChat extends State<RespondenChat> {
  int activeButton = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(132),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD7CCC8),
          flexibleSpace: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 27.0, vertical: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF1E9E5),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari percakapan...",
                          filled: true,
                          fillColor: Color(0xFFF1E9E5),
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFF757575),
                              width: 0.1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFF705D54),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFF705D54),
                              width: 1.0,
                            ),
                          ),
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xFF826754)),
                          hintStyle: TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 17),
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
                            overlayColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
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
                                    ? 'assets/images/dikerjakan3.png'
                                    : 'assets/images/dikerjakan2.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
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
                                    ? 'assets/images/rekrutmen2.png'
                                    : 'assets/images/rekrutmen.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
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
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF2EEE9),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: const Color(0xFFF2EEE9),

              padding: EdgeInsets.all(27),
              //color: Colors.grey[200],
              child: Column(
                children: [
                  //agus ginting
                  Container(
                    //color: Colors.white24,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/agusginting.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/images/loading.png',
                                                      width: 24,
                                                      height: 24,
                                                      fit: BoxFit.contain,
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
                                                    "Agus Ginting".length > 10
                                                        ? "Agus Ginting"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Agus Ginting",
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
                                        SizedBox(height: 0),
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
                                                    "Mas, ini per kolom excelnya tolong rapikan sesuai format datanya ya, misal kalau angka dijadikan number jangan text, makasih"
                                                                .length >
                                                            10
                                                        ? "Mas, ini per kolom excelnya tolong rapikan sesuai format datanya ya, misal kalau angka dijadikan number jangan text, makasih"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Mas, ini per kolom excelnya tolong rapikan sesuai format datanya ya, misal kalau angka dijadikan number jangan text, makasih",
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
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
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
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/company.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/images/hermanwalton2.png',
                                                      width: 24,
                                                      height: 24,
                                                      fit: BoxFit.contain,
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
                                        SizedBox(height: 0),
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
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/images/centang.png',
                                                      width: 24,
                                                      height: 24,
                                                      fit: BoxFit.contain,
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
                                                    "Berikut ini Pak portofolio pekerjaan saya sebelumnya"
                                                                .length >
                                                            10
                                                        ? "Berikut ini Pak portofolio pekerjaan saya sebelumnya"
                                                                .substring(
                                                                    0, 10) +
                                                            "..."
                                                        : "Berikut ini Pak portofolio pekerjaan saya sebelumnya",
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
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
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

                  //layanan pelanggan
                  Container(
                    //color: Colors.white24,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/images/layananpelanggan2.png',
                                                      width: 24,
                                                      height: 24,
                                                      fit: BoxFit.contain,
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
                                        SizedBox(height: 0),
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
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
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
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/images/layananpelanggan2.png',
                                                      width: 24,
                                                      height: 24,
                                                      fit: BoxFit.contain,
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
                                        SizedBox(height: 0),
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
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "17 Jan",
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
}
