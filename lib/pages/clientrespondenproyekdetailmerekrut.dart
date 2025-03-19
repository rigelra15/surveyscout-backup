import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';
import 'package:surveyscout/pages/client/clientsignup.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';
import 'package:surveyscout/services/projects/api_projectdetail.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Clientrespondenproyekdetailmerekrut extends StatefulWidget {
  final String id;
  final String type;

  const Clientrespondenproyekdetailmerekrut(
      {Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _ClientrespondenproyekdetailmerekrutState createState() =>
      _ClientrespondenproyekdetailmerekrutState();
}

class _ClientrespondenproyekdetailmerekrutState
    extends State<Clientrespondenproyekdetailmerekrut> {
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
      apiService =
          ApiService("https://03d4-120-188-76-121.ngrok-free.app/api/v1");
    });

    _fetchClientRespondenDetail(widget.id);
  }

  Future<void> _fetchClientRespondenDetail(String id) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (apiService != null) {
        ProjectDetail profile = await apiService!.getARespondTask(id);
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
            color: Color(0xFF826754), // Warna background AppBar
            child: AppBar(
              backgroundColor: Colors
                  .transparent, // Transparan agar tidak menimpa warna Container
              toolbarHeight: 50,
              centerTitle: true,
              elevation: 0, // Hilangkan shadow agar lebih rapi
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFFF1E9E5)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Detail Proyek Survey',
                style: TextStyle(
                  fontFamily: 'NutinoSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFFF1E9E5),
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
                            Color(0xFF826754), // Warna latar belakang container
                        borderRadius: BorderRadius.circular(
                            16), // Membuat sudut melengkung
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Sesuaikan ukuran Container dengan konten
                        children: [
                          Icon(
                            Icons.search, // Ganti dengan ikon sesuai kebutuhan
                            color: Colors.white,
                            size: 14, // Ukuran ikon sesuai teks
                          ),
                          SizedBox(width: 6), // Jarak antara ikon dan teks
                          Text(
                            'Merekrut',
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
                                        'Lokasi',
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
                          Wrap(
                            children: [
                              Container(
                                width: 57,
                                height: 100,
                                decoration: BoxDecoration(
                                  //color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      left: 30,
                                      bottom: 33,
                                      child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor:
                                            Colors.red, // Warna bingkai
                                        backgroundImage: AssetImage(
                                            'assets/images/foto1.png'), // Ganti dengan path gambar Anda
                                      ),
                                    ),
                                    Positioned(
                                      right: 30,
                                      bottom: 33,
                                      child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor:
                                            Colors.blue, // Warna bingkai
                                        backgroundImage: AssetImage(
                                            'assets/images/foto2.png'), // Ganti dengan path gambar Anda
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          Colors.green, // Warna bingkai
                                      backgroundImage: AssetImage(
                                          'assets/images/foto3.png'), // Ganti dengan path gambar Anda
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 8), // Jarak antara ikon dan teks
                          Flexible(
                            // Ganti Expanded dengan Flexible untuk menghindari unbounded width issue
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '20 narasumber yang cocok bersedia menjadi responden',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "NunitoSans",
                                    color: Color(0xFF705D54),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Wrap(
                                  children: [
                                    Text(
                                      'Tinjau latar belakang mereka atau konfirmasi dengan chat',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "NunitoSans",
                                        color: Color(0xFFA3948D),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
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
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF826754),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Pusatkan teks dan ikon
                                          children: [
                                            Icon(Icons.local_post_office_sharp,
                                                size: 14,
                                                color: Color(
                                                    0xFFEDE7E2)), // Ikon di kiri
                                            SizedBox(
                                                width:
                                                    4), // Jarak antara ikon dan teks
                                            Text(
                                              'Tinjau',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
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
                      'Metode',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SourceSans3",
                        color: Color(0xFF705D54),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      projectDetail.metodeSurvey,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "NunitoSans",
                        color: Color(0xFFA3948D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SourceSans3",
                            color: Color(0xFF705D54),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Ditampilkan hanya untuk responden terpilih',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "NunitoSans",
                            color: Color(0xFFB0B0B0),
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bergabunglah ke contoso.zoom.id/DdXs23 pada waktu yang dijanjikan di chat, untuk harinya 25 feb 2025',
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
