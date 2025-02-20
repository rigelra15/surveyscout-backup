import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';
import 'package:file_picker/file_picker.dart';

class SurveyorSignUp extends StatefulWidget {
  const SurveyorSignUp({Key? key}) : super(key: key);

  @override
  State<SurveyorSignUp> createState() => _SurveyorSignUpState();
}

class _SurveyorSignUpState extends State<SurveyorSignUp> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaBankController = TextEditingController();
  final TextEditingController _nomorRekeningController = TextEditingController();
  final TextEditingController _tempatTinggalController = TextEditingController();
  final TextEditingController _keahlianController = TextEditingController();
  final TextEditingController _cvATSController = TextEditingController();
  final TextEditingController _pinAksesController = TextEditingController();
  final TextEditingController _konfirmasiPinController = TextEditingController();
  File? _selectedFile;

  bool _isObscured = true;
  bool _isLoading = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _pinAksesController.addListener(_validateForm);
    _konfirmasiPinController.addListener(_validateForm);
  }

  Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
    } catch (e) {
      print("Error menyimpan token: $e");
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

  bool _validateForm() {
    String pin = _pinAksesController.text.trim();
    String confirmPin = _konfirmasiPinController.text.trim();

    setState(() {
      _isButtonEnabled = pin.length == 6 &&
          confirmPin.length == 6 &&
          pin == confirmPin &&
          _selectedFile != null &&
          _namaLengkapController.text.isNotEmpty &&
          _jenisKelaminController.text.isNotEmpty &&
          _tanggalLahirController.text.isNotEmpty &&
          _nomorTeleponController.text.isNotEmpty &&
          _nikController.text.isNotEmpty &&
          _namaBankController.text.isNotEmpty &&
          _nomorRekeningController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _keahlianController.text.isNotEmpty;
    });
    return _isButtonEnabled;
  }

  Future<void> _submitForm() async {
    if (!_validateForm()) return;
    setState(() {
      _isLoading = true;
    });

    try {
      String? token = await _getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Autentikasi gagal, silakan login ulang."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://bcbf-118-99-84-39.ngrok-free.app/api/v1/surveyors/signInSurveyor"),
      );
      request.headers['Authorization'] = "Bearer $token";
      request.fields.addAll({
        "nama_lengkap": _namaLengkapController.text,
        "jenis_kelamin": _jenisKelaminController.text,
        "tanggal_lahir": _tanggalLahirController.text,
        "nomor_telepon": _nomorTeleponController.text,
        "nik": _nikController.text,
        "nama_bank": _namaBankController.text,
        "nomor_rekening": _nomorRekeningController.text,
        "tempat_tinggal": _tempatTinggalController.text,
        "keahlian": _keahlianController.text,
        "pin_akses": _pinAksesController.text,
      });

      if (_selectedFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'cv_ats',
          _selectedFile!.path,
        ));
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodedData = jsonDecode(responseData);

      if (response.statusCode == 200) {
        print("Registrasi berhasil: $responseData");
        if (decodedData.containsKey("token")) {
          await _saveToken(decodedData["token"]);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registrasi berhasil"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SurveyorProjects()),
        );
      } else {
        print("Registrasi gagal! Status Code: ${response.statusCode}");
        print("Response dari server: $responseData");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal mendaftar! Silakan coba lagi."),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print("Terjadi error saat registrasi: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _validateForm();
      });
    } else {
      print("Tidak ada file yang dipilih.");
    }
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _jenisKelaminController.dispose();
    _tanggalLahirController.dispose();
    _nomorTeleponController.dispose();
    _nikController.dispose();
    _namaBankController.dispose();
    _nomorRekeningController.dispose();
    _tempatTinggalController.dispose();
    _keahlianController.dispose();
    _cvATSController.dispose();
    _pinAksesController.dispose();
    _konfirmasiPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5),
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                'Selangkah Lagi!',
                style: TextStyle(
                  color: Color(0xFF705D54),
                  fontSize: 32,
                  fontFamily: 'SourceSans3',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Mohon isi data diri berikut',
                style: TextStyle(
                  color: Color(0xFFA3948D),
                  fontSize: 16,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              _buildInputField(
                controller: _namaLengkapController,
                label: "Nama Lengkap",
                hint: "John Doe",
                iconPath: "assets/images/namalengkap.png",
              ),
              _buildDivider(),

              _buildInputField(
                controller: _jenisKelaminController,
                label: "Jenis Kelamin",
                hint: "Laki-laki / Perempuan",
                iconPath: "assets/images/jeniskelamin.png",
              ),
              _buildDivider(),

              _buildInputField(
                controller: _tanggalLahirController,
                label: "Tanggal Lahir",
                hint: "1-Januari-1999",
                iconPath: "assets/images/tanggallahir.png",
              ),
              _buildDivider(),

              _buildInputField(
                controller: _nomorTeleponController,
                label: "Nomor Telepon",
                hint: "081234567890",
                iconPath: "assets/images/nomortelepon.png",
                keyboardType: TextInputType.phone,
              ),
              _buildDivider(),

              _buildInputField(
                controller: _nikController,
                label: "NIK",
                hint: "3403130101901001",
                iconPath: "assets/images/nik.png",
                keyboardType: TextInputType.number,
              ),
              _buildDivider(),

              _buildInputField(
                controller: _namaBankController,
                label: "Nama Bank",
                hint: "Bank Saya",
                iconPath: "assets/images/namabank.png",
              ),
              _buildDivider(),

              _buildInputField(
                controller: _nomorRekeningController,
                label: "Nomor Rekening",
                hint: "1234567890",
                iconPath: "assets/images/namaperusahaan.png",
                keyboardType: TextInputType.number,
              ),
              _buildDivider(),

              _buildInputField(
                controller: _tempatTinggalController,
                label: "Kabupaten/Kota Tempat Tinggal",
                hint: "Surabaya",
                iconPath: "assets/images/kabupaten.png",
              ),
              _buildDivider(),

              _buildInputField(
                controller: _keahlianController,
                label: "Keahlian",
                hint: "Excel, hitung manual, ...",
                iconPath: "assets/images/keahlian.png",
              ),
              _buildDivider(),

              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/jenisperusahaan.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'CV ATS',
                          style: TextStyle(
                            color: Color(0xFF705D54),
                            fontSize: 16,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: _pickFile,
                      icon: Image.asset(
                        'assets/images/unggah.png',
                        width: 24,
                        height: 24,
                      ),
                      label: Text(
                        "Unggah",
                        style: TextStyle(
                          color: Color(0xFF826754),
                          fontWeight: FontWeight.w700,
                          fontFamily: "NunitoSans",
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD7CCC8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _selectedFile != null
                  ? Text(
                "File dipilih: ${_selectedFile!.path.split('/').last}",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              )
                  : Container(),

              _buildPasswordField(
                controller: _pinAksesController,
                label: "PIN Akses",
                hint: "6 digit angka",
                iconPath: "assets/images/pinakses.png",
                keyboardType: TextInputType.number,
              ),
              _buildDivider(),

              _buildPasswordField(
                controller: _konfirmasiPinController,
                label: "Konfirmasi PIN Akses",
                hint: "Masukkan kembali PIN",
                iconPath: "assets/images/pinakses.png",
                keyboardType: TextInputType.number,
              ),
              _buildDivider(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled ? Color(0xFF826754) : Color(0xFFC4B8B1),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _isButtonEnabled ? _submitForm : null,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "Lanjut",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NunitoSans',
                      color: _isButtonEnabled ? Colors.white : Color(0xFFD7CCC8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String iconPath,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF705D54),
                      fontSize: 16,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextField(
                    controller: controller,
                    onChanged: (value) => _validateForm(),
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 16,
                        fontFamily: 'NunitoSans',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String iconPath,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF705D54),
                      fontSize: 16,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextField(
                    controller: controller,
                    onChanged: (value) => _validateForm(),
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 16,
                        fontFamily: 'NunitoSans',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF705D54),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        height: 1,
        color: Color(0xFF705D54),
      ),
    );
  }
}