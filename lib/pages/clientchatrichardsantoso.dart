import 'package:flutter/material.dart';
import '../chatwidget/chat_bubble.dart';
import '../chatwidget/input_bar.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [
    {"text": "Halo!", "isMe": false},
    {"text": "Hai, ada yang bisa saya bantu?", "isMe": true},
    {"text": "Bisa kirim dokumen?", "isMe": false},
  ];

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        messages.add({"text": text, "isMe": true});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD7CCC8), // Warna AppBar
        leading: Padding(
          padding: EdgeInsets.only(left: 27), // Padding kiri 27 untuk ikon panah
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF826754)), // Ikon panah kiri
            onPressed: () {
              Navigator.pop(context); // Fungsi kembali
            },
          ),
        ),
        title: Padding(
          padding: EdgeInsets.all(27), // Padding 27 untuk seluruh sisi
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/richardsantoso2.png'), // Gambar profil
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Richard Santoso", // Nama kontak
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF705D54)),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.lock_clock, // Ganti dengan ikon yang sesuai
                        color: Colors.black54, // Warna ikon sama dengan teks
                        size: 16, // Sesuaikan ukuran ikon agar proporsional
                      ),
                      SizedBox(width: 8), // Spasi antara ikon dan teks
                      Text(
                        "Kepuasan Pengguna Transportasi Umum di Jakarta", // Teks
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

      ),


      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: messages[index]['text'],
                  isMe: messages[index]['isMe'],
                );
              },
            ),
          ),
          InputBar(onSendMessage: _sendMessage), // Bagian input pesan
        ],
      ),
    );
  }
}
