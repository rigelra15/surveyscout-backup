import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/custom_choose_sort.dart';
import 'package:surveyscout/components/project_card.dart';
import 'package:surveyscout/components/survey_status.dart';
import 'package:surveyscout/pages/client/choose_recruitment_screen.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetail.dart';
import 'package:surveyscout/services/projects/api_clientprojects.dart';

class ClientProjects extends StatefulWidget {
  @override
  _ClientProjects createState() => _ClientProjects();
}

class _ClientProjects extends State<ClientProjects> {
  ApiService? apiService;
  List<Project> allProjects = [];
  List<Project> filteredProjects = [];
  String searchQuery = "";
  bool isLoading = false;

  Map<String, int> _ratings = {};

  @override
  void initState() {
    super.initState();
    _initializeApiService();
  }

  Future<void> _initializeApiService() async {
    String? token = await _getToken();
    if (token != null) {
      setState(() {
        apiService = ApiService(
          "https://surveyscoutbe.onrender.com/api/v1",
          token,
        );
      });
      _fetchSurveys();
    } else {
      print("Token tidak ditemukan");
    }
  }

  Future<void> _fetchSurveys() async {
    setState(() {
      isLoading = true;
    });
    if (apiService != null) {
      try {
        List<Project> surveys = await apiService!.getSurveys();

        DateTime now = DateTime.now();

        surveys.sort((a, b) {
          DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
          DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

          int diffA = dateA.difference(now).inMilliseconds;
          int diffB = dateB.difference(now).inMilliseconds;
          print(diffA.compareTo(diffB));

          return diffA.compareTo(diffB);
        });

        setState(() {
          allProjects = surveys;
          filteredProjects = surveys;
          isLoading = false;
        });
        print(filteredProjects);
      } catch (e) {
        print("Error mengambil data survei: $e");
        setState(() {
          isLoading = false;
        });
      }
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

  void _filterSortProjects() {
    setState(() {
      filteredProjects = allProjects.where((survey) {
        final matchesStatus = selectedStatus == "Semua status" ||
            survey.statusTask.toLowerCase() == selectedStatus.toLowerCase() ||
            survey.statusTask.toLowerCase() == "pembayaran" &&
                selectedStatus.toLowerCase() == "menunggu bayar";
        final matchesSearch =
            survey.namaProyek.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesRole = selectedPeran == "Semua peran" ||
            survey.orderId.toLowerCase().startsWith("respond") ==
                (selectedPeran == "Respond") ||
            survey.orderId.toLowerCase().startsWith("survey") ==
                (selectedPeran == "Survey");
        return matchesStatus && matchesSearch && matchesRole;
      }).toList();

      DateTime now = DateTime.now();
      filteredProjects.sort((a, b) {
        DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
        DateTime dateB = DateTime.parse(b.tenggatPengerjaan);
        DateTime uploadA = DateTime.parse(a.createdAt);
        DateTime uploadB = DateTime.parse(b.createdAt);

        switch (selectedSort) {
          case "Tenggat Pengerjaan Terdekat":
            return dateA.difference(now).compareTo(dateB.difference(now));
          case "Tenggat Pengerjaan Terjauh":
            return dateB.difference(now).compareTo(dateA.difference(now));
          case "Tanggal Unggah Terbaru":
            return uploadB.compareTo(uploadA);
          case "Tanggal Unggah Terlama":
            return uploadA.compareTo(uploadB);
          default:
            return dateA.difference(now).compareTo(dateB.difference(now));
        }
      });
    });
  }

  String selectedStatus = "Semua status";
  String selectedPeran = "Semua peran";
  String selectedLokasi = "Semua lokasi";
  String selectedKomisi = "Semua komisi";
  String selectedSort = "Tenggat Pengerjaan Terdekat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(165),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD7CCC8),
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(27.0),
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
                      onChanged: (value) {
                        searchQuery = value;
                        print("Search query: $searchQuery");
                        _filterSortProjects();
                      },
                      decoration: InputDecoration(
                        hintText: "Cari proyek Anda...",
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
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      _buildIconBox(),
                      SizedBox(width: 8),
                      _buildDropdown(
                          "Semua Status",
                          [
                            "Semua status",
                            "Peringatan",
                            "Dikerjakan",
                            "Ditinjau",
                            "Merekrut",
                            "Selesai",
                            "Kadaluwarsa",
                            "Draft",
                            "Menunggu bayar"
                          ],
                          selectedValue: selectedStatus, onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                          _filterSortProjects();
                        });
                      }),
                      SizedBox(width: 8),
                      _buildDropdown(
                          "Semua Peran", ["Semua peran", "Survey", "Respond"],
                          selectedValue: selectedPeran, onChanged: (value) {
                        setState(() {
                          selectedPeran = value!;
                          _filterSortProjects();
                        });
                      }),
                      SizedBox(width: 8),
                      _buildDropdown("Semua Lokasi",
                          ["Semua lokasi", "Sidoarjo", "Surabaya"],
                          selectedValue: selectedLokasi, onChanged: (value) {
                        setState(() {
                          selectedLokasi = value!;
                        });
                      }),
                      SizedBox(width: 8),
                      _buildDropdown(
                          "Semua Komisi",
                          [
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
                          ],
                          selectedValue: selectedKomisi, onChanged: (value) {
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
      body: isLoading
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
          : Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          color: Color(0xFF705D54),
                          onRefresh: _fetchSurveys,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (filteredProjects.isNotEmpty)
                                  SizedBox(height: 110),
                                filteredProjects.isEmpty
                                    ? ListView(
                                        shrinkWrap: true,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        children: [
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.string(
                                                allProjects.isEmpty
                                                    ? '''<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill="#705D54" d="M3.5 1a.5.5 0 0 0-.5.5v13a.5.5 0 0 0 .5.5H7v-1H4V2h8v5h1V1.5a.5.5 0 0 0-.5-.5z"/><path fill="#705D54" d="M5 5h6V4H5zm0 2h4V6H5z"/><path fill="#705D54" fill-rule="evenodd" d="M10.5 8a3.5 3.5 0 1 0 0 7a3.5 3.5 0 0 0 0-7m-1.354 2.854l.647.646l-.647.646l.708.707l.646-.646l.646.646l.708-.707l-.647-.646l.647-.646l-.707-.708l-.647.647l-.646-.647z" clip-rule="evenodd"/></svg>'''
                                                    : '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="#705D54" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 0 0 1.48-5.34c-.47-2.78-2.79-4.99-5.58-5.34A6.49 6.49 0 0 0 3.03 9h2.02c.24-2.12 1.92-3.8 4.06-3.98C11.65 4.8 14 6.95 14 9.5c0 2.49-2.01 4.5-4.5 4.5c-.17 0-.33-.03-.5-.05v2.02l.01.01c1.8.13 3.47-.47 4.72-1.55l.27.28v.79l4.25 4.25c.41.41 1.08.41 1.49 0s.41-1.08 0-1.49z"/><path fill="#705D54" d="M6.12 11.17L4 13.29l-2.12-2.12c-.2-.2-.51-.2-.71 0s-.2.51 0 .71L3.29 14l-2.12 2.12c-.2.2-.2.51 0 .71s.51.2.71 0L4 14.71l2.12 2.12c.2.2.51.2.71 0s.2-.51 0-.71L4.71 14l2.12-2.12c.2-.2.2-.51 0-.71a.513.513 0 0 0-.71 0"/></svg>''',
                                                width: 48,
                                                height: 48,
                                                placeholderBuilder:
                                                    (BuildContext context) =>
                                                        Container(
                                                  padding: const EdgeInsets.all(
                                                      30.0),
                                                  child:
                                                      const CircularProgressIndicator(
                                                    color: Color(0xFF705D54),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                allProjects.isEmpty
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
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: filteredProjects.length,
                                        itemBuilder: (context, index) {
                                          Project project =
                                              filteredProjects[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: ProjectCard(
                                              orderId: project.orderId,
                                              title: project.namaProyek,
                                              timeAgo:
                                                  project.calculateDeadline(),
                                              fileType:
                                                  project.tipeHasil.join(", "),
                                              status: project.statusTask,
                                              showRating: (project.statusTask ==
                                                      "selesai" &&
                                                  project.statusRating ==
                                                      "belum"),
                                              onDownload: project.statusTask ==
                                                      "selesai"
                                                  ? () =>
                                                      print("Download tapped")
                                                  : null,
                                              onChat: project.statusTask ==
                                                          "ditinjau" ||
                                                      project.statusTask ==
                                                          "dikerjakan"
                                                  ? () => print("Chat tapped")
                                                  : null,
                                              onMore: () =>
                                                  print("More options tapped"),
                                              chatCount: project.statusTask ==
                                                      "dikerjakan"
                                                  ? 3
                                                  : null,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Clientsurveyorproyekdetail(
                                                            id: project
                                                                .idSurvey,
                                                            type: project
                                                                    .orderId
                                                                    .startsWith(
                                                                        "RESPOND")
                                                                ? "respond"
                                                                : "survey"),
                                                  ),
                                                );
                                              },
                                              onWork: project.statusTask ==
                                                      "merekrut"
                                                  ? () => print("Work tapped")
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 27,
                  right: 27,
                  child: Container(
                    width: double.infinity,
                    height: 88,
                    child: FutureBuilder<List<Project>>(
                      future: apiService?.getSurveys() ?? Future.value([]),
                      builder: (context, snapshot) {
                        List<Project> surveys = snapshot.data ?? [];
                        return SurveyStatusWidget(surveys: surveys);
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  right: 32,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3A2B24),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseRecruitmentScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Buat Baru",
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
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

  Widget _buildIconBox() {
    return GestureDetector(
      onTap: () {
        showFilterBottomSheet(
          context,
          selectedSort,
          (selectedFilter) {
            setState(() {
              selectedSort = selectedFilter;
            });
            _filterSortProjects();
          },
        );
      },
      child: Container(
        width: 40,
        height: 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFF705D54),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 2,
              color: Color(0xFF705D54),
            ),
            SizedBox(height: 4),
            Container(
              width: 2 / 3 * 20,
              height: 2,
              color: Color(0xFF705D54),
            ),
            SizedBox(height: 4),
            Container(
              width: 1 / 2 * 20,
              height: 2,
              color: Color(0xFF705D54),
            ),
          ],
        ),
      ),
    );
  }
}
