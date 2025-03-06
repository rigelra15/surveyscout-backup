import 'package:flutter/material.dart';
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
          "https://d36b-118-99-84-24.ngrok-free.app/api/v1",
          token,
        );
      });
      _fetchResponds();
    } else {
      print("Token tidak ditemukan");
    }
  }

  Future<void> _fetchResponds() async {
    try {
      List<Respond> responds = await apiService!.getResponds();
      setState(() {
        allResponds = responds;
      });
    } catch (e) {
      print("Error mengambil data responden: $e");
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

  int activeButton = -1;
  bool _isSaved = false;
  bool _isSaved2 = false;
  bool _isSaved3 = false;
  bool _isSaved4 = false;
  bool _isSaved5 = false;
  bool _isSaved6 = false;

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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allResponds.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return RespondCard(
                        title: allResponds[index].namaProyek,
                        description: allResponds[index].deskripsiProyek,
                        deadlineDays: allResponds[index].calculateDeadline(),
                        location: allResponds[index].lokasi,
                        reward: allResponds[index].kompensasi,
                        isBookmarked: false,
                        onBookmarkToggle: () {
                          setState(() {
                            _isSaved = !_isSaved;
                          });
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
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
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/tersedia.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tersedia',
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
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RespondenMyProjects()),
                  );
                },
                child: Container(
                  width: 100,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/proyeksaya.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Proyek Saya',
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RespondenChat()),
                  );
                },
                child: Container(
                  width: 60,
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
                          color: Color(0xFFB8ADA5),
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
                    MaterialPageRoute(builder: (context) => RespondenAccount()),
                  );
                },
                child: Container(
                  width: 60,
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
                        'Akun',
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
