// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String orderId;
  final String title;
  final String timeAgo;
  final String fileType;
  final String status;
  final bool showRating;
  final VoidCallback? onDownload;
  final VoidCallback? onChat;
  final VoidCallback? onWork;
  final VoidCallback? onMore;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;
  final int? chatCount;

  const ProjectCard({
    Key? key,
    required this.orderId,
    required this.title,
    required this.timeAgo,
    required this.fileType,
    required this.status,
    this.showRating = false,
    this.onDownload,
    this.onMore,
    this.onChat,
    this.onWork,
    this.onEdit,
    this.onTap,
    this.chatCount,
  }) : super(key: key);

  String getStatusText(String status) {
    switch (status) {
      case 'selesai':
        return 'Selesai';
      case 'ditinjau':
        return 'Butuh Tinjau';
      case 'dikerjakan':
        return 'Dikerjakan';
      case 'draft':
        return 'Draft';
      case 'pembayaran':
        return 'Tunggu Bayar';
      case 'kadaluwarsa':
        return 'Kadaluwarsa';
      default:
        return 'Draft';
    }
  }

  Color getColorByStatus(String status) {
    switch (status) {
      case 'selesai':
        return Colors.green;
      case 'ditinjau':
        return Color(0xFFFFC107);
      case 'dikerjakan':
        return Color(0xFFFF9800);
      case 'draft':
        return Color(0xFF2196F3);
      case 'pembayaran':
        return Color(0xFF000080);
      case 'kadaluwarsa':
        return Color(0xFF9E9E9E);
      default:
        return Colors.transparent;
    }
  }

  Iconify getIconByStatus(String status) {
    switch (status) {
      case 'selesai':
        return const Iconify(Ic.outline_check, color: Colors.white, size: 16);
      case 'ditinjau':
        return const Iconify(Ph.circle_dashed, color: Colors.white, size: 16);
      case 'dikerjakan':
        return const Iconify(Ic.twotone_work_history,
            color: Colors.white, size: 16);
      case 'draft':
        return const Iconify(Ic.round_insert_drive_file,
            color: Colors.white, size: 16);
      case 'pembayaran':
        return const Iconify(MaterialSymbols.payments_rounded,
            color: Colors.white, size: 16);
      case 'kadaluwarsa':
        return const Iconify(Mdi.clock_alert, color: Colors.white, size: 16);
      default:
        return const Iconify(Ic.outline_check, color: Colors.white, size: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status == 'peringatan') {
      return GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF44336),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEDE7E2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF705D54),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/duaharilalu.png',
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      timeAgo,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'NunitoSans',
                                        color: Color(0xFFF44336),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                if (orderId.startsWith("SURVEY"))
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/pdfexcel.png',
                                        height: 24,
                                        width: 24,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          fileType,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'NunitoSans',
                                            color: Color(0xFFA3948D),
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF44336),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 47 * 2) *
                                          (2 / 5) -
                                      4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tenggat pengerjaan",
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "terlewat chat surveyor atau tindaklanjuti.",
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: onTap,
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 47 * 2) *
                                            (1.5 / 5) -
                                        4,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEDE7E2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/chat.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    Text(
                                      "Chat",
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF3A2B24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 47 * 2) *
                                          (1.5 / 5) -
                                      4,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFF44336),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFEDE7E2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/aksi.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  Text(
                                    "Aksi",
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFEDE7E2),
                                    ),
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
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/gradienmerah.png',
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF44336),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.zero,
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/peringatan.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Peringatan",
                          style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ));
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: showRating && orderId.startsWith("SURVEY") || status == 'ditinjau'
              ? const Color(0xFF826754)
              : Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7E2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'SourceSans3',
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF705D54),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (status == 'merekrut')
                        Container(
                          width: (MediaQuery.of(context).size.width - 27 * 2) *
                                  (1 / 3) -
                              4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width -
                                            27 * 2) *
                                        (1 / 3) -
                                    4,
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: List.generate(4, (index) {
                                      List<Color> colors = [
                                        Color(0x1F625B71),
                                        Color(0xFFF44336),
                                        Color(0xFF2196F3),
                                        Color(0xFFFFEB3B),
                                      ];
                                      return Positioned(
                                        right: (index == 0)
                                            ? 0.0
                                            : (index == 1)
                                                ? 29.0
                                                : (index == 2)
                                                    ? 39.0
                                                    : 49.0,
                                        top: 0,
                                        child: index == 0
                                            ? Container(
                                                width: 80,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  color: colors[index],
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: Text(
                                                      "+20",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'NunitoSans',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xFF826754),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x66000000),
                                                      offset: Offset(4, 0),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      colors[index],
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      index == 1
                                                          ? 'assets/images/surveyscout1.png'
                                                          : index == 2
                                                              ? 'assets/images/surveyscout1.png'
                                                              : index == 3
                                                                  ? 'assets/images/surveyscout1.png'
                                                                  : '',
                                                      width: 44,
                                                      height: 44,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: (MediaQuery.of(context).size.width -
                                            27 * 2) *
                                        (1 / 3) -
                                    4,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Lowongan dibuka",
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF3A2B24),
                                        ),
                                        overflow: TextOverflow.visible,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (status != 'merekrut')
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: getColorByStatus(status),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              getIconByStatus(status),
                              const SizedBox(width: 4),
                              Text(
                                getStatusText(status),
                                style: const TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/2bulanlagi.png',
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                timeAgo,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'NunitoSans',
                                  color: Color(0xFFA3948D),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (orderId.startsWith("SURVEY"))
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/pdfexcel.png',
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  fileType,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'NunitoSans',
                                    color: Color(0xFFA3948D),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          if (onDownload != null) ...[
                            _buildCircleButton(Ic.round_download, onDownload),
                            const SizedBox(width: 8),
                          ],
                          if (onChat != null) ...[
                            _buildCircleButton(Ic.round_chat, onChat,
                                showDot: status == 'ditinjau' ||
                                    status == 'dikerjakan',
                                count: chatCount),
                            const SizedBox(width: 8),
                          ],
                          if (onWork != null) ...[
                            _buildCircleButton(Ic.outline_work, onWork),
                            const SizedBox(width: 8),
                          ],
                          if (status == 'draft' ||
                              status == 'pembayaran' && onMore != null) ...[
                            _buildCircleButton(Mdi.pencil, onEdit),
                            const SizedBox(width: 8),
                          ],
                          _buildCircleButton(Mdi.dots_vertical, onTap),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (status == 'ditinjau') ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        'Konfirmasi',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'Nunito Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 14.4 / 12,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Color(0xFFFFFFFF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'luaran atau ajukan revisi dalam 3 hari ke depan',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'Nunito Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 14.4 / 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (showRating && orderId.startsWith("SURVEY")) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text(
                      'Berikan penilaian terhadap surveyor',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.star_border_rounded,
                            size: 30,
                            color: Color(0xFFD7CCC8),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton(String icon, VoidCallback? onPressed,
      {bool showDot = false, int? count}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 42.2,
            height: 42.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF826754), width: 1),
            ),
            child: Center(
              child: Iconify(
                icon,
                size: 21,
                color: const Color(0xFF826754),
              ),
            ),
          ),
        ),
        if (count != null && count > 0 && showDot)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 13,
              height: 13,
              decoration: const BoxDecoration(
                color: Color(0xFFB3261E),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
