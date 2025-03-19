// ignore_for_file: unused_import, unused_element

import 'dart:convert';
import 'dart:ffi';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:iconify_flutter/icons/codicon.dart';
import 'package:iconify_flutter/icons/gis.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/maki.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/pages/client/transaction_review_respondent_screen.dart';
import 'package:surveyscout/routes/app_routes.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RespondentCriteriaDetailsScreen extends StatefulWidget {
  String? title;
  String? description;
  String? method;
  String? task;
  String? commission;
  String? respondentAmount;
  String? location;
  String? registrationDeadline;
  String? completionDeadline;

  RespondentCriteriaDetailsScreen({
    this.title,
    this.description,
    this.method,
    this.task,
    this.commission,
    this.respondentAmount,
    this.location,
    this.registrationDeadline,
    this.completionDeadline,
  });

  @override
  _RespondentCriteriaDetailsScreenState createState() =>
      _RespondentCriteriaDetailsScreenState();
}

class _RespondentCriteriaDetailsScreenState
    extends State<RespondentCriteriaDetailsScreen> {
  final TextEditingController _projectRespondentKualifikasiLainnyaController =
      TextEditingController();
  final TextEditingController _projectRespondentUsiaRangeController =
      TextEditingController();

  final TextEditingController _minAgeController = TextEditingController();
  final TextEditingController _maxAgeController = TextEditingController();

  final TextEditingController _projectRespondentKabKotaTinggalController =
      TextEditingController();
  final TextEditingController _projectRespondentHobiController =
      TextEditingController();

  Future<String?> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('jwt_token');
    } catch (e) {
      print("Error mengambil token: $e");
      return null;
    }
  }

  final List<Map<String, dynamic>> _hobbyList = [
    {"name": "Berkebun", "icon": Mdi.flower},
    {"name": "Belanja", "icon": Mdi.shopping},
    {"name": "Bersosial", "icon": Ph.chat_fill},
    {"name": "Film", "icon": Mdi.movie},
    {"name": "Fotografi", "icon": Mdi.camera},
    {"name": "Kerajinan", "icon": Mdi.palette},
    {"name": "Komputer & Teknologi", "icon": Mdi.laptop},
    {"name": "Karya Seni", "icon": Maki.landmark},
    {"name": "Menggambar & Melukis", "icon": MaterialSymbols.draw},
    {"name": "Memasak", "icon": AntDesign.heart_outline},
    {"name": "Membaca", "icon": Mdi.book_open},
    {"name": "Musik", "icon": Mdi.music},
    {"name": "Olahraga", "icon": Mdi.run},
    {"name": "Otomotif", "icon": Mdi.car},
    {"name": "Permainan Papan & Kartu", "icon": Mdi.cards},
    {"name": "Permainan Video", "icon": Mdi.controller},
    {"name": "Traveling", "icon": Mdi.airplane},
  ];

  List<String> _selectedHobbies = [];

  final List<String> maritalStatusOptions = [
    "Belum Menikah",
    "Menikah",
    "Cerai Hidup",
    "Cerai Mati",
  ];

  final List<String> educationLevelOptions = [
    "Tidak Sekolah",
    "Lulus SD (Sekolah Dasar)",
    "Lulus SMP (Sekolah Menengah Pertama)",
    "Lulus SMA/SMK (Sekolah Menengah Atas/Kejuruan)",
    "Diploma (D1/D2/D3)",
    "Sarjana (S1)",
    "Magister (S2)",
    "Doktor (S3)",
  ];

  final List<String> jobOptions = [
    "Buruh Pabrik",
    "Content Creator",
    "Desainer Grafis",
    "Fotografer/Videografer",
    "Guru/Dosen",
    "Ibu Rumah Tangga",
    "Karyawan Swasta",
    "Konsultan",
    "Mahasiswa",
    "Nelayan",
    "Pedagang",
    "Pegawai Negeri Sipil (PNS)",
    "Pegawai Swasta",
    "Pegawai BUMD",
    "Pekerja IT Support",
    "Pelajar SMA/SMK",
    "Peneliti",
    "Pengacara",
    "Pensiunan",
    "Penulis atau Editor",
    "Petani",
    "Programmer/Developer",
    "Sopir/Transportasi (Ojek Online, Supir Taksi)",
    "Tenaga Medis (Dokter, Perawat, Apoteker)",
    "Tidak Bekerja",
    "Wiraswasta (UMKM)",
  ];

  List<String> _selectedEducationLevels = [];
  List<String> _selectedMaritalStatuses = [];
  List<String> _selectedJobs = [];

  final TextEditingController _projectRespondentStatusKawinController =
      TextEditingController();
  final TextEditingController _projectRespondentPendidikanController =
      TextEditingController();
  final TextEditingController _projectRespondentPekerjaanController =
      TextEditingController();

  bool _isFormComplete() {
    return _projectRespondentUsiaRangeController.text.isNotEmpty &&
        _projectRespondentKualifikasiLainnyaController.text.isNotEmpty &&
        _projectRespondentKabKotaTinggalController.text.isNotEmpty &&
        _projectRespondentHobiController.text.isNotEmpty &&
        _projectRespondentStatusKawinController.text.isNotEmpty &&
        _projectRespondentPendidikanController.text.isNotEmpty &&
        _projectRespondentPekerjaanController.text.isNotEmpty;
  }

  bool _isFormFilled() {
    return _projectRespondentUsiaRangeController.text.isNotEmpty ||
        _projectRespondentKualifikasiLainnyaController.text.isNotEmpty ||
        _projectRespondentKabKotaTinggalController.text.isNotEmpty ||
        _projectRespondentHobiController.text.isNotEmpty ||
        _projectRespondentStatusKawinController.text.isNotEmpty ||
        _projectRespondentPendidikanController.text.isNotEmpty ||
        _projectRespondentPekerjaanController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _projectRespondentKualifikasiLainnyaController.text =
        GetStorage().read('project_respondent_kualifikasi_lainnya') ?? '';

    _minAgeController.text = GetStorage().read('min_respondent_age') ?? '';
    _maxAgeController.text = GetStorage().read('max_respondent_age') ?? '';

    _projectRespondentKabKotaTinggalController.text =
        GetStorage().read('project_respondent_kab_kota_tinggal') ?? '';
    _projectRespondentHobiController.text =
        GetStorage().read('project_respondent_hobi') ?? '';
    _projectRespondentStatusKawinController.text =
        GetStorage().read('project_respondent_status_kawin') ?? '';
    _projectRespondentPendidikanController.text =
        GetStorage().read('project_respondent_pendidikan') ?? '';
    _projectRespondentPekerjaanController.text =
        GetStorage().read('project_respondent_pekerjaan') ?? '';
  }

  @override
  void dispose() {
    _projectRespondentKualifikasiLainnyaController.dispose();
    _projectRespondentUsiaRangeController.dispose();

    _minAgeController.dispose();
    _maxAgeController.dispose();

    _projectRespondentKabKotaTinggalController.dispose();
    _projectRespondentHobiController.dispose();
    _projectRespondentStatusKawinController.dispose();
    _projectRespondentPekerjaanController.dispose();
    _projectRespondentPendidikanController.dispose();
    super.dispose();
  }

  void _saveProjectRespondentUsiaRange(String value) {
    GetStorage().write('project_respondent_usia_range', value);
  }

  void _saveProjectRespondentKabKotaTinggal(String value) {
    GetStorage().write('project_respondent_kab_kota_tinggal', value);
  }

  void _saveProjectRespondentHobi(String value) {
    GetStorage().write('project_respondent_hobi', value);
  }

  void _saveProjectRespondentStatusKawin(String value) {
    GetStorage().write('project_respondent_status_kawin', value);
  }

  void _saveProjectRespondentPendidikan(String value) {
    GetStorage().write('project_respondent_pendidikan', value);
  }

  void _saveProjectRespondentPekerjaan(String value) {
    GetStorage().write('project_respondent_pekerjaan', value);
  }

  void _saveProjectRespondentKualifikasiLainnya(String value) {
    GetStorage().write('project_respondent_kualifikasi_lainnya', value);
  }

  void _saveDraft() {
    _saveProjectRespondentUsiaRange(_projectRespondentUsiaRangeController.text);
    _saveProjectRespondentKualifikasiLainnya(
        _projectRespondentKualifikasiLainnyaController.text);
    _saveProjectRespondentKabKotaTinggal(
        _projectRespondentKabKotaTinggalController.text);
    _saveProjectRespondentHobi(_projectRespondentHobiController.text);
    _saveProjectRespondentStatusKawin(
        _projectRespondentStatusKawinController.text);
    _saveProjectRespondentPendidikan(
        _projectRespondentPendidikanController.text);
    _saveProjectRespondentPekerjaan(_projectRespondentPekerjaanController.text);
    _saveProjectRespondentPendidikan(
        _projectRespondentPendidikanController.text);
  }

  // Selection for Status Perkawinan, Tingkat Pendidikan, Pekerjaan bottom sheet modal
  void _showSelectionModal({
    required BuildContext context,
    required String title,
    required List<String> options,
    required Function(String) onSelected,
    bool hasSearch = false, // Enable search only for "Pekerjaan"
  }) {
    TextEditingController searchController = TextEditingController();
    List<String> filteredOptions = options;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Color(0xFFF0E8E4),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle Bar
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Color(0xFFB0B0B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Title
                  Text(
                    title,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF705D54),
                    ),
                  ),

                  // Search Bar (Only for "Pekerjaan")
                  if (hasSearch)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: TextField(
                        controller: searchController,
                        onChanged: (query) {
                          setState(() {
                            filteredOptions = options
                                .where((item) => item
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Cari pekerjaan...",
                          hintStyle: GoogleFonts.nunitoSans(
                            color: Color(0xFFA3948D),
                            fontStyle: FontStyle.italic,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                          ),
                        ),
                      ),
                    ),

                  // Options List
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredOptions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          filteredOptions[index],
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14,
                            color: Color(0xFF705D54),
                          ),
                        ),
                        onTap: () {
                          onSelected(
                              filteredOptions[index]); // Callback function
                          Navigator.pop(context); // Close modal
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // WIDGET general picker, used for status perkawinan, tingkat pendidikan, pekerjaan
  Widget _buildSelectableTextField({
    required String title,
    required TextEditingController controller,
    required String hintText,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.nunitoSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF705D54),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.nunitoSans(color: Color(0xFFA3948D)),
                prefixIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(child: icon),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF826754), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF826754), width: 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Function for widget
  void _showMultiSelectGrid({
    required BuildContext context,
    required String title,
    required List<String> options,
    required List<String> selectedValues,
    required Function(List<String>) onConfirm,
    bool enableSearch = false, // ✅ Only true for "Pekerjaan"
  }) {
    TextEditingController searchController = TextEditingController();
    List<String> filteredOptions = List.from(options);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow full-height modal control
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height *
                  0.6, // ✅ Limit height to 60% of screen
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Color(0xFFB0B0B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Title
                  Text(
                    title,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 12),

                  // ✅ Search Bar (Only for Pekerjaan)
                  if (enableSearch)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            filteredOptions = options
                                .where((option) => option
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Cari...",
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xFF705D54)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF826754)),
                          ),
                        ),
                      ),
                    ),

                  // ✅ Multi-Select Grid
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: filteredOptions.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two columns per row
                        childAspectRatio: 3, // Box height
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        String option = filteredOptions[index];
                        bool isSelected = selectedValues.contains(option);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedValues.contains(option)) {
                                selectedValues.remove(option);
                              } else {
                                selectedValues.add(option);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Color(0xFF826754) : Colors.white,
                              border: Border.all(color: Color(0xFF826754)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Text(
                              option,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Color(0xFF705D54),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ✅ Footer with Background
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirm(selectedValues);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF826754), // ✅ Matches "Lanjut" button
                        foregroundColor: Color(0xFFEDE7E2), // ✅ Brown text
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // 8dp rounded rectangle
                        ),
                      ),
                      child: Text("Simpan",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSingleSelectGrid({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelected,
    bool enableSearch = false,
  }) {
    TextEditingController searchController = TextEditingController();
    List<String> filteredOptions = List.from(options);
    String? currentSelection = selectedValue;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Color(0xFFB0B0B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Title
                  Text(
                    title,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Search Bar
                  if (enableSearch)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            filteredOptions = options
                                .where((option) => option
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Cari...",
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xFF705D54)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF826754)),
                          ),
                        ),
                      ),
                    ),

                  // Single-Select Grid
                  Expanded(
                    child: GridView.builder(
                      itemCount: filteredOptions.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        String option = filteredOptions[index];
                        bool isSelected = currentSelection == option;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelection = option;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Color(0xFF826754) : Colors.white,
                              border: Border.all(color: Color(0xFF826754)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Text(
                              option,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Color(0xFF705D54),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Confirm Button
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentSelection != null) {
                          onSelected(currentSelection!);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF826754),
                        foregroundColor: Color(0xFFEDE7E2),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Simpan",
                        style:
                            GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Hobby picker
  void _showHobbySelectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      backgroundColor: Color(0xFFF0E8E4),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilih setidaknya satu hobi",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 16),

                  // HOBBY GRID SELECTION
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _hobbyList.length,
                    itemBuilder: (context, index) {
                      final hobby = _hobbyList[index];
                      final isSelected =
                          _selectedHobbies.contains(hobby["name"]);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedHobbies.remove(hobby["name"]);
                            } else {
                              _selectedHobbies.add(hobby["name"]);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Color(0xFF826754) : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Color(0xFF826754), width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Iconify(hobby["icon"].toString(),
                                  color: isSelected
                                      ? Colors.white
                                      : Color(0xFF826754)),
                              SizedBox(height: 4),
                              Text(
                                hobby["name"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white
                                      : Color(0xFF826754),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 16),

                  // BUTTON ROW
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFEDE7E2)),
                            foregroundColor: Color(0xFFEDE7E2),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Batal",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _projectRespondentHobiController.text =
                                _selectedHobbies.join(", ");
                            _saveProjectRespondentHobi(
                                _selectedHobbies.join(", "));
                            Navigator.pop(context);
                            setState(() {}); // Refresh UI
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEDE7E2),
                            foregroundColor: Color(0xFF826754),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Simpan",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Age range picker
  void _showAgeRangeModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the modal to resize with the keyboard
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tetapkan Rentang Usia",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF705D54),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _minAgeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Usia Minimum",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _maxAgeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Usia Maksimum",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.only(bottom: 16), // ✅ Add bottom margin
                  child: SizedBox(
                    width: double.infinity, // ✅ Full width
                    child: ElevatedButton(
                      onPressed: () {
                        // Combine min and max age into a single string
                        String range =
                            "${_minAgeController.text}-${_maxAgeController.text}";
                        _projectRespondentUsiaRangeController.text = range;

                        // Save the range to storage
                        _saveProjectRespondentUsiaRange(range);

                        // Close the modal
                        Navigator.pop(context);
                        setState(() {}); // Update the UI
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF826754), // ✅ Corrected Background Color
                        foregroundColor: Color(
                            0xFFEDE7E2), // ✅ Match Bottom Navigation Text Color
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // ✅ 8dp rounded rectangle
                        ),
                      ),
                      child: Text(
                        "Simpan",
                        style:
                            GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: AppBar(
        title: Text('Scouting Respondent',
            style: GoogleFonts.nunitoSans(
                fontSize: 16,
                color: Color(0xFF705D54),
                fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFD7CCC8),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF826754)),
        leading: IconButton(
          icon: Iconify(MaterialSymbols.arrow_back, color: Color(0xFF826754)),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Iconify(MaterialSymbols.more_vert, color: Color(0xFF826754)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            //Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress bar with full width and 16dp spacing
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.0), // Add 16dp spacing below progress bar
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF826754),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF826754),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF826754),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Title "Langkah 3"
                Text(
                  'Langkah 3',
                  style: TextStyle(
                    color: Color(0xFF705D54),
                    fontSize: 24,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Ceritakan kriteria latar belakang responden yang Anda butuhkan. ',
                    style: GoogleFonts.nunitoSans(
                      color: Color(0xFFA3948D),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Biarkan kosong untuk bagian yang tidak memiliki syarat mengikat.',
                    style: GoogleFonts.nunitoSans(
                      color: Color(0xFFA3948D),
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: _showAgeRangeModal, // Trigger the modal popup
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rentang Usia",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _projectRespondentUsiaRangeController,
                    enabled: false, // Disable direct editing
                    decoration: InputDecoration(
                      hintText: "Seluruh usia", // Default hint text
                      hintStyle:
                          GoogleFonts.nunitoSans(color: Color(0xFFA3948D)),
                      prefixIcon: SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(
                          child: Iconify(
                            Healthicons.elderly_outline, // Icon on the left
                            color: Color(0xFF826754),
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Color(0xFF826754), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Color(0xFFD9D9D9), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Color(0xFF826754), width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Kabupaten/Kota Tempat Tinggal",
              controller: _projectRespondentKabKotaTinggalController,
              hintText: "Semua Kabupaten/Kota",
              icon: Iconify(Mdi.home_variant_outline, color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectRespondentKabKotaTinggal(value);
                setState(() {}); // Force UI to update
              },
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _showHobbySelectionModal,
              child: AbsorbPointer(
                child: _buildEditableTextField(
                  title: "Hobi",
                  controller: _projectRespondentHobiController,
                  hintText: "Semua hobi",
                  icon: Iconify(AntDesign.heart_outline,
                      color: Color(0xFF826754)),
                  onChanged: (value) {},
                ),
              ),
            ),

            SizedBox(height: 16),
            _buildSelectableTextField(
              title: "Status Perkawinan",
              controller: _projectRespondentStatusKawinController,
              hintText: "Semua status perkawinan",
              icon: Iconify(Mdi.human_male_female, color: Color(0xFF826754)),
              onTap: () => _showSingleSelectGrid(
                context: context,
                title: "Pilih Status Perkawinan",
                options: maritalStatusOptions,
                selectedValue: _projectRespondentStatusKawinController
                    .text, // Single value
                onSelected: (selected) {
                  _projectRespondentStatusKawinController.text = selected;
                  _saveProjectRespondentStatusKawin(selected);
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 16),
            _buildSelectableTextField(
              title: "Tingkat Pendidikan",
              controller: _projectRespondentPendidikanController,
              hintText: "Pilih tingkat pendidikan",
              icon: Iconify(Mdi.school, color: Color(0xFF826754)),
              onTap: () => _showSingleSelectGrid(
                context: context,
                title: "Pilih Tingkat Pendidikan",
                options: educationLevelOptions,
                selectedValue:
                    _projectRespondentPendidikanController.text, // Single value
                onSelected: (selected) {
                  _projectRespondentPendidikanController.text = selected;
                  _saveProjectRespondentPendidikan(
                      selected); // Kalau ada logic simpan
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 16),
            _buildSelectableTextField(
              title: "Pekerjaan",
              controller: _projectRespondentPekerjaanController,
              hintText: "Semua bidang pekerjaan",
              icon: Iconify(Mdi.briefcase, color: Color(0xFF826754)),
              onTap: () => _showSingleSelectGrid(
                context: context,
                title: "Pilih Pekerjaan",
                options: jobOptions,
                selectedValue: _projectRespondentPekerjaanController.text,
                onSelected: (selected) {
                  _projectRespondentPekerjaanController.text = selected;
                  _saveProjectRespondentPekerjaan(selected);
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Kualifikasi Lainnya",
              controller: _projectRespondentKualifikasiLainnyaController,
              hintText:
                  "Contoh : 'Menggunakan produk kecantikan secara rutin dalam sebulan terakhir...'",
              icon: Iconify(Gis.search_propertie, color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectRespondentKualifikasiLainnya(value);
                setState(() {}); // Force UI to update
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Color(0xFF826754), // Footer background color
        child: Row(
          children: [
            // Kembali Button (Outlined) - Takes Half Width
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFEDE7E2)),
                  foregroundColor: Color(0xFFEDE7E2),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // 8dp rounded rectangle
                  ),
                ),
                child: Text("Kembali",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              ),
            ),

            SizedBox(width: 8), // Space between buttons

            // Lanjut Button (Filled) - Takes Half Width
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isFormComplete()
                    ? () async {
                        final rawCommission = widget.commission ?? '';
                        final cleanedCommission =
                            rawCommission.replaceAll(RegExp(r'[^0-9]'), '');
                        String? token = await _getToken();
                        final response = await http.post(
                          Uri.parse(
                              'https://surveyscoutbe.onrender.com/api/v1/responds/createRespondDraft'),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $token',
                          },
                          body: jsonEncode({
                            "nama_proyek": widget.title,
                            "deskripsi_proyek": widget.description,
                            "tenggat_pengerjaan": widget.completionDeadline,
                            "lokasi": widget.location,
                            "keahlian":
                                _projectRespondentKualifikasiLainnyaController
                                    .text,
                            "kompensasi": int.tryParse(cleanedCommission) ?? 0,
                            "metode_survey": widget.method,
                            "jumlah_responden": widget.respondentAmount,
                            "tugas": widget.task,
                            "tenggat_pendaftaran": widget.registrationDeadline,
                            "rentang_usia": [
                              int.tryParse(_minAgeController.text) ?? 0,
                              int.tryParse(_maxAgeController.text) ?? 0
                            ],
                            "hobi": _projectRespondentHobiController.text
                                .split(',')
                                .map((e) => e.trim())
                                .toList(),
                          }),
                        );

                        if (response.statusCode == 201) {
                          final data = jsonDecode(response.body);
                          final idDraft = data['data']['id_draft'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TransactionReviewRespondentScreen(
                                      idDraft: idDraft.toString(),
                                      commission:
                                          int.tryParse(cleanedCommission) ?? 0),
                            ),
                          );

                          Future.delayed(Duration(milliseconds: 500), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Proyek Anda telah berhasil dibuat dan tersimpan."),
                                backgroundColor: Color(0xFF826754),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(16),
                              ),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Terjadi kesalahan saat membuat proyek. Silakan coba lagi."),
                              backgroundColor: Color(0xFF826754),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(16),
                            ),
                          );
                        }
                      }
                    : null, // Disable if incomplete
                icon: Icon(Icons.arrow_forward, size: 20),
                label: Text("Lanjut",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormComplete()
                      ? Color(0xFFEDE7E2)
                      : Color(0xFFB5A89A), // Disabled color if incomplete
                  foregroundColor: Color(0xFF826754), // Text/icon color
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // 8dp rounded rectangle
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildEditableTextField({
  required String title,
  required TextEditingController controller,
  required String hintText,
  required Widget icon,
  required Function(String) onChanged,
  bool enabled = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.nunitoSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF705D54),
        ),
      ),
      SizedBox(height: 8),
      TextField(
        controller: controller,
        onChanged: onChanged,
        enabled: enabled,
        maxLines: null, // Allow multi-line input
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.nunitoSans(color: Color(0xFFA3948D)),
          prefixIcon: SizedBox(
              width: 24,
              height: 24,
              child: Center(child: icon)), // Icon inside text field
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF826754), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF826754), width: 2),
          ),
        ),
      ),
    ],
  );
}
