import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter_plus/icons/mingcute.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surveyscout/components/ApplicantItem.dart';
import 'package:surveyscout/pages/client/clientsignup.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';
import 'package:surveyscout/services/projects/api_projectdetail.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class Applicant {
  final String idSurveyor;
  final String namaLengkap;
  final String? profilePicture;
  final String? cvAts;
  final String? scoutTrust;
  final String statusPenerimaan;

  Applicant({
    required this.idSurveyor,
    required this.namaLengkap,
    this.profilePicture,
    this.cvAts,
    this.scoutTrust,
    required this.statusPenerimaan,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      idSurveyor: json['id_surveyor'],
      namaLengkap: json['nama_lengkap'],
      profilePicture: json['profile_picture'],
      cvAts: json['cv_ats'],
      scoutTrust: json['scout_trust']?.toString(),
      statusPenerimaan: json['status_penerimaan'],
    );
  }
}

Map<String, dynamic> detailFiles = {};

class PDFViewerPage extends StatelessWidget {
  final String path;

  const PDFViewerPage({Key? key, required this.path}) : super(key: key);

  Future<String> _getLocalPathFromUrl(String url) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = url.split('/').last.split('?').first;
    final localPath = '${tempDir.path}/$fileName';

    final file = File(localPath);

    if (!await file.exists()) {
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);
    }

    return localPath;
  }

  @override
  Widget build(BuildContext context) {
    final isUrl = path.startsWith('http');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Penampil PDF'),
        backgroundColor: const Color(0xFFD7CCC8),
        iconTheme: const IconThemeData(color: Color(0xFF705D54)),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            tooltip: 'Buka dengan Aplikasi Lain',
            onPressed: () async {
              final filePath = isUrl ? await _getLocalPathFromUrl(path) : path;
              OpenFile.open(filePath);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Bagikan File',
            onPressed: () async {
              final filePath = isUrl ? await _getLocalPathFromUrl(path) : path;
              Share.shareXFiles([XFile(filePath)], text: 'Lihat file ini');
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: isUrl ? _getLocalPathFromUrl(path) : Future.value(path),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat file: ${snapshot.error}'));
          } else {
            return PDFView(filePath: snapshot.data!);
          }
        },
      ),
    );
  }
}

