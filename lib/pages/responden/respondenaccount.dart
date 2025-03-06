import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyscout/components/custom_signout.dart';
import 'package:surveyscout/pages/welcome.dart';
import 'package:surveyscout/services/profile/api_respondenprofile.dart';
import 'respondenmyprojects.dart';
import 'respondenprojects.dart';
import 'respondenchat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RespondenAccount extends StatefulWidget {
  @override
  _RespondenAccount createState() => _RespondenAccount();
}

class _RespondenAccount extends State<RespondenAccount> {
  ApiService? apiService;
  late RespondenProfile respondenProfile = RespondenProfile(
    idResponden: '',
    namaLengkap: '',
    jenisKelamin: '',
    nomorTelepon: '',
    email: '',
    nik: '',
    statusPerkawinan: '',
    domisili: '',
    tingkatPendidikan: '',
    pekerjaan: '',
    nomorRekening: '',
    pinAkses: 0,
    tanggalLahir: '',
    namaBank: '',
    hobi: [],
    profilePicture: '',
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
          "https://d36b-118-99-84-24.ngrok-free.app/api/v1",
          token,
        );
      });
      _fetchRespondenProfile();
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

  Future<void> _fetchRespondenProfile() async {
    try {
      if (apiService != null) {
        RespondenProfile profile = await apiService!.getRespondenProfile();
        setState(() {
          respondenProfile = profile;
        });
      }
    } catch (e) {
      print("Error mengambil profil klien: $e");
    }
  }

  int activeButton = -1;
  bool isOn = false;
  bool isOn2 = false;

  Future<void> _handleGoogleSignOut(BuildContext context) async {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => CustomSignOut(
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
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF2EEE9),
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(27.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  //color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        //color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                'assets/images/surveyscoutlogo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/layananpelanggan.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(27),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF2EEE9),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFEDE7E2),
                ),
                width: double.infinity,
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      //color: Colors.red,
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  NetworkImage(respondenProfile.profilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      //color: Colors.green,
                      child: Center(
                        child: Text(
                          respondenProfile.namaLengkap,
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
                            bool isNarrow = constraints.maxWidth < 300;
                            return Flex(
                              direction:
                                  isNarrow ? Axis.vertical : Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Responden',
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
                                SizedBox(
                                  width: isNarrow ? 0 : 8,
                                  height: isNarrow ? 8 : 0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
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
                                            Text(
                                              '${respondenProfile.domisili}',
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
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
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
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFEDE7E2),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/pinakses2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 100,
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
                            ),
                          ),
                        ),
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
                      height: 1,
                      color: const Color(0xFFCAC4D0),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/autentikasi.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 100,
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
                      height: 1,
                      color: const Color(0xFFCAC4D0),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/perangkat.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 100,
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
                            ),
                          ),
                        ),
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
              Container(
                width: double.infinity,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFEDE7E2),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/rekening.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 100,
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '${respondenProfile.namaBank} | ${respondenProfile.nomorRekening}',
                              style: TextStyle(
                                color: Color(0xFFA3948D),
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
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
                      height: 1,
                      color: const Color(0xFFCAC4D0),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/riwayat.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 100,
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
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Rp 500.000 masuk bulan lalu',
                              style: TextStyle(
                                color: Color(0xFFA3948D),
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
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
              Container(
                width: double.infinity,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFEDE7E2),
                ),
                padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/informasiumum.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Informasi umum, tips, dan pengenalan produk',
                                    style: TextStyle(
                                      color: Color(0xFF705D54),
                                      fontSize: 14,
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    maxLines: null,
                                  ),
                                  Text(
                                    'Kiat menggunakan SurveyScout',
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
                        Container(
                          padding: EdgeInsets.all(8),
                          width: 40,
                          height: 20,
                          child: Switch(
                            value: isOn2,
                            onChanged: (bool value) {
                              setState(() {
                                isOn2 = value;
                              });
                            },
                            activeColor: Color(0xFF826754),
                            inactiveThumbColor: Color(0xFFD7CCC8),
                            inactiveTrackColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0xFFCAC4D0),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/newsletter.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Newsletter dan promosi',
                                    style: TextStyle(
                                      color: Color(0xFF705D54),
                                      fontSize: 14,
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    maxLines: null,
                                  ),
                                  Text(
                                    'Jadilah yang pertama mendapatkan penawaran terbaik',
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
                        Container(
                          padding: EdgeInsets.all(8),
                          width: 40,
                          height: 20,
                          child: Switch(
                            value: isOn,
                            onChanged: (bool value) {
                              setState(() {
                                isOn = value;
                              });
                            },
                            activeColor: Color(0xFF826754),
                            inactiveThumbColor: Color(0xFFD7CCC8),
                            inactiveTrackColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RespondenProjects()),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/tersedia2.png',
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
                onTap: () {},
                child: Container(
                  width: 80,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/saya2.png',
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
                          color: Color(0xFF705D54),
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
