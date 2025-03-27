import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surveyscout/pages/client/clientsignup.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';
import 'package:surveyscout/services/projects/api_projectdetail.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PDFViewerPage extends StatelessWidget {
  final String path;

  const PDFViewerPage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penampil PDF'),
        backgroundColor: const Color(0xFFD7CCC8),
        iconTheme: const IconThemeData(color: Color(0xFF705D54)),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            tooltip: 'Buka dengan Aplikasi Lain',
            onPressed: () {
              OpenFile.open(path);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Bagikan File',
            onPressed: () {
              Share.shareXFiles([XFile(path)], text: 'Lihat file ini');
            },
          ),
        ],
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}

class PopUpLuaran extends StatelessWidget {
  const PopUpLuaran({Key? key}) : super(key: key);

  Widget _buildItem(BuildContext context, String title, String subtitle,
      Widget icon, String filePath) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
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
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFA3948D),
                      fontSize: 12,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Iconify(Bi.eye_fill, color: Color(0xFF826754)),
              onPressed: () async {
                final byteData = await rootBundle.load(filePath);
                final buffer = byteData.buffer;

                final tempDir = await getTemporaryDirectory();
                final tempPath = '${tempDir.path}/${filePath.split('/').last}';
                final file = await File(tempPath).writeAsBytes(
                  buffer.asUint8List(
                      byteData.offsetInBytes, byteData.lengthInBytes),
                );

                if (filePath.endsWith('.pdf')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewerPage(path: file.path),
                    ),
                  );
                } else {
                  await OpenFile.open(file.path);
                }
              },
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: Iconify(Ri.share_fill, color: Color(0xFF826754)),
              onPressed: () async {
                final byteData = await rootBundle.load(filePath);
                final buffer = byteData.buffer;

                final tempDir = await getTemporaryDirectory();
                final tempPath = '${tempDir.path}/${filePath.split('/').last}';
                final file = await File(tempPath).writeAsBytes(
                  buffer.asUint8List(
                      byteData.offsetInBytes, byteData.lengthInBytes),
                );

                Share.shareXFiles([XFile(file.path)], text: 'Lihat file ini');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF0E8E4),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Color(0xFFB0B0B0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Luaran',
                style: TextStyle(
                  color: Color(0xFF705D54),
                  fontSize: 24,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Color(0xFFB8ADA5),
                radius: 14,
                child: Text(
                  "2",
                  style: TextStyle(
                    color: Color(0xFF826754),
                    fontSize: 16,
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildItem(
              context,
              'Transkrip Interview',
              'Diunggah 20 Februari, 8MB',
              Iconify(Ph.file_pdf, color: Color(0xFF826754)),
              'assets/pdfs/transkrip_wawancara.pdf'),
          _buildItem(
              context,
              'Data Responden',
              'Diunggah 18 Februari, 5MB',
              Iconify(Mdi.file_excel, color: Color(0xFF826754)),
              'assets/xlsx/data_responden.xlsx'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class Clientsurveyorproyekdetailselesai extends StatefulWidget {
  final String id;
  final String type;

  const Clientsurveyorproyekdetailselesai(
      {Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _Clientsurveyorproyekdetailselesai createState() =>
      _Clientsurveyorproyekdetailselesai();
}

class _Clientsurveyorproyekdetailselesai
    extends State<Clientsurveyorproyekdetailselesai> {
  ApiService? apiService;
  late ProjectDetail projectDetail = ProjectDetail();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApiService();
  }

  Map<String, Map<String, dynamic>> _getStatusIndicator(String status) {
    Map<String, Map<String, dynamic>> statusMap = {
      'selesai': {
        'color': Color(0xFF4CAF50),
        'icon': MaterialSymbols.check_small,
        'text': 'Selesai',
      },
      'ditinjau': {
        'color': Color(0xFFFFC107),
        'icon': Ph.circle_dashed,
        'text': 'Butuh Tinjau',
      },
      'draft': {
        'color': Color(0xFF9E9E9E),
        'icon': Ic.round_insert_drive_file,
        'text': 'Draft',
      },
      'peringatan': {
        'color': Color(0xFFF44336),
        'icon': Ph.warning_circle_fill,
        'text': 'Peringatan',
      },
      'kadaluwarsa': {
        'color': Color(0xFF9E9E9E),
        'icon': Mdi.clock_alert,
        'text': 'Kadaluwarsa',
      },
      'pembayaran': {
        'color': Color(0xFF2196F3),
        'icon': MaterialSymbols.payments_rounded,
        'text': 'Pembayaran',
      },
      'dikerjakan': {
        'color': Color(0xFFFF9800),
        'icon': MaterialSymbols.timelapse,
        'text': 'Dikerjakan',
      },
      'merekrut': {
        'color': Color(0xFF826754),
        'icon': MaterialSymbols.search_rounded,
        'text': 'Merekrut',
      }
    };

    return statusMap.containsKey(status) ? {status: statusMap[status]!} : {};
  }

  void _showLuaran(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => PopUpLuaran(),
    );
  }

  Future<void> _initializeApiService() async {
    setState(() {
      apiService = ApiService("https://surveyscoutbe.onrender.com/api/v1");
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
        backgroundColor: Color(0xFFF2EEE9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            color: (widget.type == "survey")
                ? Color(0xFFD7CCC8)
                : Color(0xFF826754),
            child: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 50,
              centerTitle: true,
              elevation: 0,
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
        body: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.fourRotatingDots(
                      color: Color(0xFF705D54),
                      size: 50,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Memuat proyek #${widget.id}...",
                      style: TextStyle(
                        color: Color(0xFF705D54),
                        fontFamily: 'NunitoSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                color: Color(0xFF705D54),
                onRefresh: () => _fetchClientRespondenDetail(widget.id),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(27),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  _getStatusIndicator(projectDetail.statusTask)
                                      .values
                                      .first['color'],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Iconify(
                                  _getStatusIndicator(projectDetail.statusTask)
                                      .values
                                      .first['icon'],
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  _getStatusIndicator(projectDetail.statusTask)
                                      .values
                                      .first['text'],
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
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFA3948D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.punch_clock_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  width: MediaQuery.of(context).size.width *
                                      4.55 /
                                      11,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDE7E2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Color(0xFFA3948D), size: 20),
                                      SizedBox(width: 8),
                                      Flexible(
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
                                  width: MediaQuery.of(context).size.width *
                                      4.55 /
                                      11,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDE7E2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(Icons.money,
                                          color: Color(0xFFA3948D), size: 20),
                                      SizedBox(width: 8),
                                      Flexible(
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
                            width: double.infinity,
                            height: 1,
                            color: Color(0xFFB0B0B0),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFFEDE7E2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/foto1.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Richard Santoso',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "NunitoSans",
                                                color: Color(0xFF705D54),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Tenaga Surveyor',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "NunitoSans",
                                                    color: Color(0xFFA3948D),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(Icons.thumb_up,
                                                    color: Color(0xFFA3948D),
                                                    size: 10),
                                                SizedBox(width: 4),
                                                Text(
                                                  '90%',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "NunitoSans",
                                                    color: Color(0xFFA3948D),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(Icons.location_on,
                                                    color: Color(0xFFA3948D),
                                                    size: 10),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Jakarta',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "NunitoSans",
                                                    color: Color(0xFFA3948D),
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
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Richard: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFF705D54),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Untuk selanjutnya, saya coba untuk ke halte bus yang sebelah utara, Pak. Akan segera saya kabarkan ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: Color(0xFF705D54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                          if (widget.type == "survey") ...[
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
                              projectDetail.tipeHasil.join(", "),
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "NunitoSans",
                                color: Color(0xFFA3948D),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                          if (widget.type == "respond") ...[
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
                              capitalizeFirstLetter(projectDetail.metodeSurvey),
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "NunitoSans",
                                color: Color(0xFFA3948D),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                          SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ID #${widget.id}',
                                  textAlign: TextAlign.center,
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
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFF826754),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Ini hanya demo, Chat dengan surveyor akan terbuka pada akun asli."),
                            backgroundColor: Color(0xFF826754),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1E9E5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.chat, color: Color(0xFF826754)),
                            SizedBox(width: 10),
                            Text(
                              'Chat',
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFF826754),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                    child: GestureDetector(
                  onTap: () => _showLuaran(context),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFF826754),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFEDE7E2), width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.text_snippet, color: Color(0xFFEDE7E2)),
                        SizedBox(width: 10),
                        Text(
                          'Luaran',
                          style: TextStyle(
                            fontFamily: 'NutinoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFFEDE7E2),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(0xFFB3261E),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                SizedBox(width: 8),
                Container(
                  height: 60,
                  width: 30,
                  color: const Color(0xFF826754),
                  child: Builder(
                    builder: (context) => PopupMenuButton<String>(
                      icon:
                          const Icon(Icons.more_vert, color: Color(0xFFEDE7E2)),
                      color: const Color(0xFFF0E8E4),
                      onSelected: (value) {
                        if (value == 'chat_bantuan') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Ini hanya demo, fitur Chat Bantuan akan tersedia pada akun asli."),
                              backgroundColor: Color(0xFF826754),
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'chat_bantuan',
                          child: Text('Chat Bantuan'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(24),
              color: Color(0xFFF1E9E5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    thickness: 3,
                    indent: 150,
                    endIndent: 150,
                    color: Color(0xFFB0B0B0),
                  ),
                  SizedBox(height: 10),
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
                  GestureDetector(
                    onTap: () {
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
                                fontFamily: 'NunitoSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF705D54),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Rekrut surveyor atau responden untuk membantu observasi Anda berjalan lancar dan efisien.",
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF3A2B24),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SurveyorProjects()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFD7CCC8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/surveyor.png',
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Surveyor",
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF705D54),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Hasilkan uang dengan mencari data dengan wawancara, observasi, dan/atau lainnya hingga merekapnya.",
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
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
                                fontFamily: 'NunitoSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF705D54),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Hasilkan uang dengan menjadi narasumber. Anda akan mengisi survei, diwawancarai, dan lainnya.",
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF3A2B24),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
