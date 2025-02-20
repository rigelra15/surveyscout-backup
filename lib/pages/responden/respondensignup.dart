import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';

class RespondenSignUp extends StatefulWidget {
  const RespondenSignUp({Key? key}) : super(key: key);

  @override
  State<RespondenSignUp> createState() => _RespondenSignUpState();
}

class _RespondenSignUpState extends State<RespondenSignUp> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaBankController = TextEditingController();
  final TextEditingController _nomorRekeningController = TextEditingController();
  final TextEditingController _tempatTinggalController = TextEditingController();
  final TextEditingController _hobiController = TextEditingController();
  final TextEditingController _statusPerkawinanController = TextEditingController();
  final TextEditingController _tingkatPendidikanController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _pinAksesController = TextEditingController();
  final TextEditingController _konfirmasiPinController = TextEditingController();

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
          _namaLengkapController.text.isNotEmpty &&
          _jenisKelaminController.text.isNotEmpty &&
          _tanggalLahirController.text.isNotEmpty &&
          _nomorTeleponController.text.isNotEmpty &&
          _nikController.text.isNotEmpty &&
          _namaBankController.text.isNotEmpty &&
          _nomorRekeningController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _hobiController.text.isNotEmpty &&
          _statusPerkawinanController.text.isNotEmpty &&
          _tingkatPendidikanController.text.isNotEmpty &&
          _pekerjaanController.text.isNotEmpty;
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
      final Map<String, dynamic> requestData = {
        "nama_lengkap": _namaLengkapController.text,
        "jenis_kelamin": _jenisKelaminController.text,
        "tanggal_lahir": _tanggalLahirController.text,
        "nomor_telepon": _nomorTeleponController.text,
        "nik": _nikController.text,
        "nama_bank": _namaBankController.text,
        "nomor_rekening": _nomorRekeningController.text,
        "tempat_tinggal": _tempatTinggalController.text,
        "hobi": _hobiController.text,
        "status_perkawinan": _statusPerkawinanController.text,
        "tingkat_pendidikan": _tingkatPendidikanController.text,
        "pekerjaan": _pekerjaanController.text,
        "pin_akses": _pinAksesController.text,
      };

      final response = await http.post(
        Uri.parse("https://bcbf-118-99-84-39.ngrok-free.app/api/v1/responden/signInResponden"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print("Registrasi berhasil: ${response.body}");
        final data = jsonDecode(response.body);
        if (data.containsKey("token")) {
          await _saveToken(data["token"]);
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
          MaterialPageRoute(builder: (context) => RespondenProjects()),
        );
      } else {
        print("Registrasi gagal! Status Code: ${response.statusCode}");
        print("Response dari server: ${response.body}");
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
    _hobiController.dispose();
    _statusPerkawinanController.dispose();
    _tingkatPendidikanController.dispose();
    _pekerjaanController.dispose();
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
          ),
        ),
      ),
    );
  }
}