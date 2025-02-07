import 'package:flutter/material.dart';

class ClientSignUp extends StatefulWidget {
  const ClientSignUp({Key? key}) : super(key: key);

  @override
  State<ClientSignUp> createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {
  // Buat controller untuk setiap TextField
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  int nomortext = 0;

  void _validateFields() {
    setState(() {
      // Periksa apakah semua TextField sudah terisi
      bool allFilled = _controller1.text.isNotEmpty &&
          _controller2.text.isNotEmpty &&
          _controller3.text.isNotEmpty &&
          _controller4.text.isNotEmpty &&
          _controller5.text.isNotEmpty;

      nomortext = allFilled ? 1 : 0;
    });
  }

  @override
  void dispose() {
    // Bersihkan semua controller
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Client Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField pertama
            TextField(
              controller: _controller1,
              onChanged: (value) => _validateFields(),
              decoration: InputDecoration(
                hintText: 'Laki-laki',
                hintStyle: TextStyle(
                  color: Color(0xFFB0B0B0),
                  fontSize: 16,
                  fontFamily: 'NunitoSans',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
            // TextField kedua
            TextField(
              controller: _controller2,
              onChanged: (value) => _validateFields(),
              decoration: InputDecoration(
                hintText: 'Perempuan',
                hintStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontFamily: 'NunitoSans',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
            // TextField ketiga
            TextField(
              controller: _controller3,
              onChanged: (value) => _validateFields(),
              decoration: InputDecoration(
                hintText: 'Usia',
                hintStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontFamily: 'NunitoSans',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
            // TextField keempat
            TextField(
              controller: _controller4,
              onChanged: (value) => _validateFields(),
              decoration: InputDecoration(
                hintText: 'Alamat',
                hintStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontFamily: 'NunitoSans',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
            // TextField kelima
            TextField(
              controller: _controller5,
              onChanged: (value) => _validateFields(),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.purple,
                  fontSize: 16,
                  fontFamily: 'NunitoSans',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nomortext: $nomortext',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
