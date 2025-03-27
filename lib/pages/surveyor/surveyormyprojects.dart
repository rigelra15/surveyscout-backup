import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/surveyorproject_card.dart';
import 'package:surveyscout/pages/surveyorproyekdetail.dart';
import 'package:surveyscout/services/projects/api_surveyorprojects.dart';

class SurveyorMyProjects extends StatefulWidget {
  @override
  _SurveyorMyProjects createState() => _SurveyorMyProjects();
}

class _SurveyorMyProjects extends State<SurveyorMyProjects> {
  ApiService? apiService;
  int activeButton = -1;
  List<Survey> mySurveys = [];
  List<Survey> filteredMySurveys = [];
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
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
          filteredMySurveys = mySurveys;
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

  void _filterSortMySurveys() {
    setState(() {
      filteredMySurveys = mySurveys.where((survey) {
        return matchesSearch(survey);
      }).toList();

      DateTime now = DateTime.now();
      filteredMySurveys.sort((a, b) {
        DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
        DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

        return dateA.difference(now).compareTo(dateB.difference(now));
      });
    });
  }

  bool matchesSearch(Survey survey) {
    return survey.namaProyek.toLowerCase().contains(searchQuery.toLowerCase());
  }

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
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                          _filterSortMySurveys();
                        });
                      },
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
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    searchQuery = '';
                                    searchController.clear();
                                    _filterSortMySurveys();
                                  });
                                },
                              )
                            : null,
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
              child: filteredMySurveys.isEmpty
                  ? ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.string(
                              mySurveys.isEmpty
                                  ? '''<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill="#705D54" d="M3.5 1a.5.5 0 0 0-.5.5v13a.5.5 0 0 0 .5.5H7v-1H4V2h8v5h1V1.5a.5.5 0 0 0-.5-.5z"/><path fill="#705D54" d="M5 5h6V4H5zm0 2h4V6H5z"/><path fill="#705D54" fill-rule="evenodd" d="M10.5 8a3.5 3.5 0 1 0 0 7a3.5 3.5 0 0 0 0-7m-1.354 2.854l.647.646l-.647.646l.708.707l.646-.646l.646.646l.708-.707l-.647-.646l.647-.646l-.707-.708l-.647.647l-.646-.647z" clip-rule="evenodd"/></svg>'''
                                  : '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#705D54" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 0 0 1.48-5.34c-.47-2.78-2.79-4.99-5.58-5.34A6.49 6.49 0 0 0 3.03 9h2.02c.24-2.12 1.92-3.8 4.06-3.98C11.65 4.8 14 6.95 14 9.5c0 2.49-2.01 4.5-4.5 4.5c-.17 0-.33-.03-.5-.05v2.02l.01.01c1.8.13 3.47-.47 4.72-1.55l.27.28v.79l4.25 4.25c.41.41 1.08.41 1.49 0s.41-1.08 0-1.49z"/><path fill="#705D54" d="M6.12 11.17L4 13.29l-2.12-2.12c-.2-.2-.51-.2-.71 0s-.2.51 0 .71L3.29 14l-2.12 2.12c-.2.2-.2.51 0 .71s.51.2.71 0L4 14.71l2.12 2.12c.2.2.51.2.71 0s.2-.51 0-.71L4.71 14l2.12-2.12c.2-.2.2-.51 0-.71a.513.513 0 0 0-.71 0"/></svg>''',
                              width: 48,
                              height: 48,
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator(
                                  color: Color(0xFF705D54),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              mySurveys.isEmpty
                                  ? "Tidak ada proyek yang tersedia"
                                  : "Tidak ada proyek yang ditemukan",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFA3948D),
                                fontFamily: 'NunitoSans',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredMySurveys.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                Survey mysurveys = filteredMySurveys[index];
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
                                  onChat:
                                      mysurveys.statusSurveyor == "ditinjau" ||
                                              mysurveys.statusSurveyor ==
                                                  "dikerjakan"
                                          ? () => print("Chat tapped")
                                          : null,
                                  onMore: () => print("More options tapped"),
                                  chatCount:
                                      (mysurveys.statusSurveyor == "dikerjakan")
                                          ? 3
                                          : null,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Surveyorproyekdetail(
                                            id: mysurveys.idSurvey,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  onWork: mysurveys.statusSurveyor == "merekrut"
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
}
