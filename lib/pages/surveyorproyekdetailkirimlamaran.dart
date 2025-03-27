import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/services/projects/api_surveyorprojects.dart';
import 'package:http/http.dart' as http;

class Surveyorproyekdetailkirimlamaran extends StatefulWidget {
  final String id;

  const Surveyorproyekdetailkirimlamaran({Key? key, required this.id})
      : super(key: key);

  @override
  _SurveyorproyekdetailkirimlamaranState createState() =>
      _SurveyorproyekdetailkirimlamaranState();
}

class _SurveyorproyekdetailkirimlamaranState
    extends State<Surveyorproyekdetailkirimlamaran> {
  bool isBookmarked = false;
  ApiService? apiService;
  late Survey surveyDetail = Survey();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApiService();
  }

  String formatCurrency(String value) {
    try {
      double amount = double.parse(value);
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
      return formatCurrency.format(amount);
    } catch (e) {
      return value;
    }
  }

  Future<String?> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('jwt_token');
    } catch (e) {
      print("Error mengambil token: $e");
      return null;
    }
  }

  Future<void> _initializeApiService() async {
    setState(() {
      apiService = ApiService("https://surveyscoutbe.onrender.com/api/v1");
    });

    _fetchClientRespondenDetail(widget.id);
  }

  Future<void> _fetchClientRespondenDetail(String id) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (apiService != null) {
        Survey profile = await apiService!.getASurvey(id);
        setState(() {
          surveyDetail = profile;
        });
      }
    } catch (e) {
      print("Error mengambil profil klien: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          color: Color(0xFFD7CCC8),
          child: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 50,
            centerTitle: true,
            elevation: 0,
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
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Color(0xFF705D54),
                size: 50,
              ),
            )
          : RefreshIndicator(
              color: Color(0xFF705D54),
              onRefresh: () => _fetchClientRespondenDetail(widget.id),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(27),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                surveyDetail.namaProyek,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "SourceSans3",
                                  color: Color(0xFF705D54),
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Color(0xFF705D54),
                              ),
                              onPressed: () {
                                setState(() {
                                  isBookmarked = !isBookmarked;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          surveyDetail.createdAt,
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFFA3948D),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.punch_clock_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        surveyDetail.tenggatPengerjaan,
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
                                width: MediaQuery.of(context).size.width *
                                    4.55 /
                                    11,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEDE7E2),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Color(0xFFA3948D), size: 20),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            surveyDetail.lokasi,
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
                                width: MediaQuery.of(context).size.width *
                                    4.55 /
                                    11,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEDE7E2),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(Icons.money,
                                        color: Color(0xFFA3948D), size: 20),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            formatCurrency(
                                                surveyDetail.kompensasi),
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
                          width: double.infinity,
                          height: 1,
                          color: Color(0xFFB0B0B0),
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
                          surveyDetail.deskripsiProyek,
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
                          surveyDetail.keahlian.join(', '),
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
                          surveyDetail.tipeHasil.join(', '),
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
                                'ID #${widget.id}',
                                textAlign: TextAlign.center,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xFF826754),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _showPelamar(context, context);
                },
                child: Container(
                  height: 600,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1E9E5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.edit_document, color: Color(0xFF826754)),
                      SizedBox(width: 10),
                      Text(
                        'Kirim Lamaran',
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
            ),
            SizedBox(width: 8),
            Container(
              height: 600,
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
    );
  }

  void _showPelamar(BuildContext bottomSheetContext, BuildContext rootContext) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFF1E9E5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        "Kirim lamaran?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'SourceSans3',
                          color: Color(0xFF705D54),
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Color(0xFF3A2B24),
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(text: "Tindakan ini "),
                            TextSpan(
                              text: "tidak dapat diurungkan.",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " Kami akan memberitahu Anda mengenai status lamaran atau chat dari calon klien.",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF7B5E52),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(
                                bottomSheetContext); // Tutup modal dulu

                            final token = await _getToken();
                            final response = await http.post(
                              Uri.parse(
                                  'https://surveyscoutbe.onrender.com/api/v1/surveyorapplies/mendaftarSurvey/${widget.id}'),
                              headers: <String, String>{
                                'Authorization': 'Bearer $token',
                                'Content-Type': 'application/json',
                              },
                            );

                            final snackBar = SnackBar(
                              content: Text(
                                response.statusCode == 201
                                    ? 'Berhasil mengirim lamaran!'
                                    : 'Gagal mengirim lamaran! Silakan coba lagi.',
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: response.statusCode == 201
                                  ? Color(0xFF7B5E52)
                                  : Colors.red,
                            );

                            ScaffoldMessenger.of(rootContext)
                                .showSnackBar(snackBar);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF7B5E52),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Ya, lamar"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B5E52),
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Batalkan"),
                        ),
                      ),
                    ],
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
