// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/pages/responden/respondenpages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/maki.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:google_fonts/google_fonts.dart';

class RespondenSignUp extends StatefulWidget {
  const RespondenSignUp({Key? key}) : super(key: key);

  @override
  State<RespondenSignUp> createState() => _RespondenSignUp();
}

class _RespondenSignUp extends State<RespondenSignUp> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaBankController = TextEditingController();
  final TextEditingController _nomorRekeningController =
      TextEditingController();
  final TextEditingController _tempatTinggalController =
      TextEditingController();
  final TextEditingController _hobiController = TextEditingController();
  final TextEditingController _statusPerkawinanController =
      TextEditingController();
  final TextEditingController _tingkatPendidikanController =
      TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _pinAksesController = TextEditingController();
  final TextEditingController _konfirmasiPinController =
      TextEditingController();

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
                            _hobiController.text = _selectedHobbies.join(', ');
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

  // WIDGET general picker, used for status perkawinan, tingkat pendidikan, pekerjaan
  Widget _buildSelectableTextField({
    required String title,
    required TextEditingController controller,
    required String hintText,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24), // aligns icon vertically
          child: icon,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF705D54),
                  fontSize: 16,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: AbsorbPointer(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
    print("Submit button clicked");
    print("Nama Lengkap: ${_namaLengkapController.text}");
    print("Jenis Kelamin: ${_jenisKelaminController.text}");
    print("Tanggal Lahir: ${_tanggalLahirController.text}");
    print("Nomor Telepon: ${_nomorTeleponController.text}");
    print("NIK: ${_nikController.text}");
    print("Nama Bank: ${_namaBankController.text}");
    print("Nomor Rekening: ${_nomorRekeningController.text}");
    print("Tempat Tinggal: ${_tempatTinggalController.text}");
    print("Hobi: ${_hobiController.text}");
    print("Status Perkawinan: ${_statusPerkawinanController.text}");
    print("Tingkat Pendidikan: ${_tingkatPendidikanController.text}");
    print("Pekerjaan: ${_pekerjaanController.text}");
    print("PIN Akses: ${_pinAksesController.text}");
    print("Konfirmasi PIN Akses: ${_konfirmasiPinController.text}");

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
        "domisili": _tempatTinggalController.text,
        "hobi": _hobiController.text,
        "status_perkawinan": _statusPerkawinanController.text,
        "tingkat_pendidikan": _tingkatPendidikanController.text,
        "pekerjaan": _pekerjaanController.text,
        "pin_akses": _pinAksesController.text,
      };

      final response = await http.post(
        Uri.parse(
            "https://surveyscoutbe.onrender.com/api/v1/respondents/signInResponden"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 201) {
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
          MaterialPageRoute(builder: (context) => RespondenPages()),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12), // adjust as needed for alignment
                    child: Image.asset("assets/images/jeniskelamin.png",
                        width: 30, height: 30),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            color: Color(0xFF705D54),
                            fontSize: 16,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Pria',
                              groupValue: _jenisKelaminController.text,
                              onChanged: (value) {
                                setState(() {
                                  _jenisKelaminController.text = value!;
                                  _validateForm();
                                });
                              },
                              fillColor:
                                  MaterialStateProperty.all(Color(0xFF705D54)),
                            ),
                            const Text(
                              'Pria',
                              style: TextStyle(color: Color(0xFF705D54)),
                            ),
                            Radio<String>(
                              value: 'Wanita',
                              groupValue: _jenisKelaminController.text,
                              onChanged: (value) {
                                setState(() {
                                  _jenisKelaminController.text = value!;
                                  _validateForm();
                                });
                              },
                              fillColor:
                                  MaterialStateProperty.all(Color(0xFF705D54)),
                            ),
                            const Text(
                              'Wanita',
                              style: TextStyle(color: Color(0xFF705D54)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildDivider(),
              Row(
                children: [
                  Image.asset("assets/images/tanggallahir.png",
                      width: 30, height: 30),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tanggal Lahir",
                          style: TextStyle(
                            color: Color(0xFF705D54),
                            fontSize: 16,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _tanggalLahirController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: Color(0xFF826754),
                                      onPrimary: Color(0xFFF1E9E5),
                                      surface: Color(0xFFD7CCC8),
                                      onSurface: Colors.black,
                                    ),
                                    dialogBackgroundColor: Color(0xFFD7CCC8),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setState(() {
                                _tanggalLahirController.text =
                                    "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                                _validateForm();
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: '1 Januari 1999',
                            hintStyle: const TextStyle(
                              color: Color(0xFFB0B0B0),
                              fontSize: 16,
                              fontFamily: 'NunitoSans',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                digitsOnly: true,
              ),
              _buildDivider(),
              _buildInputField(
                controller: _tempatTinggalController,
                label: "Kabupaten/Kota Tempat Tinggal",
                hint: "Surabaya",
                iconPath: "assets/images/kabupaten.png",
              ),
              _buildDivider(),
              GestureDetector(
                onTap: () => _showHobbySelectionModal(),
                child: AbsorbPointer(
                  child: _buildInputField(
                    controller: _hobiController,
                    label: "Hobi",
                    hint: "Pilih hobi...",
                    iconPath: "assets/images/hobi.png",
                  ),
                ),
              ),
              _buildDivider(),
              _buildSelectableTextField(
                title: "Status Perkawinan",
                controller: _statusPerkawinanController,
                hintText: "Pilih status",
                icon: Icon(Icons.people, color: Color(0xFF826754)),
                onTap: () => _showSingleSelectGrid(
                  context: context,
                  title: "Pilih Status Perkawinan",
                  options: maritalStatusOptions,
                  selectedValue: _statusPerkawinanController.text,
                  onSelected: (selected) {
                    _statusPerkawinanController.text = selected;
                    setState(() => _validateForm());
                  },
                ),
              ),
              _buildDivider(),
              _buildSelectableTextField(
                title: "Tingkat Pendidikan",
                controller: _tingkatPendidikanController,
                hintText: "Pilih tingkat pendidikan",
                icon: Icon(Icons.school, color: Color(0xFF826754)),
                onTap: () => _showSingleSelectGrid(
                  context: context,
                  title: "Pilih Tingkat Pendidikan",
                  options: educationLevelOptions,
                  selectedValue: _tingkatPendidikanController.text,
                  onSelected: (selected) {
                    _tingkatPendidikanController.text = selected;
                    setState(() => _validateForm());
                  },
                ),
              ),
              _buildDivider(),
              _buildSelectableTextField(
                title: "Pekerjaan",
                controller: _pekerjaanController,
                hintText: "Pilih pekerjaan",
                icon: Icon(Icons.work, color: Color(0xFF826754)),
                onTap: () => _showSingleSelectGrid(
                  context: context,
                  title: "Pilih Pekerjaan",
                  options: jobOptions,
                  selectedValue: _pekerjaanController.text,
                  onSelected: (selected) {
                    _pekerjaanController.text = selected;
                    setState(() => _validateForm());
                  },
                ),
              ),
              _buildDivider(),
              _buildPasswordField(
                controller: _pinAksesController,
                label: "PIN Akses",
                hint: "6 digit angka",
                iconPath: "assets/images/pinakses.png",
                keyboardType: TextInputType.number,
                digitsOnly: true,
              ),
              _buildDivider(),
              _buildPasswordField(
                controller: _konfirmasiPinController,
                label: "Konfirmasi PIN Akses",
                hint: "Masukkan kembali PIN",
                iconPath: "assets/images/pinakses.png",
                keyboardType: TextInputType.number,
                digitsOnly: true,
              ),
              _buildDivider(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isButtonEnabled ? Color(0xFF826754) : Color(0xFFC4B8B1),
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
                      color:
                          _isButtonEnabled ? Colors.white : Color(0xFFD7CCC8),
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
    bool digitsOnly = false, // 🆕 default to false
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
                    inputFormatters: digitsOnly
                        ? [
                            FilteringTextInputFormatter.digitsOnly
                          ] // ✅ only if explicitly requested
                        : [],
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
    bool digitsOnly = true,
    TextInputType keyboardType = TextInputType.number,
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
                    inputFormatters: keyboardType == TextInputType.number
                        ? [
                            FilteringTextInputFormatter.digitsOnly
                          ] // 🚫 affects too many fields
                        : [],
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
