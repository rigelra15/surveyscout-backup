import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:surveyscout/components/custom_confirmation_dialog.dart';
import 'package:surveyscout/services/projects/api_surveyorprojects.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconify_flutter_plus/icons/fa6_solid.dart';

class UploadedFile {
  final String url;
  final int size;
  final String type;
  final String idLuaran;
  final String surveyId;
  final String fileName;
  final String uploadedAt;

  bool isDownloading;
  double downloadProgress;
  bool downloadCompleted;

  UploadedFile({
    required this.url,
    required this.size,
    required this.type,
    required this.idLuaran,
    required this.surveyId,
    required this.fileName,
    required this.uploadedAt,
    this.isDownloading = false,
    this.downloadProgress = 0.0,
    this.downloadCompleted = false,
  });
}

class Surveyorproyekdetail extends StatefulWidget {
  final String id;

  const Surveyorproyekdetail({Key? key, required this.id}) : super(key: key);

  @override
  _SurveyorproyekdetailState createState() => _SurveyorproyekdetailState();
}

class _SurveyorproyekdetailState extends State<Surveyorproyekdetail>
    with TickerProviderStateMixin {
  bool isBookmarked = false;
  ApiService? apiService;
  late Survey surveyDetail = Survey();
  bool isLoading = true;
  List<PlatformFile> selectedFiles = [];
  List<UploadedFile> uploadedFiles = [];
  Map<String, dynamic> detailFiles = {};
  bool uploaded = false;
  bool isUploading = false;
  String? downloadingFileName;
  double downloadProgress = 0.0;
  AnimationController? _controller;
  bool isDownloading = false;
  bool year2023 = true;
  bool downloadCompleted = false;
  bool showDownloadButton = false;

  @override
  void initState() {
    super.initState();
    _initializeApiService();
    requestStoragePermission();
    requestStoragePermission2();
    requestManageExternalStorage();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);
  }

  Future<void> requestManageExternalStorage() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("Izin MANAGE_EXTERNAL_STORAGE diberikan");
    } else {
      print("Izin MANAGE_EXTERNAL_STORAGE ditolak");
    }
  }

  Future<void> requestStoragePermission() async {
    if (await Permission.manageExternalStorage.isGranted) {
      print("Akses penuh ke penyimpanan diberikan");
    } else {
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        print("Izin diberikan untuk akses penyimpanan penuh");
      } else {
        print("Izin ditolak, aplikasi tidak dapat mengakses penyimpanan penuh");
      }
    }
  }

  Future<void> requestStoragePermission2() async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      print("Izin diberikan!");
    } else if (status.isDenied) {
      print("Izin ditolak, meminta izin lagi...");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
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

  Future<void> _initializeApiService() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print("Token: $token");

    setState(() {
      apiService =
          ApiService("https://surveyscoutbe.onrender.com/api/v1", token: token);
    });

    fetchSurveyAndFiles(widget.id);
  }

  Future<void> fetchSurveyAndFiles(String id) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (apiService != null) {
        Survey profile = await apiService!.getAppliedSurveys(id);
        setState(() {
          surveyDetail = profile;
        });
      }

      final response = await http.get(
        Uri.parse(
            "https://surveyscoutbe.onrender.com/api/v1/surveys/$id/surveyAnswer"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Map<String, dynamic> filesData = data['data'];
        final List<UploadedFile> loadedFiles = [];

        filesData.forEach((key, value) {
          if (int.tryParse(key) != null) {
            final fileInfo = value['file'];
            loadedFiles.add(UploadedFile(
              url: fileInfo,
              size: int.parse(value['file_size']),
              type: value['file_type'],
              idLuaran: value['id_luaran'],
              surveyId: value['survey_id'],
              fileName: value['file_name'],
              uploadedAt: value['diajukan_pada'],
            ));
          }
        });

        setState(() {
          detailFiles = filesData;
          uploadedFiles = loadedFiles;
        });
        print("Detail file: $detailFiles");
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

  Future<void> _uploadFiles(
      List<PlatformFile> selectedFiles, StateSetter setStateModal) async {
    setState(() {
      isUploading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    try {
      Dio dio = Dio();

      print("Token: $token");
      dio.options.headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      };
      print(dio.options.headers);

      FormData formData = FormData();

      for (var file in selectedFiles) {
        formData.files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(file.path!, filename: file.name),
        ));
      }

      String apiUrl =
          "https://surveyscoutbe.onrender.com/api/v1/surveys/uploadAnswer/${widget.id}";

      Response response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 201) {
        setStateModal(() {
          isUploading = false;
        });
        Fluttertoast.showToast(
          msg: "Unggah berhasil!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Color(0xFF826754),
          fontSize: 16.0,
          fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
        );

        setStateModal(() {
          uploaded = true;
        });
        Navigator.pop(context);
        selectedFiles.clear();
        fetchSurveyAndFiles(widget.id);
      } else if (response.statusCode == 403) {
        setStateModal(() {
          isUploading = false;
        });
        Fluttertoast.showToast(
          msg:
              "Akses ditolak: Token mungkin sudah kadaluarsa atau Anda tidak memiliki izin.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Color(0xFF826754),
          fontSize: 16.0,
          fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
        );
      } else {
        setStateModal(() {
          isUploading = false;
        });
        Fluttertoast.showToast(
          msg:
              "Unggah gagal. Silahkan coba lagi! (status code: ${response.statusCode})",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Color(0xFF826754),
          fontSize: 16.0,
          fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
        );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('Error Response: ${e.response?.statusCode}');
          print('Error Message: ${e.response?.data}');
        } else {
          print('Error terjadi: $e');
        }
      }
    }
  }

  Map<String, Map<String, dynamic>> _getStatusIndicator(String status) {
    Map<String, Map<String, dynamic>> statusMap = {
      'mendaftar': {
        'color': Color(0xFF2196F3),
        'icon': Icons.local_post_office,
        'text': 'Mendaftar',
      },
      'ditolak': {
        'color': Color(0xFFFF9696),
        'icon': Icons.warning_rounded,
        'text': 'Ditolak',
      },
      'ditinjau': {
        'color': Color(0xFFFFC107),
        'icon': Icons.pause_circle_filled,
        'text': 'Ditinjau',
      },
      'mengerjakan': {
        'color': Color(0xFFFF9800),
        'icon': Icons.lock_clock,
        'text': 'Mengerjakan',
      },
      'selesai': {
        'color': Color(0xFF4CAF50),
        'icon': Icons.check,
        'text': 'Selesai',
      },
      'deadline': {
        'color': Color(0xFFF44336),
        'icon': Icons.warning_rounded,
        'text': 'Deadline',
      }
    };

    return statusMap.containsKey(status) ? {status: statusMap[status]!} : {};
  }

  Map<String, Map<String, dynamic>> _getDetailStatus(String status) {
    Map<String, Map<String, dynamic>> statusMap = {
      'ditinjau': {
        'colorIcon': Color(0xFF826754),
        'colorBg': Color(0xFFEDE7E2),
        'colorTitle': Color(0xFF705D54),
        'colorDesc': Color(0xFFA3948D),
        'icon': Icons.local_post_office,
        'text': 'Mendaftar',
        'title': 'Menunggu respons',
        'desc':
            'Klien akan memeriksa lamaran atau mengirimkan chat. Anda akan menerima notifikasi mengenai status lamaran Anda.',
        'iconMessage': Icons.check,
        'textMessage': 'Lamaran terkirim',
      },
      'mendaftar': {
        'colorIcon': Color(0xFF826754),
        'colorBg': Color(0xFFEDE7E2),
        'colorTitle': Color(0xFF705D54),
        'colorDesc': Color(0xFFA3948D),
        'icon': Icons.local_post_office,
        'text': 'Mendaftar',
        'title': 'Menunggu respons',
        'desc':
            'Klien akan memeriksa lamaran atau mengirimkan chat. Anda akan menerima notifikasi mengenai status lamaran Anda.',
        'iconMessage': Icons.check,
        'textMessage': 'Lamaran terkirim',
      },
      'ditolak': {
        'colorIcon': Color(0xFFF44336),
        'colorBg': Color(0xFFFFCFCC),
        'colorTitle': Color(0xFFF44336),
        'colorDesc': Color(0xFFFF7E74),
        'icon': Icons.warning_rounded,
        'text': 'Ditolak',
        'title': 'Lamaran Anda ditolak',
        'desc':
            'Klien telah menolak lamaran Anda. Jangan khawatir, Anda masih dapat melamar proyek tersedia lainnya.',
        'iconMessage': Icons.close,
        'textMessage': 'Lamaran ditolak',
      },
      'selesai': {
        'colorIcon': Color(0xFF826754),
        'colorBg': Color(0xFFEDE7E2),
        'colorTitle': Color(0xFF705D54),
        'colorDesc': Color(0xFFA3948D),
        'icon': Icons.tag_faces,
        'text': 'Selesai',
        'title': 'Proyek telah selesai!',
        'desc':
            'Selamat, Anda menyelesaikan proyek ini sebelum tenggat! Pencapaian ini akan meningkatkan nilai ScoutTrust Anda.',
        'iconMessage': Icons.check,
        'textMessage': 'Proyek selesai',
      },
    };

    return statusMap.containsKey(status) ? {status: statusMap[status]!} : {};
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasFiles = detailFiles.keys.any((key) => int.tryParse(key) != null);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF2EEE9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            color: Color(0xFFD7CCC8),
            child: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 50,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF705D54)),
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
                  color: Color(0xFF705D54),
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
                onRefresh: () => fetchSurveyAndFiles(widget.id),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(27),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                surveyDetail.namaProyek,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "SourceSans3",
                                  color: Color(0xFF705D54),
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Color(0xFF705D54),
                              ),
                              onPressed: () {
                                setState(() {
                                  isBookmarked = !isBookmarked;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color:
                                _getStatusIndicator(surveyDetail.statusSurveyor)
                                    .values
                                    .first['color'],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getStatusIndicator(surveyDetail.statusSurveyor)
                                    .values
                                    .first['icon'],
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                _getStatusIndicator(surveyDetail.statusSurveyor)
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
                          surveyDetail.createdAt,
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
                            color: surveyDetail.statusSurveyor == "deadline"
                                ? Color(0xFFFFCFCC)
                                : Color(0xFFA3948D),
                            borderRadius: BorderRadius.circular(8),
                            border: surveyDetail.statusSurveyor == "deadline"
                                ? Border.all(color: Color(0xFFF44336), width: 1)
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.punch_clock_rounded,
                                color: surveyDetail.statusSurveyor == "deadline"
                                    ? Color(0xFFF44336)
                                    : Colors.white,
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
                                          color: surveyDetail.statusSurveyor ==
                                                  "deadline"
                                              ? Color(0xFFF44336)
                                              : Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        surveyDetail.tenggatPengerjaan,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NunitoSans",
                                          color: surveyDetail.statusSurveyor ==
                                                  "deadline"
                                              ? Color(0xFFFF7E74)
                                              : Colors.white,
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
                                            surveyDetail.lokasi,
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
                                                surveyDetail.kompensasi),
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
                        if (['mendaftar', 'selesai', 'ditolak']
                            .contains(surveyDetail.statusSurveyor))
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  _getDetailStatus(surveyDetail.statusSurveyor)
                                      .values
                                      .first['colorBg'],
                              border: Border.all(
                                color: _getDetailStatus(
                                        surveyDetail.statusSurveyor)
                                    .values
                                    .first['colorIcon'],
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    _getDetailStatus(
                                            surveyDetail.statusSurveyor)
                                        .values
                                        .first['icon'],
                                    color: _getDetailStatus(
                                            surveyDetail.statusSurveyor)
                                        .values
                                        .first['colorIcon'],
                                    size: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _getDetailStatus(
                                                    surveyDetail.statusSurveyor)
                                                .values
                                                .first['title'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "NunitoSans",
                                              color: _getDetailStatus(
                                                      surveyDetail
                                                          .statusSurveyor)
                                                  .values
                                                  .first['colorTitle'],
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            _getDetailStatus(
                                                    surveyDetail.statusSurveyor)
                                                .values
                                                .first['desc'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "NunitoSans",
                                              color: _getDetailStatus(
                                                      surveyDetail
                                                          .statusSurveyor)
                                                  .values
                                                  .first['colorDesc'],
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
                          ),
                        if (!["ditolak", "mendaftar", "selesai"]
                            .contains(surveyDetail.statusSurveyor))
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
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Agus Ginting',
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
                                                  'Klien',
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
                                                SizedBox(width: 8),
                                                Icon(Icons.check_circle,
                                                    color: Color(0xFFA3948D),
                                                    size: 10),
                                                SizedBox(width: 4),
                                                Text(
                                                  'PT Widya Mandiri',
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
                                        text: 'Anda: ',
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
                          surveyDetail.deskripsiProyek,
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
                          surveyDetail.keahlian.join(', '),
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
                          surveyDetail.tipeHasil.join(', '),
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
                                'ID #${surveyDetail.idSurvey}',
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
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 124,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (surveyDetail.statusSurveyor == "deadline")
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 28,
                    decoration: BoxDecoration(
                      color: Color(0xFF3A2B24),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tenggat terlewat, performa ScoutTrust Anda akan terpengaruh',
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
                if (surveyDetail.statusSurveyor == "ditinjau" &&
                    surveyDetail.statusRevisi == false)
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
                            'Kami telah memberitahu klien bahwa luaran Anda telah selesai. Mohon tunggu verifikasi dalam 3 hari.',
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
                if (surveyDetail.statusRevisi == true)
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
                            'Klien mengajukan revisi, silakan periksa chat',
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF826754),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!["ditolak", "mendaftar", "selesai"]
                          .contains(surveyDetail.statusSurveyor)) ...[
                        Expanded(
                          child: Container(
                            height: 600,
                            decoration: BoxDecoration(
                              color: Color(0xFFF1E9E5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.chat, color: Color(0xFF826754)),
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
                        SizedBox(width: 8),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            _showLuaran(context);
                          },
                          child: Container(
                            height: 600,
                            decoration: BoxDecoration(
                                color: Color(0xFF826754),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xFFEDE7E2), width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                if (hasFiles)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFB3261E),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      (detailFiles['jumlah_luaran'] +
                                              selectedFiles.length)
                                          .toString(),
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
                      ] else
                        Expanded(
                          child: Container(
                            height: 600,
                            decoration: BoxDecoration(
                              color: Color(0xFF826754),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                    _getDetailStatus(
                                            surveyDetail.statusSurveyor)
                                        .values
                                        .first['iconMessage'],
                                    color: Color(0xFFEDE7E2)),
                                SizedBox(width: 10),
                                Text(
                                  _getDetailStatus(surveyDetail.statusSurveyor)
                                      .values
                                      .first['textMessage'],
                                  style: TextStyle(
                                    fontFamily: 'NutinoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xFFEDE7E2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                            Icon(Icons.more_vert, color: Color(0xFFEDE7E2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLuaran(BuildContext context) {
    void _pickFiles(StateSetter setStateModal) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        setStateModal(() {
          selectedFiles.addAll(result.files);
        });
      }
    }

    String _getFileIconify(String fileName) {
      if (fileName.endsWith('.pdf')) {
        return Ci.file_pdf;
      } else if (fileName.endsWith('.docx')) {
        return Mdi.file_word;
      } else if (fileName.endsWith('.xlsx')) {
        return Mdi.file_excel;
      } else if (fileName.endsWith('.pptx')) {
        return Mdi.file_powerpoint;
      } else if (fileName.endsWith('.txt')) {
        return Mdi.file_document;
      } else if (fileName.endsWith('.jpg') ||
          fileName.endsWith('.png') ||
          fileName.endsWith('.gif')) {
        return Ci.file_image;
      } else if (fileName.endsWith('.mp3') || fileName.endsWith('.wav')) {
        return Mdi.file_music;
      } else if (fileName.endsWith('.mp4') || fileName.endsWith('.mov')) {
        return Mdi.file_video;
      } else {
        return Mdi.file;
      }
    }

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

    String _formatFileSizeUploaded(int bytes) {
      if (bytes < 1000) {
        return "$bytes B";
      } else if (bytes < 1000 * 1000) {
        return "${(bytes / 1000).toStringAsFixed(1)} KB";
      } else if (bytes < 1000 * 1000 * 1000) {
        return "${(bytes / (1000 * 1000)).toStringAsFixed(1)} MB";
      } else {
        return "${(bytes / (1000 * 1000 * 1000)).toStringAsFixed(1)} GB";
      }
    }

    String _convertDate(String date) {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('dd MMMM yyyy', 'id-ID').format(dateTime);
    }

    Future<String?> _getCustomDownloadDirectory() async {
      try {
        final prefs = await SharedPreferences.getInstance();

        String? savedDirectory = prefs.getString('customDownloadDirectory');

        if (savedDirectory != null) {
          return savedDirectory;
        } else {
          String defaultPath =
              '/storage/emulated/0/Download/SurveyScout/${surveyDetail.idSurvey}-${surveyDetail.namaProyek}';

          Directory(defaultPath).createSync(recursive: true);

          await prefs.setString('customDownloadDirectory', defaultPath);

          return defaultPath;
        }
      } catch (e) {
        print("Error mengambil direktori default: $e");
        return null;
      }
    }

    void _downloadFile(UploadedFile file, StateSetter setStateModal) async {
      try {
        setStateModal(() {
          file.isDownloading = true;
          file.downloadProgress = 0.0;
          file.downloadCompleted = false;
        });

        Dio dio = Dio();

        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('customDownloadDirectory');

        String? customDownloadDirectory = await _getCustomDownloadDirectory();

        if (customDownloadDirectory != null) {
          String savePath = '$customDownloadDirectory/${file.fileName}';

          Directory(customDownloadDirectory).createSync(recursive: true);

          await dio.download(file.url, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              setStateModal(() {
                file.downloadProgress = (received / total);
              });
            }
          });

          setStateModal(() {
            file.isDownloading = false;
            file.downloadProgress = 1.0;
            file.downloadCompleted = true;
          });

          Future.delayed(Duration(seconds: 1), () {
            setStateModal(() {
              file.downloadCompleted = false;
            });
          });

          Fluttertoast.showToast(
            msg: "${file.fileName} berhasil disimpan di $savePath!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFF826754),
            fontSize: 16.0,
            fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
          );

          print("File berhasil diunduh dan disimpan di: $savePath");
        } else {
          print("Tidak ada direktori yang dipilih atau tersedia.");
        }
      } catch (e) {
        print("Error saat mendownload file: $e");

        setStateModal(() {
          file.isDownloading = false;
          file.downloadProgress = 0.0;
          file.downloadCompleted = false;
        });
      }
    }

    void _removeFile(StateSetter setStateModal, PlatformFile file) {
      setStateModal(() {
        selectedFiles.remove(file);
      });
    }

    void _removeUploadedFile(StateSetter setStateModal, UploadedFile file,
        BuildContext context) async {
      print("File ID Luaran: ${file.idLuaran}");
      print("File Survey ID: ${file.surveyId}");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
            title: 'Hapus File',
            message: 'Apakah Anda yakin ingin menghapus file ${file.fileName}?',
            confirmText: 'Hapus',
            cancelText: 'Batal',
            onConfirm: () async {
              try {
                final response = await http.delete(
                  Uri.parse(
                      'https://surveyscoutbe.onrender.com/api/v1/surveys/${file.idLuaran}/deleteAnswer'),
                  headers: {"Content-Type": "application/json"},
                  body: jsonEncode({
                    "survey_id": file.surveyId,
                  }),
                );

                if (response.statusCode == 204) {
                  setStateModal(() {
                    uploadedFiles.remove(file);
                  });

                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                    msg:
                        "File ${file.fileName} berhasil dihapus dari luaran proyek!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF826754),
                    fontSize: 16.0,
                    fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                  );
                } else {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                    msg:
                        "Gagal menghapus file ${file.fileName} dari luaran proyek!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF826754),
                    fontSize: 16.0,
                    fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                  );
                  // Print Error
                  print("Error: ${response.body}");
                }
              } catch (e) {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg:
                      "Error menghapus file ${file.fileName} dari luaran proyek!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF826754),
                  fontSize: 16.0,
                  fontAsset: 'assets/fonts/nunito-sans/NunitoSans-Bold.ttf',
                );

                setStateModal(() {
                  file.isDownloading = false;
                  file.downloadProgress = 0.0;
                  file.downloadCompleted = false;
                });
              }
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setStateModal) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 20),
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
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Luaran",
                              style: TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF705D54),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Color(0xFFB8ADA5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                selectedFiles.isEmpty
                                    ? uploadedFiles.isNotEmpty
                                        ? (uploadedFiles.length +
                                                selectedFiles.length)
                                            .toString()
                                        : "0"
                                    : (selectedFiles.length +
                                            uploadedFiles.length)
                                        .toString(),
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF826754),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (uploadedFiles.isNotEmpty) ...[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF705D54),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_done,
                                  color: Color(0xFFF1E9E5),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Luaran yang telah diunggah',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "NunitoSans",
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFF1E9E5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: uploadedFiles.map((file) {
                              return ListTile(
                                leading: Iconify(
                                  _getFileIconify(file.fileName),
                                  color: Color(0xFF705D54),
                                  size: 30,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      file.fileName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "NunitoSans",
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF705D54),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Diunggah pada ${_convertDate(file.uploadedAt)} • ${_formatFileSizeUploaded(file.size)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "NunitoSans",
                                        color: Color(0xFFA3948D),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (!file.isDownloading) {
                                          _downloadFile(file, setStateModal);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF826754),
                                          shape: BoxShape.circle,
                                        ),
                                        child: file.isDownloading
                                            ? CircularProgressIndicator(
                                                value: file.downloadProgress,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              )
                                            : file.downloadCompleted
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Colors.white,
                                                    size: 24,
                                                  )
                                                : Iconify(
                                                    MaterialSymbols
                                                        .download_rounded,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                      ),
                                    ),
                                    if (surveyDetail.statusSurveyor !=
                                        "ditinjau") ...[
                                      SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: () => _removeUploadedFile(
                                            setStateModal, file, context),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xFF826754),
                                                width: 2),
                                            color: Colors.transparent,
                                          ),
                                          child: Iconify(Dashicons.trash,
                                              color: Color(0xFF826754),
                                              size: 9),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                      if (selectedFiles.isNotEmpty) ...[
                        if (uploadedFiles.isEmpty) SizedBox(height: 24),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF705D54),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload,
                                    color: Color(0xFFF1E9E5),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'File yang akan diunggah',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NunitoSans",
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFF1E9E5),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: selectedFiles
                                .map((file) => ListTile(
                                      leading: Iconify(
                                        _getFileIconify(file.name),
                                        color: Color(0xFF705D54),
                                        size: 30,
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            file.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "NunitoSans",
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF705D54),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            _formatFileSize(file.size),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "NunitoSans",
                                              color: Color(0xFFA3948D),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (!uploaded)
                                            GestureDetector(
                                              onTap: () => _removeFile(
                                                  setStateModal, file),
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Color(0xFF826754),
                                                      width: 2),
                                                  color: Colors.transparent,
                                                ),
                                                child: Iconify(Dashicons.trash,
                                                    color: Color(0xFF826754),
                                                    size: 9),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                      if (uploadedFiles.isEmpty && selectedFiles.isEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 27, vertical: 60),
                          child: Column(
                            children: [
                              SvgPicture.string(
                                  '''<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 24 24"><g fill="none" fill-rule="evenodd"><path d="m12.594 23.258l-.012.002l-.071.035l-.02.004l-.014-.004l-.071-.036q-.016-.004-.024.006l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427q-.004-.016-.016-.018m.264-.113l-.014.002l-.184.093l-.01.01l-.003.011l.018.43l.005.012l.008.008l.201.092q.019.005.029-.008l.004-.014l-.034-.614q-.005-.019-.02-.022m-.715.002a.02.02 0 0 0-.027.006l-.006.014l-.034.614q.001.018.017.024l.015-.002l.201-.093l.01-.008l.003-.011l.018-.43l-.003-.012l-.01-.01z"/><path fill="#a3948d" d="M12.916 3.244a3 3 0 0 0-1.832 0L4.55 5.34a1 1 0 0 0-.556.45L1.757 9.654a1 1 0 0 0 .56 1.453l7.14 2.292a1 1 0 0 0 1.171-.451l.372-.642v2.317a1 1 0 0 1-1.306.952l-5.838-1.873v3.278a2 2 0 0 0 1.388 1.905l5.84 1.872a3 3 0 0 0 1.832 0l5.84-1.872a2 2 0 0 0 1.389-1.905l-.002-3.278l-5.837 1.873A1 1 0 0 1 13 14.622v-2.317l.371.642a1 1 0 0 0 1.171.45l7.141-2.29a1 1 0 0 0 .56-1.454L20.006 5.79a1 1 0 0 0-.556-.45zm2.953 3.048L12 7.533L8.13 6.292l3.564-1.144a1 1 0 0 1 .611 0z"/></g></svg>''',
                                  width: 57.0,
                                  height: 57.0,
                                  placeholderBuilder: (BuildContext context) =>
                                      Container(
                                        padding: const EdgeInsets.all(30.0),
                                        child:
                                            const CircularProgressIndicator(),
                                      )),
                              Text(
                                'Belum ada luaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "NunitoSans",
                                  color: Color(0xFFA3948D),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  'Unggah file luaran saat keseluruhan proses telah selesai',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "NunitoSans",
                                    color: Color(0xFFBBAEA9),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!uploaded &&
                          surveyDetail.statusSurveyor != "ditinjau")
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFF826754),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (uploadedFiles.isNotEmpty ||
                                  selectedFiles.isNotEmpty ||
                                  surveyDetail.statusRevisi) ...[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _pickFiles(setStateModal),
                                    child: Container(
                                      height: 600,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF826754),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xFFF1E9E5), width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,
                                              color: Color(0xFFF1E9E5)),
                                          SizedBox(width: 10),
                                          Text('Tambah File',
                                              style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Color(0xFFF1E9E5),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                              ],
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    if (selectedFiles.isEmpty) {
                                      _pickFiles(setStateModal);
                                    } else {
                                      setState(() {
                                        isUploading = true;
                                      });

                                      _uploadFiles(
                                          selectedFiles, setStateModal);
                                    }
                                  },
                                  child: Container(
                                    height: 600,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1E9E5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (isUploading)
                                          SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Color(0xFF826754)),
                                            ),
                                          )
                                        else ...[
                                          Icon(Icons.upload,
                                              color: Color(0xFF826754)),
                                          SizedBox(width: 10),
                                          Text(
                                            isUploading
                                                ? 'Mengunggah...'
                                                : 'Unggah',
                                            style: TextStyle(
                                              fontFamily: 'NunitoSans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Color(0xFF826754),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (detailFiles.isNotEmpty &&
                          surveyDetail.statusSurveyor == "ditinjau")
                        Padding(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEDE7E2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Color(0xFF826754), width: 1),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  'Menunggu respons',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "NunitoSans",
                                    color: Color(0xFF705D54),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Klien akan memeriksa luaran dalam 3 hari. Apabila terdapat revisi, kami akan memberitahu Anda.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "NunitoSans",
                                    color: Color(0xFFA3948D),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(16),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
