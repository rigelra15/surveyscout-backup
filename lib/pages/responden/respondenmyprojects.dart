import 'package:flutter/material.dart';

class RespondenMyProjects extends StatefulWidget {
  @override
  _RespondenMyProjects createState() => _RespondenMyProjects();
}

class _RespondenMyProjects extends State<RespondenMyProjects> {
  int activeButton = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD7CCC8),
          flexibleSpace: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 27.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 54) * 2 / 3,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E9E5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari proyek Anda",
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      //color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFF705D54),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/caridari100.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      //color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFF705D54),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/download2.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
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
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          width: (MediaQuery.of(context).size.width - 27 * 2) *
                                  (1 / 2) -
                              4,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE7E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      "Survei Kepuasan Pengguna Transportasi Umum",
                                      style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF705D54),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset(
                                        'assets/images/online.png',
                                        height: 18,
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'NunitoSans',
                                        color: Color(0xFFA3948D),
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset(
                                        'assets/images/uang.png',
                                        height: 18,
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        "Rp. 50.000",
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
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: (MediaQuery.of(context).size.width - 27 * 2) *
                                  (1 / 3) -
                              4,
                          decoration: BoxDecoration(
                            //color: Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2196F3),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    Image.asset(
                                      'assets/images/taskantor2.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                    Text(
                                      "Mendaftar",
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 100),
                              Container(
                                width: (MediaQuery.of(context).size.width -
                                            27 * 2) *
                                        (1 / 2) -
                                    4,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(width: 8),
                                    Container(
                                      width: 42.2,
                                      height: 42.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF826754),
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/titik3.png',
                                          width: 21,
                                          height: 21,
                                          fit: BoxFit.contain,
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
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          width: (MediaQuery.of(context).size.width - 27 * 2) *
                                  (1 / 2) -
                              4,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE7E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      "Wawancara Konsumen Produk Skincare",
                                      style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF705D54),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset(
                                        'assets/images/online.png',
                                        height: 18,
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'NunitoSans',
                                        color: Color(0xFFA3948D),
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset(
                                        'assets/images/uang.png',
                                        height: 18,
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        "Rp. 75.000",
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
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: (MediaQuery.of(context).size.width - 27 * 2) *
                                  (1 / 3) -
                              4,
                          decoration: BoxDecoration(
                            //color: Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF9800),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    Image.asset(
                                      'assets/images/taskantorjam.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                    Text(
                                      "Mengerjakan",
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 100),
                              Container(
                                width: (MediaQuery.of(context).size.width -
                                            27 * 2) *
                                        (1 / 2) -
                                    4,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 42.2,
                                          height: 42.2,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFF826754),
                                              width: 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/chat.png',
                                              width: 21,
                                              height: 21,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFB3261E),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "3",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 42.2,
                                      height: 42.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF826754),
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/titik3.png',
                                          width: 21,
                                          height: 21,
                                          fit: BoxFit.contain,
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
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7E2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          width: (MediaQuery.of(context).size.width - 27 * 2) *
                                  (1 / 2) -
                              4,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE7E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      "Survei Preferensi Konsumen untuk Produk Ramah Lingkungan",
                                      style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF705D54),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset(
                                        'assets/images/online.png',
                                        height: 18,
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8),
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
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset(
                                        'assets/images/uang.png',
                                        height: 18,
                                        width: 18,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        "Rp. 50.000",
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
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: (MediaQuery.of(context).size.width - 27 * 2) *
                                  (1 / 3) -
                              4,
                          decoration: BoxDecoration(
                            //color: Color(0xFFF44336),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    Image.asset(
                                      'assets/images/centang2.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                    Text(
                                      "Selesai",
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 100),
                              Container(
                                width: (MediaQuery.of(context).size.width -
                                            27 * 2) *
                                        (1 / 2) -
                                    4,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 42.2,
                                          height: 42.2,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFF826754),
                                              width: 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/download2.png',
                                              width: 21,
                                              height: 21,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 42.2,
                                      height: 42.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF826754),
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/titik3.png',
                                          width: 21,
                                          height: 21,
                                          fit: BoxFit.contain,
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
    );
  }
}
