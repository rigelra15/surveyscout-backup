import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:get/get.dart';
import 'package:surveyscout/routes/app_routes.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: AppBar(
        title: Text(
          'Pembayaran Berhasil',
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
          onPressed: () => Get.toNamed(AppRoutes.clientProjectList),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Iconify(
              MaterialSymbols.check_circle,
              color: Color(0xFF4CAF50),
              size: 128,
            ),
            SizedBox(height: 16),
            Text(
              'Terima kasih!',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF705D54),
                height: 1.1,
              ),
            ),
            SizedBox(height: 8),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Pembayaran Anda telah berhasil. Proyek Anda sekarang aktif dan lowongan telah dibuka.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Color(0xFFA3948D),
                    height: 1.1,
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Color(0xFF826754), // Footer background color
        child: Row(
          children: [
            // Kembali Button (Outlined) - Takes Half Width
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.offNamed(AppRoutes.clientProjectList),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFEDE7E2)),
                  backgroundColor: Color(0xFFF1E9E5),
                  foregroundColor: Color(0xFF826754),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // 8dp rounded rectangle
                  ),
                ),
                child: Text("Lihat Proyek",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold, color: Color(0xFF826754))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
