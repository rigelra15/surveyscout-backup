import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  const CustomContainer({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SourceSans3',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Color(0xFF705D54),
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFFA3948D),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIndicator(Color(0xFF826754), Color(0xFFC4B8B1)),
              SizedBox(width: 5),
              _buildIndicator(Color(0xFFC4B8B1), Color(0xFFC4B8B1)),
              SizedBox(width: 5),
              _buildIndicator(Color(0xFFC4B8B1), Color(0xFF826754)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(Color firstColor, Color secondColor) {
    return Container(
      width: 30,
      height: 10,
      decoration: BoxDecoration(
        color: firstColor,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
    );
  }
}