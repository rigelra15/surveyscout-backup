import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:surveyscout/pages/client/payment_gateway_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionReviewScreen extends StatefulWidget {
  final String idDraft;
  final int commission;

  TransactionReviewScreen({required this.idDraft, required this.commission});

  @override
  _TransactionReviewScreenState createState() =>
      _TransactionReviewScreenState();
}

class _TransactionReviewScreenState extends State<TransactionReviewScreen> {
  String formatRupiah(dynamic amount) {
    if (amount == null) return "Rp 0";
    final number = int.tryParse(amount.toString()) ?? 0;
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}";
  }

  Widget _buildReceiptRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: Color(0xFF705D54),
              )),
          Text(value,
              textAlign: TextAlign.right,
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: Color(0xFF705D54),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: AppBar(
        title: Text(
          'Scouting Talent',
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            color: Color(0xFF705D54),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFD7CCC8),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF826754)),
        leading: IconButton(
          icon: Iconify(MaterialSymbols.arrow_back, color: Color(0xFF826754)),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Iconify(MaterialSymbols.more_vert, color: Color(0xFF826754)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF826754),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF826754),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF826754),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Langkah 3',
                  style: TextStyle(
                    color: Color(0xFF705D54),
                    fontSize: 24,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tinjau dan konfirmasi transaksi untuk proyek “Studi Kepuasan Penggunaan Produk Kecantikan”',
                  style: GoogleFonts.nunitoSans(
                    color: Color(0xFFA3948D),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF0E8E4),
                border: Border(
                  top: BorderSide(color: Color(0xFF826754), width: 1),
                  bottom: BorderSide(color: Color(0xFF826754), width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildReceiptRow("Komisi", formatRupiah(widget.commission)),
                  _buildReceiptRow("Biaya Penanganan", "Rp 5.000"),
                  _buildReceiptRow("Biaya Administrasi Bank", "Rp 0"),
                  Divider(color: Color(0xFF826754), thickness: 1),
                  _buildReceiptRow("Total Pembayaran",
                      formatRupiah(widget.commission + 5000),
                      isBold: true),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFA3948D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Iconify(IconParkSolid.protect,
                        color: Colors.white, size: 24),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Garansi Uang Kembali 100%",
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Pembayaran Anda akan dikembalikan apabila tidak ada kandidat yang mendaftar setelah 7 hari pengunggahan",
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Pembayaran akan diproses dengan",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xFF705D54),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Image.asset(
                "assets/images/qrislogo.png",
                width: 167,
                height: 27,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Color(0xFF826754),
        child: Row(
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
                child: Text("Kembali",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse(
                        'https://surveyscoutbe.onrender.com/api/v1/surveys/createSurveyPayment/${widget.idDraft}'),
                    headers: {
                      'Content-Type': 'application/json',
                    },
                  );

                  if (response.statusCode == 201) {
                    final data = jsonDecode(response.body);
                    final snapUrl = data['snap_url'];
                    final orderId = data['order_id'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentGatewayScreen(
                          snapUrl: snapUrl,
                          orderId: orderId,
                          idDraft: widget.idDraft,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Terjadi kesalahan saat membuat transaksi. Silakan coba lagi."),
                        backgroundColor: Color(0xFF826754),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(16),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.arrow_forward,
                    size: 20, color: Color(0xFF826754)),
                label: Text("Lanjut",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF826754),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
