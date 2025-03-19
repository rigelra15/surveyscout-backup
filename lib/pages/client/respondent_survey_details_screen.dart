// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/codicon.dart';
import 'package:surveyscout/routes/app_routes.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';

class RespondentSurveyDetailsScreen extends StatefulWidget {
  @override
  _RespondentSurveyDetailsScreenState createState() =>
      _RespondentSurveyDetailsScreenState();
}

class _RespondentSurveyDetailsScreenState
    extends State<RespondentSurveyDetailsScreen> {
  final TextEditingController _projectDescriptionController =
      TextEditingController();
  final TextEditingController _projectTitleController = TextEditingController();
  final TextEditingController _projectQualificationController =
      TextEditingController();
  final TextEditingController _projectOutcomeController =
      TextEditingController();
  final TextEditingController _projectCommissionController =
      TextEditingController();
  final TextEditingController _projectRespondentAmountController =
      TextEditingController();
  final TextEditingController _projectLocationController =
      TextEditingController();
  final TextEditingController _projectDeadlineController =
      TextEditingController();

  void _calculateTotalKomisi() {
    String commissionText = _projectCommissionController.text;
    String respondentText = _projectRespondentAmountController.text;
    int formattedComission =
        int.tryParse(commissionText.replaceAll(RegExp(r'[^0-9]'), '').trim()) ??
            0;

    print("Commission Text: $commissionText");
    print("Respondent Count Text: $respondentText");
    print("Formatted Comission: $formattedComission");

    int commission =
        int.tryParse(commissionText.replaceAll(RegExp(r'[^0-9]'), '').trim()) ??
            0;
    int respondentCount =
        int.tryParse(_projectRespondentAmountController.text) ?? 0;

    setState(() {
      _totalKomisi = commission * respondentCount;
    });
    print("Total Komisi Updated: Rp $_totalKomisi");
  }

  int _totalKomisi = 0;

  bool _isFormComplete() {
    return _projectTitleController.text.isNotEmpty &&
        _projectDescriptionController.text.isNotEmpty &&
        _projectQualificationController.text.isNotEmpty &&
        _projectOutcomeController.text.isNotEmpty &&
        _projectCommissionController.text.isNotEmpty &&
        _projectRespondentAmountController.text.isNotEmpty &&
        _projectLocationController.text.isNotEmpty &&
        _projectDeadlineController.text.isNotEmpty;
  }

  bool _isFormFilled() {
    return _projectTitleController.text.isNotEmpty ||
        _projectDescriptionController.text.isNotEmpty ||
        _projectQualificationController.text.isNotEmpty ||
        _projectOutcomeController.text.isNotEmpty ||
        _projectCommissionController.text.isNotEmpty ||
        _projectRespondentAmountController.text.isNotEmpty ||
        _projectLocationController.text.isNotEmpty;
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
            // Drag handle
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

            // Title
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

            // Subtitle
            Text(
              "Anda dapat melanjutkannya lain kali",
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                color: Color(0xFFA3948D),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),

            // Buttons Section with Background Color
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xFF826754), // Background color behind buttons
              child: Row(
                children: [
                  // Simpan Button (Filled)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveDraft();
                        Get.back(); // Close modal
                        Get.toNamed(AppRoutes.clientProjectList);
                        Future.delayed(Duration(milliseconds: 500), () {
                          Get.snackbar(
                            "Draft tersimpan",
                            "Anda dapat melanjutkan pengisian proyek kapan saja.",
                            snackPosition:
                                SnackPosition.BOTTOM, // Snackbar at bottom
                            backgroundColor: Color(0xFF826754),
                            colorText: Colors.white,
                            margin: EdgeInsets.all(16),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFEDE7E2), // Match "Lanjut" button
                        foregroundColor: Color(0xFF826754), // Text color
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // 8dp rounded rectangle
                        ),
                      ),
                      child: Text("Ya, Simpan",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold)),
                    ),
                  ),

                  SizedBox(width: 8), // Space between buttons

                  // Jangan Simpan Button (Outlined)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _clearFormData();
                        Get.back();
                        Get.toNamed(AppRoutes.clientProjectList);
                        Future.delayed(Duration(milliseconds: 500), () {
                          Get.snackbar(
                            "Proyek diurungkan",
                            "Anda membatalkan proyek ini.",
                            snackPosition:
                                SnackPosition.BOTTOM, // Snackbar at bottom
                            backgroundColor: Color(0xFF826754),
                            colorText: Colors.white,
                            margin: EdgeInsets.all(16),
                          );
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Color(0xFFEDE7E2)), // Match "Kembali" button
                        foregroundColor: Color(0xFFEDE7E2),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // 8dp rounded rectangle
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

  //  CLear data
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
    box.remove('project_respondent_kualifikasi_lainnya');
    box.remove('project_respondent_pekerjaan');
    box.remove('project_respondent_pendidikan');
    box.remove('project_respondent_status_kawin');
    box.remove('project_respondent_hobi');
    box.remove('project_respondent_kab_kota_tinggal');
    box.remove('project_respondent_usia_range');

    // Also clear UI fields if necessary
    setState(() {
      _projectDescriptionController.clear();
      _projectTitleController.clear();
      _projectQualificationController.clear();
      _projectOutcomeController.clear();
      _projectCommissionController.clear();
      _projectRespondentAmountController.clear();
      _projectLocationController.clear();
      _projectDeadlineController.clear();
    });

    print("All form data cleared!"); // Debugging log
  }

  // Widget Jumlah responden
  Widget _buildRespondentAmountTextField(
      {required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jumlah Responden",
          style: GoogleFonts.nunitoSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF705D54),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: (value) {
            _calculateTotalKomisi(); // ✅ Ensure the total updates dynamically
          },
          keyboardType: TextInputType.number,
          maxLines: 1, // ✅ Restrict to one line
          decoration: InputDecoration(
            hintText: "3",
            hintStyle: GoogleFonts.nunitoSans(color: Color(0xFFA3948D)),
            prefixIcon: SizedBox(
              width: 24,
              height: 24,
              child:
                  Center(child: Iconify(Ic.people, color: Color(0xFF826754))),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1),
            ),
            // ✅ Show border only when clicked (focused)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF826754), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // Widget Komisi, put here because local value of Komisi is inside class
  Widget _buildKomisiTextField({
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Komisi Satuan",
          style: GoogleFonts.nunitoSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF705D54),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(
              decimal: false), // Number-only keyboard
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Allow only numbers
          ],
          onChanged: (value) {
            String numericValue = value.replaceAll(
                RegExp(r'[^0-9]'), ''); // Strip non-numeric characters
            if (numericValue.isNotEmpty) {
              int parsedValue = int.parse(numericValue);
              String formattedValue =
                  "Rp ${NumberFormat("#,###", "id_ID").format(parsedValue)}";

              controller.value = TextEditingValue(
                text: formattedValue,
                selection:
                    TextSelection.collapsed(offset: formattedValue.length),
              );

              _saveProjectCommission(
                  parsedValue.toString()); // Save only number in cache
            }
            _calculateTotalKomisi();
          },
          decoration: InputDecoration(
            hintText: "Rp 0",
            hintStyle: GoogleFonts.nunitoSans(color: Color(0xFFA3948D)),
            prefixIcon: SizedBox(
                width: 24,
                height: 24,
                child: Center(
                    child: Iconify(Ph.money,
                        color: Color(0xFF826754)))), // Display "Rp" permanently
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
    _projectRespondentAmountController.text =
        GetStorage().read('project_respondent_amount') ?? '';
    _projectLocationController.text =
        GetStorage().read('project_location') ?? '';
    _projectDeadlineController.text =
        GetStorage().read('project_deadline') ?? '';

    // Get today's date +7 days at 23:59
    DateTime defaultDeadline =
        DateTime.now().add(Duration(days: 7)).copyWith(hour: 23, minute: 59);

    // Format correctly
    final DateFormat formatter =
        DateFormat('HH.mm, EEEE, dd MMMM yyyy', 'id_ID');
    String formattedDeadline = formatter.format(defaultDeadline);

    // Set initial text with formatted deadline
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
    _projectRespondentAmountController.dispose();
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

  void _saveRespondentAmount(String value) {
    GetStorage().write('project_respondent_amount', value);
  }

  void _saveDraft() {
    _saveProjectTitle(_projectTitleController.text);
    _saveProjectDescription(_projectDescriptionController.text);
    _saveProjectQualification(_projectQualificationController.text);
    _saveProjectOutcome(_projectOutcomeController.text);
    _saveProjectCommission(_projectCommissionController.text);
    _saveProjectCommission(_projectRespondentAmountController.text);
    _saveProjectLocation(_projectLocationController.text);
    _saveRespondentAmount(_projectRespondentAmountController.text);
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

        // Format the date correctly
        final DateFormat formatter =
            DateFormat('HH.mm, EEEE, dd MMMM yyyy', 'id_ID');
        final String formattedDate = formatter.format(pickedDateTime);

        // Update the controller with the formatted text
        setState(() {
          _projectDeadlineController.text = formattedDate;
          _saveProjectDeadline(formattedDate); // Save properly
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
                            color: Color(0xFFD9D9D9),
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

                // Title "Langkah 1"
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
              'Ceritakan kriteria proyek yang Anda butuhkan. Anda akan diminta memerincikan latar belakang responden yang dibutuhkan di langkah selanjutnya.',
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
                setState(() {}); // Force UI to update
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
                setState(() {}); // Force UI to update
              },
            ),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Metode",
              controller: _projectQualificationController,
              hintText: "Responden harus mengikuti interview...",
              icon: Iconify(Codicon.symbol_method, color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectTitle(value);
                setState(() {}); // Force UI to update
              },
            ),
            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Tugas",
              controller: _projectOutcomeController,
              hintText: "Kerjakanlah survei pada link ...",
              icon: Iconify(Bx.task, color: Color(0xFF826754)),
              onChanged: (value) {
                _saveProjectTitle(value);
                setState(() {}); // Force UI to update
              },
            ),
            SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildKomisiTextField(
                          controller: _projectCommissionController),
                    ),
                    SizedBox(width: 12), // Add spacing between fields
                    Expanded(
                        child: _buildRespondentAmountTextField(
                            controller: _projectRespondentAmountController)),
                  ],
                ),
                SizedBox(height: 8), // Space before total text
                Text(
                  "Total komisi dibutuhkan : Rp ${NumberFormat('#,###', 'id_ID').format(_totalKomisi)}",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF705D54),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            _buildEditableTextField(
              title: "Lokasi",
              controller: _projectLocationController,
              hintText: "Surabaya",
              icon: Iconify(Mdi.location_outline, color: Color(0xFF826754)),
              onChanged: !_isRemote // If checkbox is checked, disable editing
                  ? (value) => _saveProjectLocation(value)
                  : (value) {}, // Empty function to prevent null error
              enabled: !_isRemote, // Disable field if checkbox is checked
              // bgColor: _isRemote ? Color(0xFFD9D9D9) : Colors.white, // Grey out when checked
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
              title: "Tenggat Waktu Pendaftaran",
              controller: _projectDeadlineController,
              hintText: "Pilih tenggat waktu pengiriman",
              icon: Iconify(AntDesign.calendar, color: Color(0xFF826754)),
              onTap: () => _selectDate(context),
              onChanged: (value) {
                _saveProjectTitle(value);
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
                  if (_isFormFilled()) {
                    _showSaveDraftBottomSheet();
                  } else {
                    Get.toNamed(AppRoutes.clientProjectList);
                  }
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
                    ? () => Get.toNamed(AppRoutes.respondentCriteriaDetails)
                    : null, // Disable if incomplete
                icon: Icon(Icons.arrow_forward,
                    size: 20,
                    color: _isFormComplete()
                        ? Color(0xFF826754)
                        : Color(0xFFB5A89A)), // Icon color
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
              fontSize: 14, // Ensure proper visibility
              fontStyle: FontStyle.italic, // Italic text
              fontWeight:
                  FontWeight.w400, // Ensure it's not bold overriding italic
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
