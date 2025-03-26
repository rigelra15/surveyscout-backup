import 'package:flutter/material.dart';
import 'package:surveyscout/pages/client/clientprojects.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'dart:async';

class PaymentGatewayScreen extends StatefulWidget {
  final String snapUrl;
  final String orderId;
  final String idDraft;

  PaymentGatewayScreen(
      {required this.snapUrl, required this.orderId, required this.idDraft});

  @override
  _PaymentGatewayScreenState createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  Timer? _statusPollingTimer;
  late final WebViewController _controller;
  late String _currentSnapUrl;
  late String _currentOrderId;
  String _paymentStatus = "Status belum diketahui";
  bool _isLoadingStatus = false;

  bool _isFinalStatus(String status) {
    return status == 'settlement' ||
        status == 'expire' ||
        status == 'cancel' ||
        status == 'deny' ||
        status == 'failure';
  }

  Future<void> _launchWhatsApp() async {
    final String phoneNumber = "6281800100800";
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch WhatsApp");
    }
  }

  Future<void> _getNewSnapUrlAndReload(String draft) async {
    setState(() {
      _isLoadingStatus = true;
    });

    try {
      final statusResponse = await http.post(
        Uri.parse(
            "https://surveyscoutbe.onrender.com/api/v1/midtransNotif/midtransResponse"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"order_id": _currentOrderId}),
      );

      if (statusResponse.statusCode == 200) {
        final statusData = jsonDecode(statusResponse.body);
        final currentStatus =
            statusData['status']?['transaction_status'] ?? 'unknown';

        print("Current payment status before reload: $currentStatus");

        if (currentStatus == 'expire') {
          try {
            // Tentukan endpoint berdasarkan tipe order
            final String endpoint = widget.orderId.startsWith("SURVEY")
                ? "https://surveyscoutbe.onrender.com/api/v1/surveys/createSurveyPayment/$draft"
                : "https://surveyscoutbe.onrender.com/api/v1/responds/createRespondPayment/$draft";

            // Lakukan request
            final response = await http.post(Uri.parse(endpoint));

            if (response.statusCode == 201) {
              final data = jsonDecode(response.body);
              final newUrl = data['snap_url'];
              final newOrderId = data['order_id'];

              print("New Snap URL: $newUrl, New Order ID: $newOrderId");

              setState(() {
                _currentSnapUrl = newUrl;
                _currentOrderId = newOrderId;
                _paymentStatus = "Status belum diketahui";
              });

              _controller.loadRequest(Uri.parse(_currentSnapUrl));

              _statusPollingTimer?.cancel();
              _statusPollingTimer =
                  Timer.periodic(Duration(seconds: 5), (timer) {
                _fetchPaymentStatus();
              });

              Future.delayed(Duration(milliseconds: 500), () {
                _fetchPaymentStatus();
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Gagal mengambil Snap URL baru."),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Terjadi kesalahan saat ambil Snap URL."),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Transaksi masih aktif atau belum kedaluwarsa."),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal memeriksa status transaksi lama."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan saat memeriksa status transaksi."),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoadingStatus = false;
      });
    }
  }

  Future<void> _fetchPaymentStatus() async {
    print("Fetching payment status for orderId: $_currentOrderId");
    setState(() {
      _isLoadingStatus = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            "https://surveyscoutbe.onrender.com/api/v1/midtransNotif/midtransResponse"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"order_id": _currentOrderId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status']?['transaction_status'];

        setState(() {
          _paymentStatus = status ?? "waiting";
        });

        if (_isFinalStatus(_paymentStatus)) {
          _statusPollingTimer?.cancel();
          print("Polling stopped because status is: $_paymentStatus");
        }
      } else {
        setState(() {
          _paymentStatus = "error";
        });
      }
    } catch (e) {
      setState(() {
        _paymentStatus = "error";
      });
    } finally {
      setState(() {
        _isLoadingStatus = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'settlement':
      case 'capture':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancel':
      case 'deny':
      case 'expire':
        return Colors.red;
      case 'error':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'settlement':
        return "Pembayaran Berhasil";
      case 'pending':
        return "Menunggu Pembayaran";
      case 'cancel':
        return "Pembayaran Dibatalkan";
      case 'expire':
        return "Pembayaran Kadaluwarsa";
      case 'deny':
        return "Pembayaran Ditolak";
      case 'capture':
        return "Pembayaran Berhasil (Capture)";
      case 'error':
        return "Metode pembayaran belum dipilih!";
      default:
        return "Status: $status";
    }
  }

  void _startPolling() {
    _statusPollingTimer?.cancel();
    _statusPollingTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchPaymentStatus();
    });
  }

  @override
  void initState() {
    super.initState();

    _currentSnapUrl = widget.snapUrl;
    _currentOrderId = widget.orderId;
    print(
        "ID Draft: ${widget.idDraft}, Order ID: ${widget.orderId}, Snap URL: ${widget.snapUrl}");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("transaction-success")) {
              _handlePaymentSuccess();
              return NavigationDecision.prevent;
            }
            if (request.url.contains("transaction-failed")) {
              _handlePaymentFailure();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_currentSnapUrl));

    _statusPollingTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchPaymentStatus();
    });
  }

  @override
  void dispose() {
    _statusPollingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: AppBar(
        title: Text(
          _paymentStatus == 'settlement'
              ? 'Pembayaran Berhasil'
              : _paymentStatus == 'expire'
                  ? 'Waktu Pembayaran Habis'
                  : (_paymentStatus == 'deny' ||
                          _paymentStatus == 'cancel' ||
                          _paymentStatus == 'failure')
                      ? 'Pembayaran Gagal'
                      : 'Pembayaran',
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            color: Color(0xFF705D54),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFD7CCC8),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF826754)),
        leading: _paymentStatus == 'settlement'
            ? null
            : IconButton(
                icon: Iconify(MaterialSymbols.arrow_back,
                    color: Color(0xFF826754)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientProjects(),
                    ),
                  );
                },
              ),
      ),
      body: _paymentStatus == 'settlement'
          ? _buildConfirmationScreen()
          : _paymentStatus == 'expire'
              ? _buildConfirmationFailed()
              : _paymentStatus == 'deny' ||
                      _paymentStatus == 'cancel' ||
                      _paymentStatus == 'failure'
                  ? _buildConfirmationTimeout()
                  : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _getStatusColor(_paymentStatus),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        _getStatusLabel(_paymentStatus),
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: _isLoadingStatus
                                    ? null
                                    : _fetchPaymentStatus,
                                icon: _isLoadingStatus
                                    ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : Icon(Icons.refresh,
                                        color: Colors.black54),
                                tooltip: "Perbarui status",
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: WebViewWidget(controller: _controller)),
                      ],
                    ),
      bottomNavigationBar: _paymentStatus == 'settlement'
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Color(0xFF826754),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _paymentStatus == 'settlement'
                          ? null
                          : _paymentStatus == 'expire'
                              ? null
                              : _launchWhatsApp(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFFEDE7E2)),
                        backgroundColor: Color(0xFFF1E9E5),
                        foregroundColor: Color(0xFF826754),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _paymentStatus == 'settlement'
                            ? "Lihat Proyek"
                            : _paymentStatus == 'expire'
                                ? "Coba Lagi"
                                : "Chat Bantuan",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF826754)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : _paymentStatus == 'expire'
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Color(0xFF826754),
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
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Chat Bantuan",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _getNewSnapUrlAndReload(widget.idDraft);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFEDE7E2)),
                            backgroundColor: Color(0xFFF1E9E5),
                            foregroundColor: Color(0xFF826754),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Coba Lagi",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF826754))),
                        ),
                      ),
                    ],
                  ),
                )
              : _paymentStatus == 'deny' ||
                      _paymentStatus == 'cancel' ||
                      _paymentStatus == 'failure'
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: Color(0xFF826754),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _launchWhatsApp,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xFFEDE7E2)),
                                backgroundColor: Color(0xFFF1E9E5),
                                foregroundColor: Color(0xFF826754),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("Chat Bantuan",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF826754))),
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
    );
  }

  Widget _buildConfirmationScreen() {
    return Center(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationFailed() {
    return Center(
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Mohon periksa histori transaksi di aplikasi m-banking atau e-wallet Anda, jika tertera berhasil, silakan chat kami untuk mengirimkan bukti.',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  color: Color(0xFFA3948D),
                  height: 1.1,
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildConfirmationTimeout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Iconify(
            Majesticons.emoji_sad,
            color: Color(0xFFFF9800),
            size: 128,
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Maaf, Pembayaran Terkendala',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF705D54),
                height: 1.1,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Mohon periksa histori transaksi di aplikasi m-banking atau e-wallet Anda, jika tertera berhasil, silakan chat kami untuk mengirimkan bukti.',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  color: Color(0xFFA3948D),
                  height: 1.1,
                ),
              ))
        ],
      ),
    );
  }

  void _handlePaymentSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Transaksi Anda telah selesai."),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void _handlePaymentFailure() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Silakan coba lagi."),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pushReplacementNamed(context, "/transactionReview");
  }
}
