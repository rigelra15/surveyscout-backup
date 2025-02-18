import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/pages/clientprojects.dart';

class ClientSignUp extends StatefulWidget {
  const ClientSignUp({Key? key}) : super(key: key);

  @override
  State<ClientSignUp> createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaBankController = TextEditingController();
  final TextEditingController _nomorRekeningController = TextEditingController();
  final TextEditingController _namaPerusahaanController = TextEditingController();
  final TextEditingController _jenisUsahaController = TextEditingController();
  final TextEditingController _pinAksesController = TextEditingController();
  final TextEditingController _konfirmasiPinController = TextEditingController();
  int nomortext = 0;

  bool _isObscured = true;
  bool _isLoading = false;

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

  Future<void> _removeToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
    } catch (e) {
      print("Error menghapus token: $e");
    }
  }

  bool _validateForm() {
    if (!RegExp(r'^[0-9]{6}$').hasMatch(_pinAksesController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PIN Akses harus terdiri dari 6 angka!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }


    if (_pinAksesController.text != _konfirmasiPinController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PIN Akses tidak cocok!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
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
        "nama_perusahaan": _namaPerusahaanController.text,
        "jenis_usaha": _jenisUsahaController.text,
        "pin_akses": _pinAksesController.text,
      };

      final response = await http.post(
        Uri.parse("https://a0f5-118-99-84-39.ngrok-free.app/api/v1/users/registerClient"),
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
          MaterialPageRoute(builder: (context) => SecondPage()),
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
    _namaPerusahaanController.dispose();
    _jenisUsahaController.dispose();
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
                hint: "YYYY-MM-DD",
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
                iconPath: "assets/images/nomorrekening.png",
                keyboardType: TextInputType.number,
              ),
              _buildDivider(),

              _buildInputField(
                controller: _namaPerusahaanController,
                label: "Nama Perusahaan",
                hint: "PT Maju Jaya",
                iconPath: "assets/images/namaperusahaan.png",
              ),
              _buildDivider(),

              _buildInputField(
                controller: _jenisUsahaController,
                label: "Jenis Usaha",
                hint: "Teknologi / Manufaktur",
                iconPath: "assets/images/jenisperusahaan.png",
              ),
              _buildDivider(),

              _buildPasswordField(
                controller: _pinAksesController,
                label: "PIN Akses",
                hint: "6 digit angka",
                iconPath: "assets/images/pinakses.png",
              ),
              _buildDivider(),

              _buildPasswordField(
                controller: _konfirmasiPinController,
                label: "Konfirmasi PIN Akses",
                hint: "Masukkan kembali PIN",
                iconPath: "assets/images/pinakses.png",
              ),
              _buildDivider(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: nomortext != 1 ? const Color(0xFFC4B8B1) : const Color(0xFF826754),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: nomortext == 1 ? _submitForm : null,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "Lanjut",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NunitoSans',
                      color: nomortext != 1 ? const Color(0xFFD7CCC8) : const Color(0xFFF1E9E5),
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