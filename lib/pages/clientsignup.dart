import 'package:flutter/material.dart';

class ClientSignUp extends StatelessWidget {
  const ClientSignUp({Key? key}) : super(key: key);

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

            ],
          ),
        ),
      ),
    );
  }
}
