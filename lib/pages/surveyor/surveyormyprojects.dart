import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/surveyorproject_card.dart';
import 'package:surveyscout/pages/surveyorproyekdetailbutuhtinjau.dart';
import 'package:surveyscout/pages/surveyorproyekdetaildeadline.dart';
import 'package:surveyscout/pages/surveyorproyekdetailditolak.dart';
import 'package:surveyscout/pages/surveyorproyekdetailmendaftar.dart';
import 'package:surveyscout/pages/surveyorproyekdetailmengerjakan.dart';
import 'package:surveyscout/pages/surveyorproyekdetailselesai.dart';
import 'package:surveyscout/services/projects/api_surveyorprojects.dart';

class SurveyorMyProjects extends StatefulWidget {
  @override
  _SurveyorMyProjects createState() => _SurveyorMyProjects();
}

class _SurveyorMyProjects extends State<SurveyorMyProjects> {
  ApiService? apiService;
  int activeButton = -1;
  List<Survey> mySurveys = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeApiService();
  }

  Future<void> _initializeApiService() async {
    String token = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('jwt_token') ?? '');

    print("Token: $token");
    setState(() {
      apiService = ApiService("https://surveyscoutbe.onrender.com/api/v1",
          token: token.toString());
    });
    _fetchMySurveys();
  }

  Future<void> _fetchMySurveys() async {
    setState(() {
      _isLoading = true;
    });
    if (apiService != null) {
      try {
        List<Survey> surveys = await apiService!.getMySurveys();

        DateTime now = DateTime.now();

        surveys.sort((a, b) {
          DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
          DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

          int diffA = dateA.difference(now).inMilliseconds;
          int diffB = dateB.difference(now).inMilliseconds;

          return diffA.compareTo(diffB);
        });

        setState(() {
          mySurveys = surveys;
          _isLoading = false;
        });
      } catch (e) {
        print("Error mengambil data survei: $e");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD7CCC8),
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(27.0),
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
                      prefixIcon: Icon(Icons.search, color: Color(0xFF826754)),
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
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.fourRotatingDots(
                    color: Color(0xFF705D54),
                    size: 50,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Memuat proyek saya...",
                    style: TextStyle(
                      color: Color(0xFF705D54),
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              color: Color(0xFF705D54),
              onRefresh: _fetchMySurveys,
              child: mySurveys.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: Color(0xFFA3948D),
                            size: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tidak ada survei yang tersedia.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFA3948D),
                              fontFamily: 'NunitoSans',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            if (mySurveys.isEmpty)
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Tidak ada survei yang ditemukan.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFA3948D),
                                      fontFamily: 'NunitoSans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: mySurveys.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  Survey mysurveys = mySurveys[index];
                                  return SurveyorprojectCard(
                                    orderId: mysurveys.orderId,
                                    title: mysurveys.namaProyek,
                                    timeAgo:
                                        mysurveys.calculateDeadlineToString(),
                                    fileType: mysurveys.tipeHasil.join(", "),
                                    status: mysurveys.statusSurveyor,
                                    showRating: false,
                                    onDownload:
                                        mysurveys.statusSurveyor == "selesai"
                                            ? () => print("Download tapped")
                                            : null,
                                    onChat: mysurveys.statusSurveyor ==
                                                "ditinjau" ||
                                            mysurveys.statusSurveyor ==
                                                "dikerjakan"
                                        ? () => print("Chat tapped")
                                        : null,
                                    onMore: () => print("More options tapped"),
                                    chatCount: (mysurveys.statusSurveyor ==
                                            "dikerjakan")
                                        ? 3
                                        : null,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            if (mysurveys.statusSurveyor ==
                                                "ditolak") {
                                              return Surveyorproyekdetailditolak(
                                                id: mysurveys.idSurvey,
                                              );
                                            } else if (mysurveys
                                                    .statusSurveyor ==
                                                "mendaftar") {
                                              return Surveyorproyekdetailmendaftar(
                                                id: mysurveys.idSurvey,
                                              );
                                            } else if (mysurveys
                                                    .statusSurveyor ==
                                                "mengerjakan") {
                                              return Surveyorproyekdetailmengerjakan(
                                                id: mysurveys.idSurvey,
                                              );
                                            } else if (mysurveys
                                                    .statusSurveyor ==
                                                "selesai") {
                                              return Surveyorproyekdetailselesai(
                                                id: mysurveys.idSurvey,
                                              );
                                            } else if (mysurveys
                                                    .statusSurveyor ==
                                                "deadline") {
                                              return Surveyorproyekdetaildeadline(
                                                id: mysurveys.idSurvey,
                                              );
                                            } else {
                                              return Surveyorproyekdetailbutuhtinjau(
                                                id: mysurveys.idSurvey,
                                              );
                                            }
                                          },
                                        ),
                                      );
                                    },
                                    onWork:
                                        mysurveys.statusSurveyor == "merekrut"
                                            ? () => print("Work tapped")
                                            : null,
                                  );
                                },
                              ),
                            SizedBox(height: 20),
                            if (mySurveys.isNotEmpty)
                              Center(
                                child: Text(
                                  'Anda memiliki total ${mySurveys.length} proyek',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFA3948D),
                                    fontFamily: 'NunitoSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            SizedBox(height: 40),
                          ],
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
      width: isWide ? 300 : 200,
      height: 40,
      child: DropdownButtonFormField<String>(
        isDense: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xFF705D54),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xFF705D54),
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xFF705D54),
              width: 1.0,
            ),
          ),
        ),
        hint: Text(
          hint,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 21.82 / 16,
            decoration: TextDecoration.none,
            color: Color(0xFF705D54),
          ),
        ),
        value: selectedValue,
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
                color: Color(0xFF705D54),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF705D54)),
      ),
    );
  }
}