class PopUpLuaran extends StatelessWidget {
  final String id;
  final String status;
  final VoidCallback? onSelesai;
  const PopUpLuaran(
      {Key? key, required this.id, required this.status, this.onSelesai})
      : super(key: key);

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return "$bytes B";
    } else if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(2)} KB";
    } else if (bytes < 1024 * 1024 * 1024) {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
    } else {
      return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB";
    }
  }

  String _convertDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy', 'id-ID').format(dateTime);
  }

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
                try {
                  Fluttertoast.showToast(
                    msg: "Sedang membuka file...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF826754),
                    fontSize: 16.0,
                    fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                  );

                  if (title.endsWith('.pdf')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFViewerPage(path: filePath),
                      ),
                    );
                  } else {
                    final response = await http.get(Uri.parse(filePath));
                    final tempDir = await getTemporaryDirectory();
                    final fileName = filePath.split('/').last.split('?').first;
                    final tempPath = '${tempDir.path}/$fileName';
                    final file = File(tempPath);
                    await file.writeAsBytes(response.bodyBytes);

                    await OpenFile.open(file.path);
                  }
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: "Gagal membuka file. Coba lagi ya!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF826754),
                    fontSize: 16.0,
                    fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                  );
                }
              },
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: Iconify(Ri.share_fill, color: Color(0xFF826754)),
              onPressed: () async {
                try {
                  Fluttertoast.showToast(
                    msg: "Menyiapkan file untuk dibagikan...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF826754),
                    fontSize: 16.0,
                    fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                  );

                  late File file;

                  if (filePath.startsWith('http')) {
                    final response = await http.get(Uri.parse(filePath));
                    final tempDir = await getTemporaryDirectory();
                    final fileName = filePath.split('/').last.split('?').first;
                    final tempPath = '${tempDir.path}/$fileName';
                    file = File(tempPath);
                    await file.writeAsBytes(response.bodyBytes);
                  } else {
                    file = File(filePath);
                  }

                  Share.shareXFiles([XFile(file.path)], text: 'Lihat file ini');
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: "Gagal membagikan file.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF826754),
                    fontSize: 16.0,
                    fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
              children: [
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
                    detailFiles.length.toString(),
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
            detailFiles.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(Icons.insert_drive_file,
                            size: 64, color: Color(0xFFA3948D)),
                        const SizedBox(height: 12),
                        Text(
                          'Belum ada file yang diunggah',
                          style: TextStyle(
                            color: Color(0xFF826754),
                            fontSize: 16,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: detailFiles.length,
                    itemBuilder: (context, index) {
                      final file = detailFiles.values.toList()[index];
                      Widget icon;

                      switch (file['fileName'].split('.').last) {
                        case 'pdf':
                          icon = Iconify(Ph.file_pdf, color: Color(0xFF826754));
                          break;
                        case 'xlsx':
                          icon =
                              Iconify(Mdi.file_excel, color: Color(0xFF826754));
                          break;
                        case 'mp4':
                          icon =
                              Iconify(Mdi.file_video, color: Color(0xFF826754));
                          break;
                        case 'docx':
                          icon =
                              Iconify(Mdi.file_word, color: Color(0xFF826754));
                          break;
                        case 'pptx':
                          icon = Iconify(Mdi.file_powerpoint,
                              color: Color(0xFF826754));
                          break;
                        case 'zip':
                          icon = Iconify(Mdi.zip_box, color: Color(0xFF826754));
                          break;
                        case 'jpg':
                        case 'jpeg':
                        case 'png':
                          icon =
                              Iconify(Mdi.file_image, color: Color(0xFF826754));
                          break;
                        case 'mp3':
                          icon = Iconify(Mdi.audio, color: Color(0xFF826754));
                          break;
                        default:
                          icon = Iconify(Ph.file, color: Color(0xFF826754));
                      }

                      return _buildItem(
                        context,
                        file['fileName'],
                        'Diunggah ${_convertDate(file['uploadedAt'])}, ${_formatFileSize(file['size'])}',
                        icon,
                        file['url'],
                      );
                    },
                  ),
            const SizedBox(height: 24),
            if (status == "ditinjau")
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF826754),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            final response = await http.post(
                              Uri.parse(
                                  "https://surveyscoutbe.onrender.com/api/v1/surveys/$id/acceptSurveyorAnswer"),
                              headers: {
                                "Content-Type": "application/json",
                              },
                            );

                            if (response.statusCode == 200) {
                              Fluttertoast.showToast(
                                msg: "Berhasil menandai selesai!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Color(0xFF826754),
                                fontSize: 16.0,
                                fontAsset:
                                    'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                              );
                              Navigator.pop(context);
                              onSelesai?.call();
                            } else {
                              Fluttertoast.showToast(
                                msg: "Gagal menandai selesai!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Color(0xFF826754),
                                fontSize: 16.0,
                                fontAsset:
                                    'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                              );
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: "Gagal menandai selesai! ${e}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Color(0xFF826754),
                              fontSize: 16.0,
                              fontAsset:
                                  'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                            );
                          }
                        },
                        child: Container(
                          height: 600,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1E9E5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Iconify(Mdi.done, color: Color(0xFF826754)),
                              SizedBox(width: 10),
                              Text(
                                "Tandai Selesai",
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xFF826754),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            final response = await http.post(
                              Uri.parse(
                                  "https://surveyscoutbe.onrender.com/api/v1/surveys/$id/revisiSurveyorAnswer"),
                              headers: {
                                "Content-Type": "application/json",
                              },
                            );

                            if (response.statusCode == 200) {
                              Fluttertoast.showToast(
                                msg: "Berhasil mengajukan revisi!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Color(0xFF826754),
                                fontSize: 16.0,
                                fontAsset:
                                    'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                              );
                              Navigator.pop(context);
                              onSelesai?.call();
                            } else {
                              Fluttertoast.showToast(
                                msg: "Gagal mengajukan revisi!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Color(0xFF826754),
                                fontSize: 16.0,
                                fontAsset:
                                    'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                              );
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: "Gagal mengajukan revisi! ${e}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Color(0xFF826754),
                              fontSize: 16.0,
                              fontAsset:
                                  'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                            );
                          }
                        },
                        child: Container(
                          height: 600,
                          decoration: BoxDecoration(
                            color: Color(0xFF826754),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xFFEDE7E2), width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Iconify(Bx.revision, color: Color(0xFFEDE7E2)),
                              SizedBox(width: 10),
                              Text('Ajukan Revisi',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFFEDE7E2),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Clientsurveyorproyekdetail extends StatefulWidget {
  final String id;
  final String type;

  const Clientsurveyorproyekdetail(
      {Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _Clientsurveyorproyekdetail createState() => _Clientsurveyorproyekdetail();
}

class _Clientsurveyorproyekdetail extends State<Clientsurveyorproyekdetail> {
  ApiService? apiService;
  late ProjectDetail projectDetail = ProjectDetail();
  bool isLoading = true;
  List<Applicant> applicantList = [];

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
        'color': Color(0xFF2196F3),
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
        'text': 'Menunggu Bayar',
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

  void _showLuaran(
    BuildContext context,
    String idSurvey,
    String statusSurvey,
    VoidCallback onSelesaiLuaran,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => PopUpLuaran(
        id: idSurvey,
        status: statusSurvey,
        onSelesai: onSelesaiLuaran, // ⬅️ lempar ke PopUpLuaran
      ),
    );
  }

  Future<void> _initializeApiService() async {
    setState(() {
      apiService = ApiService("https://surveyscoutbe.onrender.com/api/v1");
    });

    await _fetchClientRespondenDetail(widget.id);
    await _fetchApplicantList(widget.id);
  }

  Future<void> _fetchClientRespondenDetail(String id) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (apiService != null) {
        ProjectDetail survey = await apiService!.getARespondTask(id);
        setState(() {
          projectDetail = survey;
        });
      }
    } catch (e) {
      print("Error mengambil survei klien: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    await fetchFiles(id);
  }

  Future<void> _fetchApplicantList(String idSurvey) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            "https://surveyscoutbe.onrender.com/api/v1/surveyorapplies/$idSurvey"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final List<dynamic> candidates = decoded['data']['candidateInfo'];
        applicantList = candidates.map((e) => Applicant.fromJson(e)).toList();
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error mengambil daftar pelamar: $e");
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

  Future<bool> acceptApplicant(String idSurveyor, String idProject) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://surveyscoutbe.onrender.com/api/v1/surveyorapplies/$idProject/acceptedSurveyor"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id_surveyor": idSurveyor,
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Gagal menerima pelamar: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Error menerima pelamar: $e");
      return false;
    }
  }

  Future<bool> rejectApplicant(String idSurveyor, String idProject) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://surveyscoutbe.onrender.com/api/v1/surveyorapplies/$idProject/rejectedSurveyor"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id_surveyor": idSurveyor,
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Gagal menerima pelamar: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Error menerima pelamar: $e");
      return false;
    }
  }

  Future<void> fetchFiles(String idSurvey) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            "https://surveyscoutbe.onrender.com/api/v1/surveys/$idSurvey/surveyAnswer"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Map<String, dynamic> filesData = data['data'];

        filesData.forEach((key, value) {
          if (int.tryParse(key) != null) {
            detailFiles[key] = {
              'url': value['file'],
              'size': int.parse(value['file_size']),
              'type': value['file_type'],
              'idLuaran': value['id_luaran'],
              'surveyId': value['survey_id'],
              'fileName': value['file_name'],
              'uploadedAt': value['diajukan_pada'],
            };
          }
        });
      } else {
        print("Gagal mengambil detail file: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat mengambil data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                    ? 'Detail Proyek Survei'
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
                onRefresh: () => _initializeApiService(),
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
                              color: projectDetail.statusTask != "peringatan"
                                  ? Color(0xFFA3948D)
                                  : Color(0xFFFFCFCC),
                              borderRadius: BorderRadius.circular(8),
                              border: projectDetail.statusTask == "peringatan"
                                  ? Border.all(
                                      color: Color(0xFFF44336),
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Iconify(Ic.round_access_time,
                                    color:
                                        projectDetail.statusTask != "peringatan"
                                            ? Colors.white
                                            : Color(0xFFF44336),
                                    size: 14),
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
                                            color: projectDetail.statusTask !=
                                                    "peringatan"
                                                ? Colors.white
                                                : Color(0xFFF44336),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          projectDetail.tenggatPengerjaan,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "NunitoSans",
                                            color: projectDetail.statusTask !=
                                                    "peringatan"
                                                ? Colors.white
                                                : Color(0xFFFF7E74),
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
                          if (projectDetail.statusTask == "draft")
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDE7E2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Lanjutkan pengisian?',
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
                                              'Kami menyimpan pengisian proyek Anda sebelumnya.',
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
                                                _showPelamar(context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF826754),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.edit,
                                                        size: 14,
                                                        color:
                                                            Color(0xFFEDE7E2)),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      'Lanjutkan',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            "NunitoSans",
                                                        color:
                                                            Color(0xFFEDE7E2),
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
                          if (projectDetail.statusTask == "merekrut")
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDE7E2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (applicantList.length > 0)
                                    Wrap(
                                      children: [
                                        Container(
                                          width: 57,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      (applicantList.length > 3
                                                          ? 3
                                                          : applicantList
                                                              .length);
                                                  i++)
                                                Positioned(
                                                  left: i == 0
                                                      ? 10
                                                      : (i == 1 ? -10 : -50),
                                                  right: i == 1 ? -10 : null,
                                                  bottom: 33,
                                                  child: CircleAvatar(
                                                    radius:
                                                        applicantList.length ==
                                                                1
                                                            ? 20
                                                            : 13,
                                                    backgroundColor:
                                                        Colors.primaries[i %
                                                            Colors.primaries
                                                                .length],
                                                    backgroundImage: NetworkImage(
                                                        applicantList[i]
                                                                .profilePicture ??
                                                            'default_image_url'),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Wrap(
                                      children: [
                                        Container(
                                          width: 57,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned(
                                                left: 10,
                                                bottom: 33,
                                                child: CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor: Colors.red,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/foto1.png'),
                                                ),
                                              ),
                                              Positioned(
                                                right: -10,
                                                bottom: 33,
                                                child: CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor: Colors.blue,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/foto2.png'),
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.green,
                                                backgroundImage: AssetImage(
                                                    'assets/images/foto3.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${applicantList.length} narasumber yang cocok bersedia menjadi responden',
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .local_post_office_sharp,
                                                        size: 14,
                                                        color:
                                                            Color(0xFFEDE7E2)),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      'Tinjau',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "NunitoSans",
                                                        color:
                                                            Color(0xFFEDE7E2),
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
                          if (projectDetail.statusTask == "pembayaran")
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDE7E2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Lanjutkan Pembayaran',
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
                                              'Mohon lanjutkan pembayaran untuk mengunggah proyek Anda',
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
                                                _showPelamar(context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF826754),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.payment,
                                                        size: 14,
                                                        color:
                                                            Color(0xFFEDE7E2)),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      'Bayar Sekarang',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            "NunitoSans",
                                                        color:
                                                            Color(0xFFEDE7E2),
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
                          if (projectDetail.statusTask == "kadaluwarsa")
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDE7E2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                _showPelamar(context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF826754),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.refresh,
                                                        size: 14,
                                                        color:
                                                            Color(0xFFEDE7E2)),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      'Unggah Kembali',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            "NunitoSans",
                                                        color:
                                                            Color(0xFFEDE7E2),
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
                          if (![
                            "draft",
                            "merekrut",
                            "pembayaran",
                            "kadaluwarsa"
                          ].contains(projectDetail.statusTask))
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                            projectDetail.keahlian.join(", "),
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
                          if (widget.type == "respond" &&
                              projectDetail.statusTask == "merekrut") ...[
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
        bottomNavigationBar: (projectDetail.statusTask != 'draft' ||
                projectDetail.statusTask != 'merekrut')
            ? SafeArea(
                child: Container(
                  height: 124,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (projectDetail.statusTask == 'ditinjau')
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFF3A2B24),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Konfirmasi luaran atau ajukan revisi dalam 3 hari',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'NutinoSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xFFF1E9E5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (projectDetail.statusTask == 'dikerjakan' &&
                          projectDetail.statusRevisi == true)
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFF3A2B24),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'File hasil revisi dapat diperiksa di luaran.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'NutinoSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xFFF1E9E5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if ((!['draft', 'merekrut', 'kadaluwarsa', 'pembayaran']
                          .contains(projectDetail.statusTask)))
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 27),
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFF826754),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 600,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1E9E5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.chat,
                                          color: Color(0xFF826754)),
                                      SizedBox(width: 10),
                                      Text(
                                        'Chat',
                                        style: TextStyle(
                                          fontFamily: 'NutinoSans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color(0xFF826754),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (projectDetail.orderId
                                  .toLowerCase()
                                  .startsWith('survey')) ...[
                                SizedBox(width: 8),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    _showLuaran(
                                        context,
                                        projectDetail.idSurvey,
                                        projectDetail.statusTask,
                                        _initializeApiService);
                                  },
                                  child: Container(
                                    height: 600,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF826754),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xFFEDE7E2),
                                            width: 1)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.text_snippet,
                                            color: Color(0xFFEDE7E2)),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFB3261E),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            detailFiles.length.toString(),
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                              ],
                              SizedBox(width: 8),
                              Container(
                                height: 600,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF826754),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.more_vert,
                                        color: Color(0xFFEDE7E2)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              )
            : null,
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
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Pelamar",
                              style: TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF705D54),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFFB8ADA5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  applicantList.length.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'SourceSans3',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF826754),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _apaartiangkaini(context); // Tampilkan pop-up kedua
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey[400],
                            child: Icon(
                              Icons.question_mark,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      itemCount: applicantList.length,
                      itemBuilder: (context, index) {
                        final applicant = applicantList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: ApplicantItem(
                            nama: applicant.namaLengkap,
                            avatarImagePath: applicant.profilePicture ??
                                'assets/images/default_avatar.png',
                            pesan: 'CV tersedia',
                            persentaseLike: applicant.scoutTrust ?? 'N/A',
                            onTapDetail: () {},
                            onTapRekrut: () {
                              Navigator.pop(context);
                              Future.delayed(Duration.zero, () {
                                _rekrutpelamarini(
                                    context,
                                    applicant.profilePicture ??
                                        'assets/images/default_avatar.png',
                                    applicant.namaLengkap,
                                    applicant.scoutTrust ?? 'N/A',
                                    applicant.idSurveyor);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        text: "16 lainnya telah ditolak. ",
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          color: Color(0xFFA3948D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "Tampilkan?",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
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

  void _rekrutpelamarini(BuildContext context, String profilePicture,
      String applicantName, String persentaseLike, String idSurveyor) {
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
              padding: EdgeInsets.all(0),
              color: Color(0xFFF1E9E5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  Divider(
                    thickness: 3,
                    indent: 150,
                    endIndent: 150,
                    color: Color(0xFFB0B0B0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Rekrut Pelamar Ini?",
                    style: TextStyle(
                      fontFamily: 'SourceSans3',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: profilePicture.startsWith('http')
                            ? NetworkImage(profilePicture)
                            : AssetImage('assets/images/hermanwalton.png'),
                      ),
                      Positioned(
                        bottom: -3,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 45,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7CCC8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF826754),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: Color(0xFF826754),
                                  size: 8,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  persentaseLike,
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF826754),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    applicantName,
                    style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Color(0xFF826754),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Future.delayed(Duration.zero, () {
                                _apakahandayakinmerekrutpelamarini(
                                  context,
                                  profilePicture,
                                  applicantName,
                                  persentaseLike,
                                  idSurveyor,
                                );
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF1E9E5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_box,
                                    color: Color(0xFF826754),
                                    size: 24,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Ya, rekrut",
                                    style: TextStyle(
                                      color: Color(0xFF826754),
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Future.delayed(Duration.zero, () {
                                _apakahandayakinmenolakpelamarini(
                                  context,
                                  profilePicture,
                                  applicantName,
                                  persentaseLike,
                                  idSurveyor,
                                );
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xFFF1E9E5), width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.not_interested,
                                    color: Color(0xFFF1E9E5),
                                    size: 24,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Tolak",
                                    style: TextStyle(
                                      color: Color(0xFFF1E9E5),
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _apakahandayakinmerekrutpelamarini(
      BuildContext context,
      String profilePicture,
      String applicantName,
      String persentaseLike,
      String idSurveyor) {
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
              padding: EdgeInsets.all(0),
              color: Color(0xFFF1E9E5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  Divider(
                    thickness: 3,
                    indent: 150,
                    endIndent: 150,
                    color: Color(0xFFB0B0B0),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text.rich(
                      TextSpan(
                        text: "Apakah Anda yakin ",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          color: Color(0xFF705D54),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "merekrut ",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              color: Color(0xFF705D54),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "pelamar ini?",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              color: Color(0xFF705D54),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: profilePicture.startsWith('http')
                            ? NetworkImage(profilePicture)
                            : AssetImage('assets/images/hermanwalton.png'),
                      ),
                      Positioned(
                        bottom: -3,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 45,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7CCC8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF826754),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: Color(0xFF826754),
                                  size: 8,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "$persentaseLike%",
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF826754),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    applicantName,
                    style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text.rich(
                      TextSpan(
                        text: "Merekrut pelamar ini akan ",
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          color: Color(0xFF3A2B24),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "otomatis menolak 3 pelamar lainnya.",
                            style: TextStyle(
                              fontFamily: "NunitoSans",
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Color(0xFF826754),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (await acceptApplicant(
                                  idSurveyor, projectDetail.idSurvey)) {
                                Navigator.pop(context);
                                _showFloatingAlert(
                                    context, "Pelamar berhasil direkrut!");
                                _initializeApiService();
                              } else {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                  msg:
                                      "$applicantName gagal direkrut. Silakan coba lagi.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Color(0xFF826754),
                                  fontSize: 16.0,
                                  fontAsset:
                                      'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF1E9E5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ya, rekrut",
                                    style: TextStyle(
                                      color: Color(0xFF826754),
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xFFF1E9E5), width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Batal",
                                    style: TextStyle(
                                      color: Color(0xFFF1E9E5),
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFloatingAlert(BuildContext context, String message) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 6),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void _apakahandayakinmenolakpelamarini(
      BuildContext context,
      String profilePicture,
      String applicantName,
      String persentaseLike,
      String idSurveyor) {
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
              padding: EdgeInsets.all(0),
              color: Color(0xFFF1E9E5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  Divider(
                    thickness: 3,
                    indent: 150,
                    endIndent: 150,
                    color: Color(0xFFB0B0B0),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text.rich(
                      TextSpan(
                        text: "Apakah Anda yakin ",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          color: Color(0xFF705D54),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "menolak ",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              color: Color(0xFF705D54),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "pelamar ini?",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              color: Color(0xFF705D54),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: profilePicture.startsWith('http')
                            ? NetworkImage(profilePicture)
                            : AssetImage('assets/images/hermanwalton.png'),
                      ),
                      Positioned(
                        bottom: -3,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 45,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7CCC8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF826754),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: Color(0xFF826754),
                                  size: 8,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "$persentaseLike%",
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF826754),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "$applicantName",
                    style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text.rich(
                      TextSpan(
                        text:
                            "Kami yang akan memberitahu pelamar apabila lamarannya ditolak",
                        style: TextStyle(
                          fontFamily: "NunitoSans",
                          color: Color(0xFFA3948D),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Color(0xFF826754),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (await rejectApplicant(
                                  idSurveyor, projectDetail.idSurvey)) {
                                Navigator.pop(context);
                                _showFloatingAlert(
                                    context, "Pelamar berhasil ditolak!");
                                _initializeApiService();
                              } else {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                  msg:
                                      "$applicantName gagal ditolak. Silakan coba lagi.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Color(0xFF826754),
                                  fontSize: 16.0,
                                  fontAsset:
                                      'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF1E9E5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Ya, tolak pelamar",
                                        style: TextStyle(
                                          color: Color(0xFF826754),
                                          fontFamily: "NunitoSans",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xFFF1E9E5), width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Batal",
                                    style: TextStyle(
                                      color: Color(0xFFF1E9E5),
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _apaartiangkaini(BuildContext context) {
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
              padding: EdgeInsets.all(0),
              color: Color(0xFFF1E9E5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  Text(
                    "Apa arti angka ini?",
                    style: TextStyle(
                      fontFamily: 'SourceSans3',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF705D54),
                    ),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/orangmenelepon.png'),
                      ),
                      Positioned(
                        bottom: -15,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7CCC8),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color(0xFF826754),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 6,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: Color(0xFF826754),
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "85%",
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF826754),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(26),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Color(0xFFA3948D),
                            fontSize: 16,
                            fontFamily: "NunitoSans",
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text:
                                'Persentase dengan simbol jari jempol adalah indikator ',
                          ),
                          TextSpan(
                            text: 'ScoutTrust',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' yang menunjukkan:\n'
                                '• Pencapaian surveyor dalam menyelesaikan proyek terdahulu sebelum tenggat waktu\n'
                                '• Akumulasi penilaian klien sebelumnya\n'
                                '• Kecepatan merespons\n'
                                'Semakin tinggi persentase, semakin baik',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF826754),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mengerti",
                                    style: TextStyle(
                                      color: Color(0xFFF1E9E5),
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w400,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
