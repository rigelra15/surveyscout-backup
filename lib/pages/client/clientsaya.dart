// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/custom_confirmation_dialog.dart';
import 'package:surveyscout/pages/welcome.dart';
import 'package:surveyscout/services/profile/api_clientprofile.dart';

class ClientSaya extends StatefulWidget {
  @override
  _ClientSaya createState() => _ClientSaya();
}

class _ClientSaya extends State<ClientSaya> {
  ApiService? apiService;
  late ClientProfile clientProfile = ClientProfile(
    idClient: '',
    pinAkses: 0,
    namaLengkap: '',
    jenisKelamin: '',
    nomorTelepon: '',
    email: '',
    nik: '',
    namaPerusahaan: '',
    jenisUsaha: '',
    nomorRekening: '',
    profilePicture: '',
    namaBank: '',
    tanggalLahir: '',
  );

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
      _fetchClientProfile();
    } else {
      print("Token tidak ditemukan");
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

  Future<void> _fetchClientProfile() async {
    try {
      if (apiService != null) {
        ClientProfile profile = await apiService!.getClientProfile();
        setState(() {
          clientProfile = profile;
        });
      }
    } catch (e) {
      print("Error mengambil profil klien: $e");
    }
  }

  int activeButton = -1; // Tombol default yang tidak aktif
  bool isOn = false;
  bool isOn2 = false;

  Future<void> _handleGoogleSignOut(BuildContext context) async {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => CustomConfirmationDialog(
        title: 'Konfirmasi Keluar Akun',
        message: 'Apakah Anda yakin ingin keluar?',
        confirmText: 'Ya',
        cancelText: 'Batal',
        onConfirm: () {
          _signOutAndNavigate(context);
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _signOutAndNavigate(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_role');

    if (context.mounted) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), // Pastikan ukuran cukup
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF2EEE9),
          flexibleSpace: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 27.0, vertical: 10.0),
              child: SizedBox(
                // Bungkus dengan SizedBox agar tidak overflow
                height: 50, // Sesuaikan agar pas dengan gambar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/surveyscoutlogo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/layananpelanggan.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(27),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF2EEE9), // Warna latar belakang
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Menyusun konten di kiri
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFEDE7E2), // Warna kontainer utama
                ),
                width: double.infinity, // Lebar penuh
                padding: EdgeInsets.all(30), // Jarak antar kontainer utama

                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Spasi rata antar kontainer
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity, // Lebar penuh
                      //color: Colors.red, // Warna kontainer pertama
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(clientProfile.profilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      //color: Colors.green, // Warna kontainer kedua
                      child: Center(
                        child: Text(
                          clientProfile.namaLengkap,
                          style: TextStyle(
                            color: Color(0xFF705D54),
                            fontFamily: "NunitoSans",
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Jika lebar kurang dari 600, ubah menjadi Column
                            bool isNarrow = constraints.maxWidth < 300;
                            return Flex(
                              direction:
                                  isNarrow ? Axis.vertical : Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Kontainer Kiri
                                Container(
                                  decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Gambar
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/ptwidyamandala.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Teks
                                      const Text(
                                        'PT Widya Mandala',
                                        style: TextStyle(
                                          color: Color(0xFF705D54),
                                          fontFamily: "NunitoSans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Jarak antar kontainer (Horizontal atau Vertikal)
                                SizedBox(
                                  width: isNarrow ? 0 : 8, // Jarak horizontal
                                  height: isNarrow ? 8 : 0, // Jarak vertikal
                                ),
                                // Kontainer Kanan
                                Container(
                                  decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Gambar
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/surabaya.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Teks
                                      const Text(
                                        'Surabaya',
                                        style: TextStyle(
                                          color: Color(0xFF705D54),
                                          fontFamily: "NunitoSans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFA3948D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Ubah Profil',
                            style: TextStyle(
                              color: Color(0xFFEDE7E2),
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF0000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                          ),
                          onPressed: () {
                            _handleGoogleSignOut(context);
                          },
                          child: const Text(
                            'Keluar Akun',
                            style: TextStyle(
                              color: Color(0xFFEDE7E2),
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Anda dapat mengubah pengaturan akun Anda saat menggunakan akun asli."),
                        backgroundColor: Color(0xFF705D54),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity, // Lebar penuh
                    padding: EdgeInsets.all(8),
                    //color: Colors.green,
                    child: const Center(
                      child: Text(
                        'Keamanan',
                        style: TextStyle(
                          color: Color(0xFF705D54),
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Anda dapat mengubah pengaturan akun Anda saat menggunakan akun asli."),
                      backgroundColor: Color(0xFF705D54),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFFEDE7E2), // Warna kontainer utama
                  ),
                  padding: const EdgeInsets.all(8), // Padding utama kontainer
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Jarak antar elemen
                        children: [
                          // Kontainer Kiri
                          Row(
                            children: [
                              // Gambar di sebelah kiri
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage('assets/images/pinakses2.png'),
                                    fit: BoxFit.cover, // Menjaga proporsi gambar
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 8), // Jarak antara gambar dan teks
                              // Teks di sebelah kanan
                              Container(
                                width: 100, // Atur lebar kontainer
                                child: const Text(
                                  'Pin Akses',
                                  style: TextStyle(
                                    color: Color(0xFF705D54),
                                    fontSize: 14,
                                    fontFamily: "NunitoSans",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Kontainer Tengah
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Terakhir diubah 1 Mei 2023',
                                style: TextStyle(
                                  color: Color(0xFFA3948D),
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                // Memotong teks jika terlalu panjang
                              ),
                            ),
                          ),
                          // Kontainer Kanan
                          Container(
                            width: 15,
                            height: 15,
                            child: Image.asset(
                              'assets/images/panahkanan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Jarak antara Row dan Garis
                      // Garis bawah
                      Container(
                        width: double.infinity,
                        height: 1, // Tinggi garis
                        color: const Color(0xFFCAC4D0), // Warna garis
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Jarak antar elemen
                        children: [
                          // Kontainer Kiri
                          Row(
                            children: [
                              // Gambar di sebelah kiri
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/autentikasi.png'),
                                    fit: BoxFit.cover, // Menjaga proporsi gambar
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 8), // Jarak antara gambar dan teks
                              // Teks di sebelah kanan
                              Container(
                                width: 100, // Atur lebar kontainer
                                child: const Text(
                                  'Autentikasi',
                                  style: TextStyle(
                                    color: Color(0xFF705D54),
                                    fontSize: 14,
                                    fontFamily: "NunitoSans",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Kontainer Tengah
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'OTP',
                                style: TextStyle(
                                  color: Color(0xFFA3948D),
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          // Kontainer Kanan
                          Container(
                            width: 15,
                            height: 15,
                            child: Image.asset(
                              'assets/images/panahkanan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 1, // Tinggi garis
                        color: const Color(0xFFCAC4D0), // Warna garis
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Jarak antar elemen
                        children: [
                          // Kontainer Kiri
                          Row(
                            children: [
                              // Gambar di sebelah kiri
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage('assets/images/perangkat.png'),
                                    fit: BoxFit.cover, // Menjaga proporsi gambar
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 8), // Jarak antara gambar dan teks
                              // Teks di sebelah kanan
                              Container(
                                width: 100, // Atur lebar kontainer
                                child: const Text(
                                  'Perangkat',
                                  style: TextStyle(
                                    color: Color(0xFF705D54),
                                    fontSize: 14,
                                    fontFamily: "NunitoSans",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Kontainer Tengah
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Google Pixel 9XL +1 lainnya',
                                style: TextStyle(
                                  color: Color(0xFFA3948D),
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                // Memotong teks jika terlalu panjang
                              ),
                            ),
                          ),
                          // Kontainer Kanan
                          Container(
                            width: 15,
                            height: 15,
                            child: Image.asset(
                              'assets/images/panahkanan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Anda dapat mengubah pengaturan akun Anda saat menggunakan akun asli."),
                      backgroundColor: Color(0xFF705D54),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity, // Lebar penuh
                  padding: EdgeInsets.all(8),
                  //color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Pembayaran',
                      style: TextStyle(
                        color: Color(0xFF705D54),
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Anda dapat mengubah pengaturan akun Anda saat menggunakan akun asli."),
                      backgroundColor: Color(0xFF705D54),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFFEDE7E2), // Warna kontainer utama
                  ),
                  padding: const EdgeInsets.all(8), // Padding utama kontainer
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Jarak antar elemen
                        children: [
                          // Kontainer Kiri
                          Row(
                            children: [
                              // Gambar di sebelah kiri
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage('assets/images/rekening.png'),
                                    fit: BoxFit.cover, // Menjaga proporsi gambar
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 8), // Jarak antara gambar dan teks
                              // Teks di sebelah kanan
                              Container(
                                width: 100, // Atur lebar kontainer
                                child: const Text(
                                  'Rekening',
                                  style: TextStyle(
                                    color: Color(0xFF705D54),
                                    fontSize: 14,
                                    fontFamily: "NunitoSans",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Kontainer Tengah
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${clientProfile.namaBank} | ${clientProfile.nomorRekening}',
                                style: TextStyle(
                                  color: Color(0xFFA3948D),
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                // Memotong teks jika terlalu panjang
                              ),
                            ),
                          ),
                          // Kontainer Kanan
                          Container(
                            width: 15,
                            height: 15,
                            child: Image.asset(
                              'assets/images/panahkanan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Jarak antara Row dan Garis
                      // Garis bawah
                      Container(
                        width: double.infinity,
                        height: 1, // Tinggi garis
                        color: const Color(0xFFCAC4D0), // Warna garis
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Jarak antar elemen
                        children: [
                          // Kontainer Kiri
                          Row(
                            children: [
                              // Gambar di sebelah kiri
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage('assets/images/riwayat.png'),
                                    fit: BoxFit.cover, // Menjaga proporsi gambar
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 8), // Jarak antara gambar dan teks
                              // Teks di sebelah kanan
                              Container(
                                width: 100, // Atur lebar kontainer
                                child: const Text(
                                  'Riwayat',
                                  style: TextStyle(
                                    color: Color(0xFF705D54),
                                    fontSize: 14,
                                    fontFamily: "NunitoSans",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Kontainer Tengah
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Membayar Rp 500.000 23 Agustus 2024',
                                style: TextStyle(
                                  color: Color(0xFFA3948D),
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          // Kontainer Kanan
                          Container(
                            width: 15,
                            height: 15,
                            child: Image.asset(
                              'assets/images/panahkanan.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Anda dapat mengubah pengaturan akun Anda saat menggunakan akun asli."),
                      backgroundColor: Color(0xFF705D54),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity, // Lebar penuh
                  padding: EdgeInsets.all(8),
                  //color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Notifikasi',
                      style: TextStyle(
                        color: Color(0xFF705D54),
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Anda dapat mengubah pengaturan akun Anda saat menggunakan akun asli."),
                      backgroundColor: Color(0xFF705D54),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFFEDE7E2), // Warna kontainer utama
                  ),
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Jarak antar elemen
                        children: [
                          // Kontainer Kiri
                          Row(
                            children: [
                              // Gambar di sebelah kiri
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/informasiumum.png'),
                                    fit: BoxFit.cover, // Menjaga proporsi gambar
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 8), // Jarak antara gambar dan teks
                              // Teks di sebelah kanan
                              Container(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Atur jarak antara teks atas dan bawah
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start, // Rata kiri
                                  children: [
                                    Text(
                                      'Informasi umum, tips, dan pengenalan produk', // Teks atas
                                      style: TextStyle(
                                        color: Color(0xFF705D54),
                                        fontSize: 14,
                                        fontFamily: "NunitoSans",
                                        fontWeight: FontWeight.w700,
                                      ),
                                      softWrap:
                                      true, // Aktifkan pembungkusan teks
                                      overflow: TextOverflow
                                          .visible, // Tampilkan teks penuh jika terlalu panjang
                                      maxLines:
                                      null, // Izinkan teks menggunakan baris sebanyak yang diperlukan
                                    ),
                                    Text(
                                      'Kiat menggunakan SurveyScout', // Teks bawah
                                      style: TextStyle(
                                        color: Color(0xFF705D54),
                                        fontSize: 14,
                                        fontFamily: "NunitoSans",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Kontainer Tengah

                          // Kontainer Kanan
                          Container(
                            padding: EdgeInsets.all(8),
                            width: 40, // Ukuran tombol
                            height: 20,
                            child: Switch(
                              value: isOn2,
                              onChanged: (bool value) {
                                setState(() {
                                  isOn2 = value; // Ubah status tombol
                                });
                              },
                              activeColor: Color(
                                  0xFF826754), // Warna tombol saat aktifColors.white,
                              inactiveThumbColor: Color(
                                  0xFFD7CCC8), // Warna tombol saat tidak aktif
                              inactiveTrackColor: Colors
                                  .white, // Warna track saat tidak aktifColor(0xFF826754),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8), // Jarak antara Row dan Garis
                      // Garis bawah
                      Container(
                        width: double.infinity,
                        height: 1, // Tinggi garis
                        color: const Color(0xFFCAC4D0), // Warna garis
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Jarak antar elemen
                        children: [
                          // Kontainer Kiri
                          Row(
                            children: [
                              // Gambar di sebelah kiri
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/newsletter.png'),
                                    fit: BoxFit.cover, // Menjaga proporsi gambar
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 8), // Jarak antara gambar dan teks
                              // Teks di sebelah kanan
                              Container(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Atur jarak antara teks atas dan bawah
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start, // Rata kiri
                                  children: [
                                    Text(
                                      'Newsletter dan promosi', // Teks atas
                                      style: TextStyle(
                                        color: Color(0xFF705D54),
                                        fontSize: 14,
                                        fontFamily: "NunitoSans",
                                        fontWeight: FontWeight.w700,
                                      ),
                                      softWrap:
                                      true, // Aktifkan pembungkusan teks
                                      overflow: TextOverflow
                                          .visible, // Tampilkan teks penuh jika terlalu panjang
                                      maxLines:
                                      null, // Izinkan teks menggunakan baris sebanyak yang diperlukan
                                    ),
                                    Text(
                                      'Jadilah yang pertama mendapatkan penawaran terbaik', // Teks bawah
                                      style: TextStyle(
                                        color: Color(0xFF705D54),
                                        fontSize: 14,
                                        fontFamily: "NunitoSans",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Kontainer Tengah

                          // Kontainer Kanan
                          Container(
                            padding: EdgeInsets.all(8),
                            width: 40, // Ukuran tombol
                            height: 20,
                            child: Switch(
                              value: isOn,
                              onChanged: (bool value) {
                                setState(() {
                                  isOn = value; // Ubah status tombol
                                });
                              },
                              activeColor: Color(
                                  0xFF826754), // Warna tombol saat aktifColors.white,
                              inactiveThumbColor: Color(
                                  0xFFD7CCC8), // Warna tombol saat tidak aktif
                              inactiveTrackColor: Colors
                                  .white, // Warna track saat tidak aktifColor(0xFF826754),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),







              // Tambahkan lebih banyak kontainer jika diperlukan
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
