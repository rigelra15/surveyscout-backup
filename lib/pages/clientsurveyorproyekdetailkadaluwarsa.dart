import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:surveyscout/pages/client/clientsignup.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';
import 'package:surveyscout/services/projects/api_projectdetail.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Clientsurveyorproyekdetailkadaluwarsa extends StatefulWidget {
  final String id;
  final String type;

  Clientsurveyorproyekdetailkadaluwarsa(
      {Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _Clientsurveyorproyekdetailkadaluwarsa createState() =>
      _Clientsurveyorproyekdetailkadaluwarsa();
}

class _Clientsurveyorproyekdetailkadaluwarsa
    extends State<Clientsurveyorproyekdetailkadaluwarsa> {
  ApiService? apiService;
  late ProjectDetail projectDetail = ProjectDetail();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApiService();
  }

  Future<void> _initializeApiService() async {
    setState(() {
      apiService = ApiService("https://surveyscoutbe.onrender.com/api/v1");
    });

    _fetchClientSurveyorDetail(widget.id);
  }

  Future<void> _fetchClientSurveyorDetail(String id) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (apiService != null) {
        ProjectDetail profile = await apiService!.getASurveyTask(id);
        setState(() {
          projectDetail = profile;
        });
      }
    } catch (e) {
      print("Error mengambil profil klien: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatCurrency(String value) {
    try {
      double amount = double.parse(value);
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
      return formatCurrency.format(amount);
    } catch (e) {
      return value;
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF2EEE9), // Warna latar belakang
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(60), // Tinggi total AppBar (50 + 10 padding)
          child: Container(
            padding: EdgeInsets.only(top: 20), // Padding atas 10
            color: (widget.type == "survey")
                ? Color(0xFFD7CCC8)
                : Color(0xFF826754), // Warna background AppBar
            child: AppBar(
              backgroundColor: Colors
                  .transparent, // Transparan agar tidak menimpa warna Container
              toolbarHeight: 50,
              centerTitle: true,
              elevation: 0, // Hilangkan shadow agar lebih rapi
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: (widget.type == "survey")
                      ? Color(0xFF705D54)
                      : Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                (widget.type == "survey")
                    ? 'Detail Proyek Survey'
                    : 'Detail Proyek Respond',
                style: TextStyle(
                  fontFamily: 'NutinoSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: (widget.type == "survey")
                      ? Color(0xFF705D54)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(27), // Padding di semua sisi
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Sejajar ke kiri
                  mainAxisAlignment: MainAxisAlignment.start, // Tetap di atas
                  children: [
                    Text(
                      projectDetail.namaProyek,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "SourceSans3",
                        color: Color(0xFF705D54),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10), // Spasi antar elemen
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8), // Padding dalam container
                      decoration: BoxDecoration(
                        color:
                            Color(0xFF9E9E9E), // Warna latar belakang container
                        borderRadius: BorderRadius.circular(
                            16), // Membuat sudut melengkung
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Sesuaikan ukuran Container dengan konten
                        children: [
                          Iconify(Mdi.clock_alert,
                              color: Colors.white, size: 16),
                          SizedBox(width: 6), // Jarak antara ikon dan teks
                          Text(
                            'Kadaluwarsa',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NunitoSans",
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      projectDetail.createdAt,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "NunitoSans",
                        color: Color(0xFFA3948D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8), // Padding dalam container
                      decoration: BoxDecoration(
                        color:
                            Color(0xFFA3948D), // Warna latar belakang container
                        borderRadius: BorderRadius.circular(
                            8), // Membuat sudut melengkung
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Sesuaikan ukuran Container dengan konten
                        children: [
                          Icon(
                            Icons
                                .punch_clock_rounded, // Ganti dengan ikon sesuai kebutuhan
                            color: Colors.white,
                            size: 14, // Ukuran ikon sesuai teks
                          ),
                          SizedBox(width: 6), // Jarak antara ikon dan teks
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tenggat Waktu',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "NunitoSans",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    projectDetail.tenggatPengerjaan,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NunitoSans",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 4.55 / 11,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFEDE7E2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Memastikan Row mengikuti lebar Container
                              children: [
                                Icon(Icons.location_on,
                                    color: Color(0xFFA3948D),
                                    size: 20), // Ikon di kiri
                                SizedBox(
                                    width: 8), // Jarak antara ikon dan teks
                                Flexible(
                                  // Ganti Expanded dengan Flexible untuk menghindari unbounded width issue
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Lokasi Survei',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFFA3948D),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        capitalizeFirstLetter(
                                            projectDetail.lokasi),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFFA3948D),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 3),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 4.55 / 11,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFEDE7E2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Memastikan Row mengikuti lebar Container
                              children: [
                                Icon(Icons.money,
                                    color: Color(0xFFA3948D),
                                    size: 20), // Ikon di kiri
                                SizedBox(
                                    width: 8), // Jarak antara ikon dan teks
                                Flexible(
                                  // Ganti Expanded dengan Flexible untuk menghindari unbounded width issue
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Komisi',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFFA3948D),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        formatCurrency(
                                            projectDetail.kompensasi),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFFA3948D),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity, // Lebar penuh
                      height: 1, // Tinggi 1
                      color: Color(0xFFB0B0B0),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFEDE7E2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .max, // Memastikan Row mengikuti lebar Container
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 8), // Jarak antara ikon dan teks
                          Flexible(
                            // Ganti Expanded dengan Flexible untuk menghindari unbounded width issue
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Tidak Ada Pelamar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "NunitoSans",
                                    color: Color(0xFF705D54),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  children: [
                                    Text(
                                      'Mohon maaf tidak ada pelamar ditemukan setelah 7 hari',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "NunitoSans",
                                        color: Color(0xFFA3948D),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Show the bottom sheet when the button is pressed
                                        _showPelamar(context);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF826754),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Pusatkan teks dan ikon
                                          children: [
                                            Icon(Icons.refresh,
                                                size: 14,
                                                color: Color(
                                                    0xFFEDE7E2)), // Ikon di kiri
                                            SizedBox(
                                                width:
                                                    4), // Jarak antara ikon dan teks
                                            Text(
                                              'Unggah Kembali',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "NunitoSans",
                                                color: Color(0xFFEDE7E2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SourceSans3",
                        color: Color(0xFF705D54),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      projectDetail.deskripsiProyek,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "NunitoSans",
                        color: Color(0xFFA3948D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kualifikasi',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SourceSans3",
                        color: Color(0xFF705D54),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      projectDetail.keahlian.join(', '),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "NunitoSans",
                        color: Color(0xFFA3948D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Luaran',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SourceSans3",
                        color: Color(0xFF705D54),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      projectDetail.tipeHasil.join(', '),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "NunitoSans",
                        color: Color(0xFFA3948D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'ID #${widget.id}',
                            textAlign: TextAlign.center, // Rata tengah
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "NunitoSans",
                              color: Color(0xFFB0B0B0),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.white.withOpacity(0.4),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: Color(0xFF826754),
                        size: 60,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Memuat ${widget.type}...",
                        style: TextStyle(
                          color: Color(0xFF826754),
                          fontSize: 14,
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showPelamar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isScrollControlled:
          true, // Allow bottom sheet to adjust based on its content
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30)), // Apply rounded corners to the content
          child: Container(
            width: MediaQuery.of(context)
                .size
                .width, // Make the width fill the screen
            padding: EdgeInsets.all(24),
            color: Color(0xFFF1E9E5),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Makes the bottom sheet take only necessary height
              children: [
                Divider(
                  thickness: 3, // Adjust thickness to make the line thicker
                  indent:
                      150, // Make the line shorter by adding space from the start
                  endIndent:
                      150, // Make the line shorter by adding space from the end
                  color: Color(
                      0xFFB0B0B0), // Optional: set a color for the divider
                ),
                SizedBox(height: 10), // Spasi antara garis dan tulisan
                Text(
                  "Daftar Sebagai",
                  style: TextStyle(
                    fontFamily: 'SourceSans3',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF705D54),
                  ),
                ),
                SizedBox(height: 20),
                // Kontainer pertama
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman clientsignup2.dart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClientSignUp()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFD7CCC8),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/klien.png',
                        width: 50,
                        height: 50,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Klien",
                            style: TextStyle(
                              fontFamily:
                                  'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w700, // Weight 700
                              color: Color(0xFF705D54), // Warna #705D54
                            ),
                          ),
                          SizedBox(height: 2), // Spasi antara dua teks
                          Text(
                            "Rekrut surveyor atau responden untuk membantu observasi Anda berjalan lancar dan efisien.",
                            style: TextStyle(
                              fontFamily:
                                  'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w400, // Weight 400
                              color: Color(0xFF3A2B24), // Warna #3A2B24
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Kontainer kedua
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman SurveyorProjects
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SurveyorProjects()),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.all(16), // Padding untuk kontainer
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFD7CCC8), // Warna latar belakang
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/surveyor.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                            width: 12), // Spasi antara gambar dan teks
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Surveyor",
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700, // Font tebal
                                  color: Color(0xFF705D54),
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      4), // Spasi antara judul dan deskripsi
                              const Text(
                                "Hasilkan uang dengan mencari data dengan wawancara, observasi, dan/atau lainnya hingga merekapnya.",
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize:
                                      14, // Ukuran font deskripsi lebih kecil
                                  fontWeight: FontWeight.w400, // Font normal
                                  color: Color(0xFF3A2B24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman SurveyorProjects
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RespondenProjects()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFD7CCC8),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/responden.png',
                        width: 50,
                        height: 50,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Responden",
                            style: TextStyle(
                              fontFamily:
                                  'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w700, // Weight 400
                              color: Color(0xFF705D54), // Warna #705D54
                            ),
                          ),
                          SizedBox(height: 2), // Spasi antara dua teks
                          Text(
                            "Hasilkan uang dengan menjadi narasumber. Anda akan mengisi survei, diwawancarai, dan lainnya.",
                            style: TextStyle(
                              fontFamily:
                                  'NunitoSans', // Gunakan font yang sudah di-load
                              fontSize: 16,
                              fontWeight: FontWeight.w400, // Weight 400
                              color: Color(0xFF3A2B24), // Warna #705D54
                            ),
                          ), // Teks kedua
                        ],
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
}
