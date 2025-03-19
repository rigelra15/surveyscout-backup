import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:surveyscout/pages/client/respondent_survey_details.dart';
import 'package:surveyscout/pages/client/surveyor_project_details_screen.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class ChooseRecruitmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EEE9),
      appBar: AppBar(
        title: Text('Scouting Talent',
            style: GoogleFonts.nunitoSans(
                fontSize: 16,
                color: Color(0xFF705D54),
                fontWeight: FontWeight.bold)),
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
            //Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress bar with full width and 16dp spacing
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.0), // Add 16dp spacing below progress bar
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF826754),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Title "Langkah 1"
                Text(
                  'Langkah 1',
                  style: TextStyle(
                    color: Color(0xFF705D54),
                    fontSize: 24,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Text(
              'Siapa yang Anda butuhkan dalam proyek ini?',
              style: GoogleFonts.nunitoSans(
                color: Color(0xFFA3948D),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            _buildCard(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurveyorProjectDetailsScreen(),
                  ),
                );
              },
              icon: FluentIcons.person_note_24_filled,
              title: 'Surveyor',
              description:
                  'Membantu mencari data melalui observasi, wawancara, dan/atau metode lainnya hingga merekapnya.',
            ),
            SizedBox(height: 16),
            _buildCard(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RespondentSurveyDetailsScreen(),
                  ),
                );
              },
              icon: FluentIcons.person_chat_24_filled,
              title: 'Responden',
              description:
                  'Menjadi narasumber proyek Anda. Adapun, perekapan dilakukan secara mandiri.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onPressed, // Add this line
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFFF0E8E4),
      elevation: 0,
      child: InkWell(
        // Wrap with InkWell
        onTap: onPressed, // Add this line
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon, // Fluent UI Icon
                color: Color(0xFF705D54),
                size: 40, // Adjust size if needed
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF705D54),
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        color: Color(0xFFA3948D),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
