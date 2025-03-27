import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:surveyscout/pages/surveyor/surveyormyprojects.dart';
import 'package:surveyscout/pages/surveyor/surveyorchat.dart';
import 'package:surveyscout/pages/surveyor/surveyorakun.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';

class SurveyorPages extends StatefulWidget {
  @override
  _SurveyorPagesState createState() => _SurveyorPagesState();
}

class _SurveyorPagesState extends State<SurveyorPages> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    SurveyorProjects(),
    SurveyorMyProjects(),
    SurveyorChat(),
    SurveyorAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Color(0xffD7CCC8),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                outlineIcon: Ri.search_line,
                filledIcon: Ri.search_fill,
                label: 'Tersedia',
                index: 0,
              ),
              _buildNavItem(
                outlineIcon: Ic.outline_work_history,
                filledIcon: Ic.round_work_history,
                label: 'Proyek Saya',
                index: 1,
                width: 100,
                height: 80,
              ),
              _buildNavItem(
                outlineIcon: MaterialSymbols.chat_outline,
                filledIcon: MaterialSymbols.chat_bubble,
                label: 'Chat',
                index: 2,
              ),
              _buildNavItem(
                outlineIcon: Ion.person_circle_outline,
                filledIcon: Ion.person_circle,
                label: 'Akun',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String outlineIcon,
    required String filledIcon,
    required String label,
    required int index,
    double width = 60,
    double height = 60,
  }) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Iconify(
              isSelected ? filledIcon : outlineIcon,
              size: 24,
              color: isSelected ? Color(0xFF705D54) : Color(0xFFB8ADA5),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'NunitoSans',
                color: isSelected ? Color(0xFF705D54) : Color(0xFFB8ADA5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
