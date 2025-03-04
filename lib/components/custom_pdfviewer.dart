import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CustomPdfViewer extends StatefulWidget {
  final String title;
  final String pdfUrl;

  const CustomPdfViewer({
    Key? key,
    required this.title,
    required this.pdfUrl,
  }) : super(key: key);

  @override
  _CustomPdfViewerState createState() => _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  String? localFilePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/temp.pdf');
        await file.writeAsBytes(bytes);
        setState(() {
          localFilePath = file.path;
          isLoading = false;
        });
      } else {
        throw Exception("Gagal mengunduh PDF");
      }
    } catch (e) {
      print("Error memuat PDF: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF826754),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 500,
            width: 300,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : (localFilePath != null
                    ? PDFView(
                        filePath: localFilePath!,
                        enableSwipe: true,
                        swipeHorizontal: false,
                        autoSpacing: false,
                        pageFling: false,
                      )
                    : const Center(child: Text("Gagal memuat PDF"))),
          ),
        ],
      ),
    );
  }
}
