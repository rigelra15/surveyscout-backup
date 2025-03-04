import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/custom_choose_sort.dart';
import 'package:surveyscout/components/project_card.dart';
import 'package:surveyscout/components/survey_status.dart';
import 'package:surveyscout/pages/client/clientchat.dart';
import 'package:surveyscout/pages/client/clientsaya.dart';
import 'package:surveyscout/services/api_clientprojects.dart';

class ClientProjects extends StatefulWidget {
  @override
  _ClientProjects createState() => _ClientProjects();
}

class _ClientProjects extends State<ClientProjects> {
  ApiService? apiService;
  List<Project> allProjects = [];
  List<Project> filteredProjects = [];
  String searchQuery = "";

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
          "https://4481-118-99-84-24.ngrok-free.app/api/v1",
          token,
        );
      });
      _fetchSurveys();
    } else {
      print("Token tidak ditemukan");
    }
  }

  Future<void> _fetchSurveys() async {
    if (apiService != null) {
      try {
        List<Project> surveys = await apiService!.getSurveys();

        DateTime now = DateTime.now();

        surveys.sort((a, b) {
          DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
          DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

          int diffA = dateA.difference(now).inMilliseconds;
          int diffB = dateB.difference(now).inMilliseconds;

          return diffA.compareTo(diffB);
        });

        setState(() {
          allProjects = surveys;
          filteredProjects = surveys;
        });
      } catch (e) {
        print("Error mengambil data survei: $e");
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 100,
                          padding: EdgeInsets.all(0),
                          child: FutureBuilder<List<Project>>(
                            future: apiService != null
                                ? apiService!.getSurveys()
                                : Future.value([]),
                            builder: (context, snapshot) {
                              List<Project> surveys = [];
                              if (snapshot.hasData && snapshot.data != null) {
                                surveys = snapshot.data!;
                              }
                              return SurveyStatusWidget(surveys: surveys);
                            },
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredProjects.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            Project project = filteredProjects[index];
                            return ProjectCard(
                              orderId: project.orderId,
                              title: project.namaProyek,
                              timeAgo: project.calculateDeadline(),
                              fileType: project.tipeHasil.join(", "),
                              status: project.statusTask,
                              showRating: project.statusTask == "selesai",
                              onDownload: project.statusTask == "selesai"
                                  ? () => print("Download tapped")
                                  : null,
                              onChat: project.statusTask == "ditinjau" ||
                                      project.statusTask == "dikerjakan"
                                  ? () => print("Chat tapped")
                                  : null,
                              onMore: () => print("More options tapped"),
                              chatCount: (project.statusTask == "dikerjakan")
                                  ? 3
                                  : null,
                              onWork: project.statusTask == "merekrut"
                                  ? () => print("Work tapped")
                                  : null,
                            );
                          },
                        ),
                        SizedBox(height: 40),
                        if (filteredProjects.isEmpty)
                          Center(
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
                        if (filteredProjects.isNotEmpty)
                          Center(
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Anda memiliki total ${filteredProjects.length} proyek',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFA3948D),
                                    fontFamily: 'NunitoSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  print('Custom FAB Terklik!');
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
      bottomNavigationBar: Container(
        color: Color(0xffD7CCC8),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: GestureDetector(
          onTap: () {
            print("Footer link clicked!");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/proyek.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Proyek',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'NunitoSans',
                        color: Color(0xFF705D54),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientChat()),
                  );
                },
                child: Container(
                  width: 80,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/chat3.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NunitoSans',
                          color: Color(0xFFC4B8B1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientSaya(),
                    ),
                  );
                },
                child: Container(
                  width: 80,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/saya.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Saya',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NunitoSans',
                          color: Color(0xFFB8ADA5),
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
