import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/survey_card.dart';
import 'package:surveyscout/services/projects/api_surveyorprojects.dart';
import 'package:surveyscout/pages/surveyorproyekdetailbutuhtinjau.dart';
import 'package:surveyscout/pages/surveyorproyekdetaildeadline.dart';
import 'package:surveyscout/pages/surveyorproyekdetailditolak.dart';
import 'package:surveyscout/pages/surveyorproyekdetailkirimlamaran.dart';
import 'package:surveyscout/pages/surveyorproyekdetailmendaftar.dart';
import 'package:surveyscout/pages/surveyorproyekdetailmengerjakan.dart';
import 'package:surveyscout/pages/surveyorproyekdetailmengerjakanchatluaran.dart';
import 'package:surveyscout/pages/surveyorproyekdetailselesai.dart';
import 'surveyormyprojects.dart';
import 'surveyorchat.dart';
import 'surveyorakun.dart';

class SurveyorProjects extends StatefulWidget {
  @override
  _SurveyorProjects createState() => _SurveyorProjects();
}

class _SurveyorProjects extends State<SurveyorProjects> {
  ApiService? apiService;
  List<Survey> allSurveys = [];
  List<Survey> filteredSurveys = [];
  String searchQuery = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeApiService();
  }

  Future<void> _initializeApiService() async {
    setState(() {
      apiService = ApiService("https://surveyscoutbe.onrender.com/api/v1");
    });
    _fetchSurveys();
  }

  Future<void> _fetchSurveys() async {
    setState(() {
      _isLoading = true;
    });

    if (apiService != null) {
      try {
        List<Survey> surveys = await apiService!.getSurveys();

        DateTime now = DateTime.now();

        surveys.sort((a, b) {
          DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
          DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

          int diffA = dateA.difference(now).inMilliseconds;
          int diffB = dateB.difference(now).inMilliseconds;

          return diffA.compareTo(diffB);
        });

        setState(() {
          allSurveys = surveys;
          filteredSurveys = surveys;
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

  void _filterSortSurveys() {
    setState(() {
      filteredSurveys = allSurveys.where((survey) {
        return matchesSearch(survey);
      }).toList();

      DateTime now = DateTime.now();
      filteredSurveys.sort((a, b) {
        DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
        DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

        return dateA.difference(now).compareTo(dateB.difference(now));
      });
    });
  }

  bool matchesSearch(Survey survey) {
    return survey.namaProyek.toLowerCase().contains(searchQuery.toLowerCase());
  }

  int activeButton = -1;
  bool _isSaved = false;

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
                    onChanged: (value) {
                      searchQuery = value;
                      _filterSortSurveys();
                    },
                    decoration: InputDecoration(
                      hintText: "Cari dari 100+ proyek...",
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSaved = !_isSaved;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFF705D54),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Color(0xFF705D54),
                        size: 24,
                      ),
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
                    "Memuat proyek...",
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
              onRefresh: _fetchSurveys,
              child: filteredSurveys.isEmpty
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
                  : ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(27),
                      itemCount: filteredSurveys.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        Survey survey = filteredSurveys[index];
                        return SurveyCard(
                          id: survey.idSurvey,
                          title: survey.namaProyek,
                          description: survey.deskripsiProyek,
                          deadlineDays: survey.calculateDeadline(),
                          location: survey.lokasi,
                          reward: survey.kompensasi,
                          isBookmarked: false,
                          onBookmarkToggle: () {
                            setState(() {
                              _isSaved = !_isSaved;
                            });
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Surveyorproyekdetailkirimlamaran(
                                  id: survey.idSurvey,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
    );
  }
}
