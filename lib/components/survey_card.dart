import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SurveyCard extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final int deadlineDays;
  final String location;
  final String reward;
  final VoidCallback? onBookmarkToggle;
  final bool isBookmarked;
  final VoidCallback? onTap;

  const SurveyCard({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.deadlineDays,
    required this.location,
    required this.reward,
    this.onBookmarkToggle,
    this.isBookmarked = false,
    this.onTap,
  }) : super(key: key);

  @override
  _SurveyCardState createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isBookmarked;
  }

  String formatDeadlineText(int days) {
    bool isPast = days < 0;
    int absDays = days.abs();
    int weeks = (absDays / 7).floor();
    int months = (absDays / 30).floor();
    int years = (absDays / 365).floor();

    if (years > 0) {
      return "$years tahun ${isPast ? 'lalu' : 'lagi'}";
    } else if (months > 0) {
      return "$months bulan ${isPast ? 'lalu' : 'lagi'}";
    } else if (weeks > 0) {
      return "$weeks minggu ${isPast ? 'lalu' : 'lagi'}";
    } else if (absDays > 0) {
      return "$absDays hari ${isPast ? 'lalu' : 'lagi'}";
    } else {
      return isPast ? "Sudah lewat" : "Hari ini";
    }
  }

  Color _getDeadlineColor(int days) {
    if (days < 0 || days <= 10) {
      return Color(0xFFF44336);
    }
    return Color(0xFFA3948D);
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

  @override
  Widget build(BuildContext context) {
    String deadlineText = formatDeadlineText(widget.deadlineDays);
    String formattedReward = formatCurrency(widget.reward);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEDE7E2),
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF705D54),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SourceSans3",
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSaved = !_isSaved;
                    });
                    if (widget.onBookmarkToggle != null) {
                      widget.onBookmarkToggle!();
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 60,
                    child: Center(
                      child: Icon(
                        _isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Color(0xFF705D54),
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 50,
                  height: 60,
                  child: Center(
                    child: Image.asset(
                      'assets/images/titik32.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFFA3948D),
                  fontSize: 12,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: _buildInfoTag(
                          deadlineText,
                          'assets/images/2bulanlagi2.png',
                          _getDeadlineColor(widget.deadlineDays))),
                  SizedBox(width: 8),
                  Expanded(
                      child: _buildInfoTag(widget.location,
                          'assets/images/semarang.png', Color(0xFFA3948D))),
                  SizedBox(width: 8),
                  Expanded(
                      child: _buildInfoTag(formattedReward,
                          'assets/images/limaratus.png', Color(0xFF4A7C59))),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }

  Widget _buildInfoTag(String text, String iconPath, Color color) {
    return Container(
      height: 35,
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "NunitoSans",
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
