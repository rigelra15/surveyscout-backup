import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/survey_card.dart';
import 'package:surveyscout/services/projects/api_surveyorprojects.dart';
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
      List<Survey> surveys = await apiService!.getResponds();
      setState(() {
        allSurveys = surveys;
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

  int activeButton = -1; // Tombol default yang tidak aktif
  bool _isSaved = false;
  bool _isSaved2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5), // Background berwarna #F1E9E5
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95), // Tinggi AppBar diatur menjadi 130
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD7CCC8), // Header berwarna #D7CCC8
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(27.0), // Padding diatur menjadi 27
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TextInput dengan panjang setengah dari layar
                Container(
                  width: (MediaQuery.of(context).size.width - 54) *
                      2 /
                      3, // Setengah dari lebar layar
                  height: 40, // Tinggi dari kotak teks
                  decoration: BoxDecoration(
                    color: Color(0xFFF1E9E5), // Warna latar belakang
                    borderRadius: BorderRadius.circular(8), // Sudut melengkung
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari dari 100+ proyek...", // Placeholder teks
                      filled: true,
                      fillColor: Color(0xFFF1E9E5), // Warna latar belakang
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Sudut melengkung
                        borderSide: BorderSide(
                          color: Color(0xFF757575), // Warna border #757575
                          width: 0.1, // Lebar border 0.1px
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(
                              0xFF705D54), // Warna border tetap saat fokus
                          width: 2.0, // Lebar border saat fokus
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(
                              0xFF705D54), // Warna border tetap saat tidak fokus
                          width: 1.0, // Lebar border saat tidak fokus
                        ),
                      ),
                      prefixIcon: Icon(Icons.search,
                          color: Color(0xFF826754)), // Ikon pencarian
                      hintStyle: TextStyle(
                        color: Color(0xFFB0B0B0), // Warna teks #B0B0B0
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w300, // Ketebalan font 300
                        fontSize: 14, // Ukuran font 14px
                      ),
                    ),
                  ),
                ),
                // Kotak pertama
                Container(
                  width: 40, // Lebar kotak
                  height: 40, // Tinggi kotak
                  decoration: BoxDecoration(
                    //color: Color(0xFFD9D9D9), // Warna kotak
                    borderRadius: BorderRadius.circular(8), // Sudut melengkung
                    border: Border.all(
                      color: Color(0xFF705D54), // Warna border
                      width: 1, // Lebar border
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/caridari100.png', // Ganti dengan path gambar Anda
                      width: 24, // Lebar gambar
                      height: 24, // Tinggi gambar
                      fit: BoxFit.contain, // Agar gambar sesuai
                    ),
                  ),
                ),

                // Kotak kedua
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSaved = !_isSaved; // Toggle status saat diklik
                    });
                  },
                  child: Container(
                    width: 40, // Lebar kotak
                    height: 40, // Tinggi kotak
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(8), // Sudut melengkung
                      border: Border.all(
                        color: Color(0xFF705D54), // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border, // Ikon berubah
                        color: Color(0xFF705D54), // Warna ikon
                        size: 24, // Ukuran ikon
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
            alignment:
                Alignment.topCenter, // Menempatkan kontainer di bagian atas
            child: Container(
              color: const Color(0xFFF2EEE9),

              padding: EdgeInsets.all(27),
              //color: Colors.grey[200], // Warna background Container utama
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allSurveys.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return SurveyCard(
                        title: allSurveys[index].namaProyek,
                        description: allSurveys[index].deskripsiProyek,
                        deadlineDays: allSurveys[index].calculateDeadline(),
                        location: allSurveys[index].lokasi,
                        reward: allSurveys[index].kompensasi,
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
        color: Color(0xffD7CCC8), // Footer berwarna #D7CCC8
        padding: EdgeInsets.symmetric(
            horizontal: 32, vertical: 8), // Padding horizontal dan vertikal
        child: GestureDetector(
          onTap: () {
            // Navigasi atau aksi untuk footer
            print("Footer link clicked!");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Jarak antar container dibuat maksimal
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SurveyorMyProjects()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/tersedia.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(
                          height: 4), // Memberikan jarak antara gambar dan teks
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
                        builder: (context) =>
                            SurveyorMyProjects()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 100,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/proyeksaya.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(
                          height: 4), // Memberikan jarak antara gambar dan teks
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
                    MaterialPageRoute(
                        builder: (context) =>
                            SurveyorChat()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/chat3.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(
                          height: 4), // Memberikan jarak antara gambar dan teks
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
                    MaterialPageRoute(
                        builder: (context) =>
                            SurveyorAccount()), // Ganti dengan nama halaman Anda
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Pusatkan isi secara vertikal
                    children: [
                      Image.asset(
                        'assets/images/saya.png', // Path ke gambar
                        width: 24, // Lebar gambar
                        height: 24, // Tinggi gambar
                        fit: BoxFit.contain, // Menyesuaikan ukuran gambar
                      ),
                      SizedBox(
                          height: 4), // Memberikan jarak antara gambar dan teks
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
      width: isWide ? 300 : 200, // Conditional width based on isWide parameter
      height: 40, // Set the total height of the dropdown to 40
      child: DropdownButtonFormField<String>(
        isDense: true, // Make the dropdown more compact
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0), // Padding to control internal spacing
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
            borderSide: BorderSide(
              color: Color(0xFF705D54), // Default border color
              width: 1, // Border width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xFF705D54), // Warna border saat fokus
              width: 2.0, // Lebar border saat fokus
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xFF705D54), // Warna border saat tidak fokus
              width: 1.0, // Lebar border saat tidak fokus
            ),
          ),
        ),
        hint: Text(
          hint,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 21.82 / 16, // line-height calculated as ratio of font-size
            decoration: TextDecoration.none, // No underline decoration
            color: Color(0xFF705D54), // Text color
          ),
        ),
        value: selectedValue, // Set the current selected value
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
                color: Color(0xFF705D54), // Text color
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged, // Set the onChanged callback
        icon: Icon(Icons.keyboard_arrow_down,
            color: Color(0xFF705D54)), // Icon color
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
          borderRadius: BorderRadius.circular(16), // Rounded corners
          border: Border.all(
            color: Color(0xFF705D54), // Border color
            width: 1, // Border width of 1px
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center align vertically
          crossAxisAlignment:
              CrossAxisAlignment.start, // Center align horizontally
          children: [
            // Top line (full width)
            Container(
              width: double.infinity, // Max width
              height: 2,
              color: Color(0xFF705D54),
            ),
            SizedBox(height: 4), // Add spacing between lines
            // Middle line (2/3 of the box width)
            Container(
              width: 2 / 3 * 20, // 2/3 width of the box
              height: 2,
              color: Color(0xFF705D54),
            ),
            SizedBox(height: 4), // Add spacing between lines
            // Bottom line (half the width of the box)
            Container(
              width: 1 / 2 * 20, // 1/2 width of the box
              height: 2,
              color: Color(0xFF705D54),
            ),
          ],
        ),
      ),
    );
  }
}
