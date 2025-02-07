import 'package:flutter/material.dart';

class ClientSignUp extends StatefulWidget {
  const ClientSignUp({Key? key}) : super(key: key);

  @override
  State<ClientSignUp> createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {
  bool _isObscured = true;

  final int nomorselesai = 12;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5),
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Selangkah Lagi!',
                          style: TextStyle(
                            color: Color(0xFF705D54),
                            fontSize: 32,
                            fontFamily: 'SourceSans3',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mohon isi data diri berikut',
                          style: TextStyle(
                            color: Color(0xFFA3948D),
                            fontSize: 16,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              //NAMA LENGKAP############################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/namalengkap.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 250, // Tentukan lebar maksimum untuk kolom teks
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'Nama Lengkap',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                    fontStyle: FontStyle.italic, // Gaya italic
                                    fontWeight: FontWeight.w400, // Bobot reguler
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                  isDense: true, // Mengurangi padding vertikal
                                  border: InputBorder.none, // Menghilangkan garis bawah
                                ),
                                // Pastikan TextField mengisi lebar Container
                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //JENIS KELAMIN########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/jeniskelamin.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 250, // Tentukan lebar maksimum untuk kolom teks
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'Jenis Kelamin',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Laki-laki',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                    fontStyle: FontStyle.italic, // Gaya italic
                                    fontWeight: FontWeight.w400, // Bobot reguler
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                  isDense: true, // Mengurangi padding vertikal
                                  border: InputBorder.none, // Menghilangkan garis bawah
                                ),
                                // Pastikan TextField mengisi lebar Container
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //TANGGAL LAHIR########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/tanggallahir.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 250, // Tentukan lebar maksimum untuk kolom teks
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'Tanggal Lahir',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '1 Januari 1990',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                    fontStyle: FontStyle.italic, // Gaya italic
                                    fontWeight: FontWeight.w400, // Bobot reguler
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                  isDense: true, // Mengurangi padding vertikal
                                  border: InputBorder.none, // Menghilangkan garis bawah
                                ),
                                // Pastikan TextField mengisi lebar Container
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //NOMOR TELEPON########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/nomortelepon.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 250, // Tentukan lebar maksimum untuk kolom teks
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'Nomor Telepon',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '081 234 567 890',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                    fontStyle: FontStyle.italic, // Gaya italic
                                    fontWeight: FontWeight.w400, // Bobot reguler
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                  isDense: true, // Mengurangi padding vertikal
                                  border: InputBorder.none, // Menghilangkan garis bawah
                                ),
                                // Pastikan TextField mengisi lebar Container
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //NIK########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/nik.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 250, // Tentukan lebar maksimum untuk kolom teks
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'NIK',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '3403130101901001',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                    fontStyle: FontStyle.italic, // Gaya italic
                                    fontWeight: FontWeight.w400, // Bobot reguler
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                  isDense: true, // Mengurangi padding vertikal
                                  border: InputBorder.none, // Menghilangkan garis bawah
                                ),
                                // Pastikan TextField mengisi lebar Container
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //BANK########################################################################
              Container(
                width: double.infinity, // Lebar penuh untuk kontainer besar


                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Rata atas kedua kontainer
                  children: [
                    // Kontainer kiri (kontainer lama)
                    Expanded(
                      flex: 3, // Fleksibilitas untuk menyesuaikan lebar relatif
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 54 - 50) / 2,


                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri untuk isi kolom
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Align(
                                    alignment: Alignment.center, // Posisi gambar di tengah
                                    child: Image(
                                      image: AssetImage('assets/images/namabank.png'),
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 54 - 100) / 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                                      children: [
                                        Text(
                                          'Nama Bank',
                                          style: TextStyle(
                                            color: Color(0xFF705D54),
                                            fontSize: 16,
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Container(
                                          width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Bank Saya',
                                              hintStyle: TextStyle(
                                                color: Color(0xFFB0B0B0),
                                                fontSize: 16,
                                                fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                                fontStyle: FontStyle.italic, // Gaya italic
                                                fontWeight: FontWeight.w400, // Bobot reguler
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                              isDense: true, // Mengurangi padding vertikal
                                              border: InputBorder.none, // Menghilangkan garis bawah
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity, // Lebar mengikuti lebar layar
                              height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                              color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16), // Jarak antara kontainer kiri dan kanan
                    // Kontainer kanan
                    Expanded(
                      flex: 3, // Fleksibilitas untuk menyesuaikan lebar relatif
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 54 - 50) / 2,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri untuk isi kolom
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width - 54 - 50) / 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                                      children: [
                                        Text(
                                          'Nomor Rekening',
                                          style: TextStyle(
                                            color: Color(0xFF705D54),
                                            fontSize: 16,
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Container(
                                          width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: '1234567890',
                                              hintStyle: TextStyle(
                                                color: Color(0xFFB0B0B0),
                                                fontSize: 16,
                                                fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                                fontStyle: FontStyle.italic, // Gaya italic
                                                fontWeight: FontWeight.w400, // Bobot reguler
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                              isDense: true, // Mengurangi padding vertikal
                                              border: InputBorder.none, // Menghilangkan garis bawah
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity, // Lebar mengikuti lebar layar
                              height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                              color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              //Nama Perusahaan########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/namaperusahaan.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 250, // Tentukan lebar maksimum untuk kolom teks
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'Nama Perusahaan',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'PT Maju Mapan',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                    fontStyle: FontStyle.italic, // Gaya italic
                                    fontWeight: FontWeight.w400, // Bobot reguler
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                  isDense: true, // Mengurangi padding vertikal
                                  border: InputBorder.none, // Menghilangkan garis bawah
                                ),
                                // Pastikan TextField mengisi lebar Container
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //Jenis Perusahaan########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/jenisperusahaan.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 250, // Tentukan lebar maksimum untuk kolom teks
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'Jenis Perusahaan',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: (MediaQuery.of(context).size.width) * 9 / 10, // Lebar sesuai dengan yang diinginkan
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Swasta',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B0B0),
                                    fontSize: 16,
                                    fontFamily: 'NunitoSans', // Pastikan font sudah ditambahkan
                                    fontStyle: FontStyle.italic, // Gaya italic
                                    fontWeight: FontWeight.w400, // Bobot reguler
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Sesuaikan padding
                                  isDense: true, // Mengurangi padding vertikal
                                  border: InputBorder.none, // Menghilangkan garis bawah
                                ),
                                // Pastikan TextField mengisi lebar Container
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //Pin Akses1########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/pinakses.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'PIN Akses',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7, // Batasi lebar Row
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 9, // Memberikan lebih banyak ruang pada TextField
                                    child: TextField(
                                      obscureText: _isObscured, // Kontrol apakah teks disembunyikan
                                      decoration: InputDecoration(
                                        hintText: '6 digit, hanya angka',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 16,
                                          fontFamily: 'NunitoSans',
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _isObscured ? Icons.visibility_off : Icons.visibility,
                                      color: Color(0xFF705D54),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured; // Ubah status visibilitas teks
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              //Pin Akses2########################################################################
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center, // Posisi gambar di tengah
                        child: Image(
                          image: AssetImage('assets/images/pinakses.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover, // Gambar menyesuaikan dengan ukuran yang ditentukan
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                          children: [
                            Text(
                              'Konfirmasi Pin Akses',
                              style: TextStyle(
                                color: Color(0xFF705D54),
                                fontSize: 16,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7, // Batasi lebar Row
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 9, // Memberikan lebih banyak ruang pada TextField
                                    child: TextField(
                                      obscureText: _isObscured, // Kontrol apakah teks disembunyikan
                                      decoration: InputDecoration(
                                        hintText: 'Masukkan kembali PIN Akses',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 16,
                                          fontFamily: 'NunitoSans',
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _isObscured ? Icons.visibility_off : Icons.visibility,
                                      color: Color(0xFF705D54),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured; // Ubah status visibilitas teks
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity, // Lebar mengikuti lebar layar
                height: 1, // Tinggi garis (dapat disesuaikan sesuai kebutuhan)
                color: Color(0xFF705D54), // Warna garis sesuai dengan yang diinginkan
              ),
              SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD7CCC8),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all( // Menambahkan border
                    color: Color(0xFF826754), // Warna border
                    width: 1.5, // Ketebalan border
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon di kiri
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Image.asset(
                        'assets/images/hurufi.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    // Teks di kanan
                    Expanded(
                      child: Text(
                        "PIN Akses digunakan untuk memverifikasi bahwa memang Anda yang akan mengubah informasi penting seperti rekening atau mengakses data rahasia.",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF705D54),
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: nomorselesai < 12 ? Color(0xFFC4B8B1) : Color(0xFF826754),
              padding: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Border radius 8
              ),
            ),
            onPressed: () {
              // Tambahkan aksi untuk tombol di sini
            },
            child: Container(
              width: double.infinity, // Lebar tombol penuh
              alignment: Alignment.center, // Tulisan di tengah
              child: Text(
                "Lanjut",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'NunitoSans',
                  color: nomorselesai < 12 ? Color(0xFFD7CCC8) : Color(0xFFF1E9E5),
                ),
              ),
            ),
          ),


          ],
          ),
        ),
      ),
    );
  }
}
