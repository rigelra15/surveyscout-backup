Padding(
padding: EdgeInsets.symmetric(horizontal: 27),
child: Column(
children: [
Expanded(
child: SingleChildScrollView(
child: Column(
children: [
SizedBox(height: 10),


// Container kanan
Container(
width: (MediaQuery.of(context).size.width - 27 * 2) * (1/3) - 4,
decoration: BoxDecoration(
//color: Color(0xFFF44336),
borderRadius: BorderRadius.circular(8),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.end,
children: [
Container(
padding: EdgeInsets.all(8), // Menambahkan padding untuk teks di dalam kontainer
decoration: BoxDecoration(
color: Color(0xFF4CAF50), // Warna background #FF9800
borderRadius: BorderRadius.circular(16), // Border radius 16
),
child: Wrap(
alignment: WrapAlignment.start, // Menyusun elemen dari kiri
spacing: 8, // Jarak horizontal antara gambar dan teks
runSpacing: 4, // Jarak antar baris
children: [
// Gambar di sisi kiri
Image.asset(
'assets/images/selesai2.png', // Gambar yang ingin ditampilkan
width: 15, // Ukuran gambar, sesuaikan dengan kebutuhan
height: 15,
),

// Teks di sisi kanan
Text(
"Selesai",
style: TextStyle(
fontFamily: 'NunitoSans',
fontSize: 10,
fontWeight: FontWeight.w400,
color: Color(0xFFFFFFFF), // Warna teks putih (#FFFFFF)
),
),
],
),
),

SizedBox(height: 100),


Container(
width: (MediaQuery.of(context).size.width - 27 * 2) * (1 / 2) - 4,
padding: EdgeInsets.all(0), // Padding diatur menjadi 0
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.end, // Posisi rata kanan
children: [
// Lingkaran pertama
Stack(
alignment: Alignment.center, // Menjaga elemen di tengah
children: [
// Lingkaran utama
Container(
width: 42.2, // Diameter lingkaran utama
height: 42.2,
decoration: BoxDecoration(
shape: BoxShape.circle,
border: Border.all(
color: Color(0xFF826754), // Warna border
width: 1, // Ketebalan border
),
),
child: Center(
child: Image.asset(
'assets/images/download.png',
width: 21, // Ukuran gambar dalam lingkaran utama
height: 21,
fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
),
),
),

],
),
SizedBox(width: 8), // Gap antar lingkaran
// Lingkaran kedua
Container(
width: 42.2, // Diameter lingkaran
height: 42.2,
decoration: BoxDecoration(
shape: BoxShape.circle,
border: Border.all(
color: Color(0xFF826754), // Warna border
width: 1, // Ketebalan border 1px
),
),
child: Center(
child: Image.asset(
'assets/images/titik3.png',
width: 21, // Ukuran gambar dalam lingkaran (sesuaikan jika perlu)
height: 21,
fit: BoxFit.contain, // Mengatur agar gambar tidak terpotong
),
),
),
],
),
),
],
),
),
],
),
),


SizedBox(height: 80),


],
),
),
),
],
),
Positioned(
top: 0,
right: 0,
child: Container(
width: 120,
height: 40,
decoration: BoxDecoration(
color: Color(0xFFF44336),
borderRadius: BorderRadius.only(
bottomLeft: Radius.circular(20), // Kiri bawah dengan radius 20
bottomRight: Radius.zero,        // Kanan bawah tanpa radius
topLeft: Radius.zero,            // Kiri atas tanpa radius
topRight: Radius.zero,           // Kanan atas tanpa radius
),
),
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 10), // Padding kanan dan kiri sebanyak 5
child: Row(
mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran Row sesuai kontennya
children: [
Image.asset(
'assets/images/peringatan.png', // Path ke file gambar
width: 16, // Sesuaikan ukuran gambar
height: 16, // Sesuaikan ukuran gambar
),
const SizedBox(width: 8), // Jarak antara gambar dan teks
Text(
"Peringatan",
style: TextStyle(
fontFamily: 'NunitoSans', // Mengatur font-family
fontSize: 12, // Ukuran font 12px
fontWeight: FontWeight.w400, // Berat font 400 (normal)
color: Colors.white, // Warna teks putih
),
),
],
),
),
),

),
),