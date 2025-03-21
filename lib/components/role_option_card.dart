import 'package:flutter/material.dart';

class RoleOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback onTap;

  const RoleOptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
    this.backgroundColor = const Color(0xFFD7CCC8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
        ),
        child: ListTile(
          leading: Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF705D54),
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3A2B24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
