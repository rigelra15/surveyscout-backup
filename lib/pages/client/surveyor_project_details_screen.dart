import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/pages/client/choose_recruitment_screen.dart';
import 'package:surveyscout/pages/client/transaction_review_screen.dart';
import 'package:surveyscout/routes/app_routes.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurveyorProjectDetailsScreen extends StatefulWidget {
  @override
  _SurveyorProjectDetailsScreenState createState() =>
      _SurveyorProjectDetailsScreenState();
}

class _SurveyorProjectDetailsScreenState
    extends State<SurveyorProjectDetailsScreen> {
  final TextEditingController _projectDescriptionController =
      TextEditingController();
  final TextEditingController _projectTitleController = TextEditingController();
  final TextEditingController _projectQualificationController =
      TextEditingController();
  final TextEditingController _projectOutcomeController =
      TextEditingController();
  final TextEditingController _projectCommissionController =
      TextEditingController();
  final TextEditingController _projectLocationController =
      TextEditingController();
  final TextEditingController _projectDeadlineController =
      TextEditingController();

  bool _isFormComplete() {
    return _projectTitleController.text.isNotEmpty &&
        _projectDescriptionController.text.isNotEmpty &&
        _projectQualificationController.text.isNotEmpty &&
        _projectOutcomeController.text.isNotEmpty &&
        _projectCommissionController.text.isNotEmpty &&
        _projectLocationController.text.isNotEmpty &&
        _projectDeadlineController.text.isNotEmpty;
  }

  bool _isFormFilled() {
    return _projectTitleController.text.isNotEmpty ||
        _projectDescriptionController.text.isNotEmpty ||
        _projectQualificationController.text.isNotEmpty ||
        _projectOutcomeController.text.isNotEmpty ||
        _projectCommissionController.text.isNotEmpty ||
        _projectLocationController.text.isNotEmpty;
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

  void _showSaveDraftBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      backgroundColor: Color(0xFFF0E8E4),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 4,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Color(0xFFB0B0B0),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Simpan sebagai draft?",
              style: TextStyle(
                color: Color(0xFF705D54),
                fontSize: 24,
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w700,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              "Anda dapat melanjutkannya lain kali",
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                color: Color(0xFFA3948D),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xFF826754),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveDraft();
                        Get.back();
                        Get.toNamed(AppRoutes.clientProjectList);
                        Future.delayed(Duration(milliseconds: 500), () {
                          Get.snackbar(
                            "Draft tersimpan",
                            "Anda dapat melanjutkan pengisian proyek kapan saja.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Color(0xFF826754),
                            colorText: Colors.white,
                            margin: EdgeInsets.all(16),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEDE7E2),
                        foregroundColor: Color(0xFF826754),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Ya, Simpan",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _clearFormData();
                        Navigator.pop(context);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChooseRecruitmentScreen()));

                        Future.delayed(Duration(milliseconds: 500), () {
                          final snackBar = SnackBar(
                            content: Text(
                              "Anda membatalkan proyek ini.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(0xFF826754),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFFEDE7E2)),
                        foregroundColor: Color(0xFFEDE7E2),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Jangan Simpan",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearFormData() {
    final box = GetStorage();
    box.remove('project_description');
    box.remove('project_title');
    box.remove('project_qualification');
    box.remove('project_outcome');
    box.remove('project_commission');
    box.remove('project_respondent_amount');
    box.remove('project_location');
    box.remove('project_deadline');

    setState(() {
      _projectDescriptionController.clear();
      _projectTitleController.clear();
      _projectQualificationController.clear();
      _projectOutcomeController.clear();
      _projectCommissionController.clear();
      _projectLocationController.clear();
      _projectDeadlineController.clear();
    });

    print("All form data cleared!");
  }

  Widget _buildKomisiTextField({
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Komisi",
          style: GoogleFonts.nunitoSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF705D54),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: false),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
            if (numericValue.isNotEmpty) {
              int parsedValue = int.parse(numericValue);
              String formattedValue =
                  "Rp ${NumberFormat("#,###", "id_ID").format(parsedValue)}";

              controller.value = TextEditingValue(
                text: formattedValue,
                selection:
                    TextSelection.collapsed(offset: formattedValue.length),
              );

              _saveProjectCommission(parsedValue.toString());
            }
          },
          decoration: InputDecoration(
            hintText: "Rp 0",
            hintStyle: GoogleFonts.nunitoSans(color: Color(0xFFA3948D)),
            prefixIcon: SizedBox(
                width: 24,
                height: 24,
                child:
                    Center(child: Iconify(Ph.money, color: Color(0xFF826754)))),
            prefixStyle: GoogleFonts.nunitoSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF705D54),
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
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _projectDescriptionController.text =
        GetStorage().read('project_description') ?? '';
    _projectTitleController.text = GetStorage().read('project_title') ?? '';
    _projectQualificationController.text =
        GetStorage().read('project_qualification') ?? '';
    _projectOutcomeController.text = GetStorage().read('project_outcome') ?? '';
    _projectCommissionController.text =
        GetStorage().read('project_commission') ?? '';
    _projectLocationController.text =
        GetStorage().read('project_location') ?? '';
    _projectDeadlineController.text =
        GetStorage().read('project_deadline') ?? '';

    DateTime defaultDeadline =
        DateTime.now().add(Duration(days: 7)).copyWith(hour: 23, minute: 59);

    final DateFormat formatter =
        DateFormat('HH.mm, EEEE, dd MMMM yyyy', 'id_ID');
    String formattedDeadline = formatter.format(defaultDeadline);

    _projectDeadlineController.text =
        GetStorage().read('project_deadline') ?? formattedDeadline;
  }

  @override
  void dispose() {
    _projectDescriptionController.dispose();
    _projectTitleController.dispose();
    _projectQualificationController.dispose();
    _projectOutcomeController.dispose();
    _projectCommissionController.dispose();
    _projectLocationController.dispose();
    _projectDeadlineController.dispose();
    super.dispose();
  }

  void _saveProjectDescription(String value) {
    GetStorage().write('project_description', value);
  }

  void _saveProjectTitle(String value) {
    GetStorage().write('project_title', value);
  }

  void _saveProjectQualification(String value) {
    GetStorage().write('project_qualification', value);
  }

  void _saveProjectOutcome(String value) {
    GetStorage().write('project_outcome', value);
  }

  void _saveProjectCommission(String value) {
    GetStorage().write('project_commission', value);
  }

  void _saveProjectLocation(String value) {
    GetStorage().write('project_location', value);
  }

  void _saveProjectDeadline(String value) {
    GetStorage().write('project_deadline', value);
  }

  void _saveDraft() {
    _saveProjectTitle(_projectTitleController.text);
    _saveProjectDescription(_projectDescriptionController.text);
    _saveProjectQualification(_projectQualificationController.text);
    _saveProjectOutcome(_projectOutcomeController.text);
    _saveProjectCommission(_projectCommissionController.text);
    _saveProjectLocation(_projectLocationController.text);
    _saveProjectDeadline(_projectDeadlineController.text);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final DateFormat formatter =
            DateFormat('HH.mm, EEEE, dd MMMM yyyy', 'id_ID');
        final String formattedDate = formatter.format(pickedDateTime);

        setState(() {
          _projectDeadlineController.text = formattedDate;
          _saveProjectDeadline(formattedDate);
        });
      }
    }
  }

  bool _isRemote = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: AppBar(
        title: Text('Buat Proyek',
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
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
                            color: Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Langkah 2',
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
            Text(
              'Ceritakan kebutuhan proyek Anda. Mohon isi seluruh bagian berikut agar proyek Anda dapat lebih dipahami surveyor.',
              style: GoogleFonts.nunitoSans(
                color: Color(0xFFA3948D),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            _buildEditableTextField(
              title: "Judul Proyek",
              controller: _projectTitleController,
              hintText: "Survei Kepuasan Masyarakat",
              icon: Iconify(Ic.outline_book, color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectTitle(value);
                setState(() {});
              },
            ),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Deskripsi",
              controller: _projectDescriptionController,
              hintText: "Proyek ini adalah...",
              icon: Iconify(Mdi.text_long, color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectTitle(value);
                setState(() {});
              },
            ),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Kualifikasi",
              controller: _projectQualificationController,
              hintText: "Surveyor harus mampu dalam...",
              icon:
                  Iconify(AntDesign.profile_outline, color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectTitle(value);
                setState(() {});
              },
            ),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Luaran",
              controller: _projectOutcomeController,
              hintText: "Excel, Foto, Video",
              icon: Iconify(AntDesign.paper_clip_outline,
                  color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectTitle(value);
                setState(() {});
              },
            ),
            SizedBox(height: 16),
            _buildKomisiTextField(controller: _projectCommissionController),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Lokasi",
              controller: _projectLocationController,
              hintText: "Surabaya",
              icon: Iconify(Mdi.location_outline, color: Color(0xFF826754)),
              onChanged: !_isRemote
                  ? (value) => _saveProjectLocation(value)
                  : (value) {},
              enabled: !_isRemote,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isRemote,
                  activeColor: Color(0xFF826754),
                  onChanged: (bool? value) {
                    setState(() {
                      _isRemote = value ?? false;
                      if (_isRemote) {
                        _projectLocationController.text = "Online";
                      } else {
                        _projectLocationController.clear();
                      }
                    });
                  },
                ),
                Text(
                  "Dapat dikerjakan dimana saja",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    color: Color(0xFF705D54),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            _buildDateTimeField(
              title: "Tenggat Waktu Pengiriman",
              controller: _projectDeadlineController,
              hintText: "Pilih tenggat waktu pengiriman",
              icon: Iconify(AntDesign.calendar, color: Color(0xFF826754)),
              onTap: () => _selectDate(context),
              onChanged: (value) {
                _saveProjectTitle(value);
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Color(0xFF826754),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  if (_isFormFilled()) {
                    _showSaveDraftBottomSheet();
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseRecruitmentScreen()));
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFEDE7E2)),
                  foregroundColor: Color(0xFFEDE7E2),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Kembali",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isFormComplete()
                    ? () async {
                        final rawCommission = _projectCommissionController.text;
                        final cleanedCommission =
                            rawCommission.replaceAll(RegExp(r'[^0-9]'), '');
                        String? token = await _getToken();
                        final response = await http.post(
                          Uri.parse(
                              'https://03d4-120-188-76-121.ngrok-free.app/api/v1/surveys/createSurveyDraft'),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $token',
                          },
                          body: jsonEncode({
                            "nama_proyek": _projectTitleController.text,
                            "deskripsi_proyek":
                                _projectDescriptionController.text,
                            "tenggat_pengerjaan":
                                _projectDeadlineController.text,
                            "lokasi": _projectLocationController.text,
                            "keahlian": _projectQualificationController.text
                                .split(',')
                                .map((e) => e.trim())
                                .toList(),
                            "kompensasi": int.tryParse(cleanedCommission) ?? 0,
                            "tipe_hasil": _projectOutcomeController.text
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
                              builder: (context) => TransactionReviewScreen(
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
                    : null,
                icon: Icon(Icons.arrow_forward,
                    size: 20, color: Color(0xFF826754)),
                label: Text(
                  "Lanjut",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isFormComplete() ? Color(0xFFEDE7E2) : Color(0xFFB5A89A),
                  foregroundColor: Color(0xFF826754),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeField(
      {required String title,
      required TextEditingController controller,
      required String hintText,
      required Widget icon,
      required Function() onTap,
      required Function(String) onChanged}) {
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
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'NunitoSans',
              color: Color(0xFFA3948D),
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon:
                SizedBox(width: 24, height: 24, child: Center(child: icon)),
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
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.nunitoSans(color: Color(0xFFA3948D)),
          prefixIcon:
              SizedBox(width: 24, height: 24, child: Center(child: icon)),
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
