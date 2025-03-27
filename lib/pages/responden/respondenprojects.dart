import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/respond_card.dart';
import 'package:surveyscout/services/projects/api_respondenprojects.dart';
import 'respondenmyprojects.dart';
import 'respondenchat.dart';
import 'respondenaccount.dart';

class RespondenProjects extends StatefulWidget {
  @override
  _RespondenProjects createState() => _RespondenProjects();
}

class _RespondenProjects extends State<RespondenProjects> {
  ApiService? apiService;
  List<Respond> allResponds = [];
  List<Respond> filteredResponds = [];
  String searchQuery = "";
  bool isLoading = false;

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
      _fetchResponds();
    } else {
      print("Token tidak ditemukan");
    }
  }

  Future<void> _fetchResponds() async {
    setState(() {
      isLoading = true;
    });

    if (apiService != null) {
      try {
        List<Respond> responds = await apiService!.getResponds();

        DateTime now = DateTime.now();

        responds.sort((a, b) {
          DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
          DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

          int diffA = dateA.difference(now).inMilliseconds;
          int diffB = dateB.difference(now).inMilliseconds;

          return diffA.compareTo(diffB);
        });

        setState(() {
          allResponds = responds;
          filteredResponds = responds;
          isLoading = false;
        });
      } catch (e) {
        print("Error mengambil data responden: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _filterSortResponds() {
    setState(() {
      filteredResponds = allResponds.where((survey) {
        return matchesSearch(survey);
      }).toList();

      DateTime now = DateTime.now();
      filteredResponds.sort((a, b) {
        DateTime dateA = DateTime.parse(a.tenggatPengerjaan);
        DateTime dateB = DateTime.parse(b.tenggatPengerjaan);

        return dateA.difference(now).compareTo(dateB.difference(now));
      });
    });
  }

  bool matchesSearch(Respond respond) {
    return respond.namaProyek.toLowerCase().contains(searchQuery.toLowerCase());
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

  int activeButton = -1;
  bool _isSaved = false;
  // bool _isSaved2 = false;
  // bool _isSaved3 = false;
  // bool _isSaved4 = false;
  // bool _isSaved5 = false;
  // bool _isSaved6 = false;

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 27.0, vertical: 12.0),
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
                            _filterSortResponds();
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
              )),
        ),
        body: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                onRefresh: _fetchResponds,
                child: filteredResponds.isEmpty
                    ? ListView(
                        physics:
                            AlwaysScrollableScrollPhysics(), // Biar tetap bisa refresh
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.string(
                                allResponds.isEmpty
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
                                allResponds.isEmpty
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
                    : ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(27),
                        itemCount: filteredResponds.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return RespondCard(
                            title: filteredResponds[index].namaProyek,
                            description:
                                filteredResponds[index].deskripsiProyek,
                            deadlineDays:
                                filteredResponds[index].calculateDeadline(),
                            location: filteredResponds[index].lokasi,
                            reward: filteredResponds[index].kompensasi,
                            isBookmarked: false,
                            onBookmarkToggle: () {
                              setState(() {
                                _isSaved = !_isSaved;
                              });
                            },
                          );
                        },
                      ),
              ));
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
