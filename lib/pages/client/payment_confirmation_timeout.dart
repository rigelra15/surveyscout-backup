import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:get/get.dart';
import 'package:surveyscout/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentTimeoutScreen extends StatefulWidget {
  @override
  _PaymentTimeoutScreenState createState() => _PaymentTimeoutScreenState();
}

class _PaymentTimeoutScreenState extends State<PaymentTimeoutScreen> {
  Future<void> _launchWhatsApp() async {
    final String phoneNumber = "6281800100800"; // Without the "+" sign
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: AppBar(
        title: Text(
          'Pembayaran Gagal',
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
              Majesticons.emoji_sad,
              color: Color(0xFFFF9800),
              size: 128,
            ),
            SizedBox(height: 16),
            Text(
              'Waktu Pembayaran Habis',
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
                padding: EdgeInsets.symmetric(horizontal:16),
                child: Text(
                  'Mohon periksa histori transaksi di aplikasi m-banking atau e-wallet Anda, jika tertera berhasil, silakan chat kami untuk mengirimkan bukti.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Color(0xFFA3948D),
                    height: 1.1,
                  ),
                )
            )
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Color(0xFF826754), // Footer background color
        child: Row(
          children: [

            Expanded(
              child: OutlinedButton(
                onPressed: _launchWhatsApp,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFEDE7E2)),
                  foregroundColor: Color(0xFFEDE7E2),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 8dp rounded rectangle
                  ),
                ),
                child: Text("Chat Bantuan", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              ),
            ),

            SizedBox(width: 8), // Add space between buttons (horizontal
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.offNamed(AppRoutes.chooseRecruitment),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFEDE7E2)),
                  backgroundColor: Color(0xFFF1E9E5),
                  foregroundColor: Color(0xFF826754),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 8dp rounded rectangle
                  ),
                ),
                child: Text("Coba Lagi", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, color: Color(0xFF826754))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}