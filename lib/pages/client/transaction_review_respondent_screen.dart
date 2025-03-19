import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:get/get.dart';
import 'package:surveyscout/routes/app_routes.dart';

class TransactionReviewRespondentScreen extends StatefulWidget {
  String? idDraft;
  int? commission;

  TransactionReviewRespondentScreen({this.idDraft, this.commission});

  @override
  _TransactionReviewRespondentScreenState createState() =>
      _TransactionReviewRespondentScreenState();
}

class _TransactionReviewRespondentScreenState
    extends State<TransactionReviewRespondentScreen> {
  String _projectTitle = "";
  int _projectCommissionPerPerson = 0;
  int _projectRespondentAmount = 0;
  int _totalCommission = 0;
  int _totalPayment = 0;

  @override
  void initState() {
    super.initState();

    // Retrieve stored values using GetStorage()
    _projectTitle =
        GetStorage().read('project_title') ?? "Judul Proyek Tidak Ditemukan";
    _projectCommissionPerPerson =
        GetStorage().read('project_commission_per_person') ?? 0;
    _projectRespondentAmount =
        GetStorage().read('project_respondent_amount') ?? 0;

    // Perform calculations inside initState()
    _totalCommission = _projectCommissionPerPerson * _projectRespondentAmount;
    _totalPayment = _totalCommission + 5000; // Biaya penanganan 5000

    //Print debug all numbers
    print("projectitle: $_projectTitle");
    print(
        "projectComission: $_projectCommissionPerPerson x $_projectRespondentAmount");
    print("totalComission: $_totalCommission thus to be $_totalPayment");
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
            onPressed: () {},
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
                // Progress Bar
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

                // Title "Langkah 3"
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
            SizedBox(height: 24), // Add spacing before receipt section
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
                  _buildReceiptRow(
                      "Komisi ($_projectRespondentAmount responden)",
                      "Rp $_totalCommission"),
                  _buildReceiptRow("Biaya Penanganan", "Rp 5.000"),
                  _buildReceiptRow("Biaya Administrasi Bank", "Rp 0"),
                  Divider(color: Color(0xFF826754), thickness: 1),
                  _buildReceiptRow("Total Pembayaran", "Rp $_totalPayment",
                      isBold: true),
                ],
              ),
            ),
            // Garansi Uang Kembali Panel

            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFA3948D), // Background color
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Iconify(IconParkSolid.protect,
                        color: Colors.white, size: 24), // Icon
                  ),
                  SizedBox(width: 12), // Spacing
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

            SizedBox(height: 16), // Spacing below panel

            // Pembayaran akan diproses dengan
            Text(
              "Pembayaran akan diproses dengan",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xFF705D54),
              ),
            ),

            SizedBox(height: 8), // Spacing

            // Payment Processing Image (Replace with actual asset or URL)
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
        color: Color(0xFF826754), // Footer background color
        child: Row(
          children: [
            // Kembali Button (Outlined) - Takes Half Width
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
                    borderRadius:
                        BorderRadius.circular(8), // 8dp rounded rectangle
                  ),
                ),
                child: Text("Kembali",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              ),
            ),

            SizedBox(width: 8), // Space between buttons

            // Lanjut Button (Filled) - Takes Half Width
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(
                    AppRoutes.paymentGateway), // Disable if incomplete
                icon: Icon(Icons.arrow_forward, size: 20),
                label: Text("Lanjut",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: _isFormComplete() ? Color(0xFFEDE7E2) : Color(0xFFB5A89A), // Disabled color if incomplete
                  foregroundColor: Color(0xFF826754), // Text/icon color
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // 8dp rounded rectangle
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
