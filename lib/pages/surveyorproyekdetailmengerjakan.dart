import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:surveyscout/services/projects/api_surveyorprojects.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Surveyorproyekdetailmengerjakan extends StatefulWidget {
  final String id;

  const Surveyorproyekdetailmengerjakan({Key? key, required this.id})
      : super(key: key);

  @override
  _SurveyorproyekdetailmengerjakanState createState() =>
      _SurveyorproyekdetailmengerjakanState();
}

class _SurveyorproyekdetailmengerjakanState
    extends State<Surveyorproyekdetailmengerjakan> {
  bool isBookmarked = false;
  ApiService? apiService;
  late Survey surveyDetail = Survey();
  bool isLoading = true;
  List<PlatformFile> selectedFiles = [];

  @override
  void initState() {
    super.initState();
    _initializeApiService();
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
        Survey profile = await apiService!.getASurvey(id);
        setState(() {
          surveyDetail = profile;
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
                onRefresh: () => _fetchClientRespondenDetail(widget.id),
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
                            color: Color(0xFFFF9800),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.lock_clock,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Mengerjakan',
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
                                        surveyDetail.tenggatPengerjaan,
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
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
                      border: Border.all(color: Color(0xFFEDE7E2), width: 1)),
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
                    ],
                  ),
                ),
              )),
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

        print("==== DEBUGGING FILE PICKER ====");
        print("Jumlah file terpilih: ${selectedFiles.length}");
        for (var file in selectedFiles) {
          print("File Name: ${file.name}");
          print("File Path: ${file.path}");
          print("File Size: ${file.size} bytes");
        }
        print("==============================");
      }
    }

    String _getFileIconify(String fileName) {
      if (fileName.endsWith('.pdf') ||
          fileName.endsWith('.docx') ||
          fileName.endsWith('.txt')) {
        return Ci.file_pdf;
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

    void _downloadFile(PlatformFile file) {
      print("Mengunduh file: ${file.name}");
    }

    void _removeFile(StateSetter setStateModal, PlatformFile file) {
      setStateModal(() {
        selectedFiles.remove(file);
      });
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
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
                                  ? "0"
                                  : selectedFiles.length.toString(),
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
                    SizedBox(height: 20),
                    selectedFiles.isNotEmpty
                        ? Container(
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
                                            GestureDetector(
                                              onTap: () => _downloadFile(file),
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF826754),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Iconify(
                                                    MaterialSymbols
                                                        .download_rounded,
                                                    color: Colors.white,
                                                    size: 20),
                                              ),
                                            ),
                                            SizedBox(width: 8),
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
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 27, vertical: 60),
                            child: Column(
                              children: [
                                SvgPicture.string(
                                    '''<svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 24 24"><g fill="none" fill-rule="evenodd"><path d="m12.594 23.258l-.012.002l-.071.035l-.02.004l-.014-.004l-.071-.036q-.016-.004-.024.006l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427q-.004-.016-.016-.018m.264-.113l-.014.002l-.184.093l-.01.01l-.003.011l.018.43l.005.012l.008.008l.201.092q.019.005.029-.008l.004-.014l-.034-.614q-.005-.019-.02-.022m-.715.002a.02.02 0 0 0-.027.006l-.006.014l-.034.614q.001.018.017.024l.015-.002l.201-.093l.01-.008l.003-.011l.018-.43l-.003-.012l-.01-.01z"/><path fill="#a3948d" d="M12.916 3.244a3 3 0 0 0-1.832 0L4.55 5.34a1 1 0 0 0-.556.45L1.757 9.654a1 1 0 0 0 .56 1.453l7.14 2.292a1 1 0 0 0 1.171-.451l.372-.642v2.317a1 1 0 0 1-1.306.952l-5.838-1.873v3.278a2 2 0 0 0 1.388 1.905l5.84 1.872a3 3 0 0 0 1.832 0l5.84-1.872a2 2 0 0 0 1.389-1.905l-.002-3.278l-5.837 1.873A1 1 0 0 1 13 14.622v-2.317l.371.642a1 1 0 0 0 1.171.45l7.141-2.29a1 1 0 0 0 .56-1.454L20.006 5.79a1 1 0 0 0-.556-.45zm2.953 3.048L12 7.533L8.13 6.292l3.564-1.144a1 1 0 0 1 .611 0z"/></g></svg>''',
                                    width: 57.0,
                                    height: 57.0,
                                    placeholderBuilder:
                                        (BuildContext context) => Container(
                                              padding:
                                                  const EdgeInsets.all(30.0),
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF826754),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (selectedFiles.isNotEmpty) ...[
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add, color: Color(0xFFF1E9E5)),
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
                              onTap: () => _pickFiles(setStateModal),
                              child: Container(
                                height: 600,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1E9E5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload,
                                        color: Color(0xFF826754)),
                                    SizedBox(width: 10),
                                    Text('Unggah',
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color(0xFF826754),
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
          },
        );
      },
    );
  }
}
