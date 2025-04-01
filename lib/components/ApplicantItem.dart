import 'package:flutter/material.dart';

class ApplicantItem extends StatelessWidget {
  final String nama;
  final String avatarImagePath;
  final String pesan;
  final String persentaseLike;
  final VoidCallback onTapDetail;
  final VoidCallback onTapRekrut;

  const ApplicantItem({
    Key? key,
    required this.nama,
    required this.avatarImagePath,
    required this.pesan,
    required this.persentaseLike,
    required this.onTapDetail,
    required this.onTapRekrut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: avatarImagePath.startsWith('http')
                  ? NetworkImage(avatarImagePath)
                  : AssetImage(avatarImagePath) as ImageProvider,
            ),
            Positioned(
              bottom: -3,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 45,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Color(0xFFD7CCC8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF826754),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Color(0xFF826754),
                        size: 8,
                      ),
                      SizedBox(width: 2),
                      Text(
                        persentaseLike,
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF826754),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF705D54),
                  ),
                ),
                SizedBox(height: 3),
                Text.rich(
                  TextSpan(
                    children: [
                      // TextSpan(
                      //   text: "Anda",
                      //   style: TextStyle(
                      //     fontFamily: 'NunitoSans',
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.bold,
                      //     color: Color(0xFFA3948D),
                      //   ),
                      // ),
                      // TextSpan(
                      //   text: " : $pesan",
                      //   style: TextStyle(
                      //     fontFamily: 'NunitoSans',
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w400,
                      //     color: Color(0xFFA3948D),
                      //   ),
                      // ),
                      TextSpan(
                        text: "Belum ada percakapan.",
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA3948D),
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFF826754),
              width: 1,
            ),
          ),
          child: Icon(Icons.task, color: Color(0xFF826754)),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: onTapRekrut,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF826754),
            ),
            child: Icon(Icons.arrow_forward_rounded, color: Color(0xFFF1E9E5)),
          ),
        ),
      ],
    );
  }
}
