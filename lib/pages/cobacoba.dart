import 'package:flutter/material.dart';


class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}


class _SecondPageState extends State<SecondPage> {
  // Variabel untuk menyimpan pilihan dropdown
  String selectedStatus = "Semua status";
  String selectedPeran = "Semua peran";
  String selectedLokasi = "Semua lokasi";
  String selectedKomisi = "Semua komisi";
  // Data dummy untuk 7 kontainer
  final List<Map<String, dynamic>> containerData = [
    {
      "type": "A",
      "title": "Container A1",
      "images": ["assets/images/selesai2.png", "assets/images/selesai2.png"],
      "texts": ["Tulisan A1", "Tulisan A2"]
    },
    {
      "type": "B",
      "title": "Container B1",
      "images": ["assets/images/selesai2.png"],
      "texts": ["Tulisan B1"]
    },
    {
      "type": "A",
      "title": "Container A2",
      "images": ["assets/images/selesai2.png", "assets/images/selesai2.png", "assets/images/selesai2.png"],
      "texts": ["Tulisan A3", "Tulisan A4", "Tulisan A5"]
    },
    {
      "type": "B",
      "title": "Container B2",
      "images": ["assets/images/selesai2.png"],
      "texts": ["Tulisan B2"]
    },
    {
      "type": "A",
      "title": "Container A3",
      "images": ["assets/images/selesai2.png", "assets/images/selesai2.png"],
      "texts": ["Tulisan A6", "Tulisan A7"]
    },
    {
      "type": "B",
      "title": "Container B3",
      "images": ["assets/images/selesai2.png"],
      "texts": ["Tulisan B3"]
    },
    {
      "type": "A",
      "title": "Container A4",
      "images": ["assets/images/selesai2.png"],
      "texts": ["Tulisan A8"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(165), // Tinggi AppBar diatur menjadi 130
        child: AppBar(
          backgroundColor: Color(0xFFD7CCC8), // Header berwarna #D7CCC8
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(27.0), // Padding diatur menjadi 27
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Search Bar
                Container(
                  height: 40, // Tinggi dari kotak teks
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E9E5), // Warna latar belakang
                      borderRadius: BorderRadius.circular(8), // Sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000), // Warna shadow (semi-transparent hitam)
                          offset: Offset(0, 4), // Posisi shadow (horizontal, vertikal)
                          blurRadius: 4, // Blur radius
                          spreadRadius: 0, // Radius sebaran shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari proyek Anda...", // Placeholder teks
                        filled: true,
                        fillColor: Color(0xFFF1E9E5), // Warna latar belakang
                        contentPadding: const EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // Sudut melengkung
                          borderSide: BorderSide(
                            color: Color(0xFF757575), // Warna border #757575
                            width: 0.1, // Lebar border 0.5px
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFF705D54), // Warna border tetap saat fokus
                            width: 2.0, // Lebar border saat fokus
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Color(0xFF705D54), // Warna border tetap saat tidak fokus
                            width: 1.0, // Lebar border saat tidak fokus
                          ),
                        ),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF826754)), // Ikon pencarian
                        hintStyle: TextStyle(
                          color: Color(0xFFB0B0B0), // Warna teks #B0B0B0
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w300, // Ketebalan font 300
                          fontSize: 14, // Ukuran font 14px
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 17), // Jarak antara Search Bar dan Dropdowns

                // Horizontal Scrollable Dropdowns
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildIconBox(),
                      SizedBox(width: 8), // Spasi antara kotak dan dropdown
                      _buildDropdown("Semua Status", [
                        "Semua status",
                        "Peringatan",
                        "Dikerjakan",
                        "Butuh konfirmasi",
                        "Selesai",
                        "Kadaluwarsa",
                        "Draft",
                        "Menunggu bayar"
                      ], selectedValue: selectedStatus, onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      }),
                      SizedBox(width: 8), // Spasi antar dropdown
                      _buildDropdown("Semua Peran", [
                        "Semua peran",
                        "Surveyor",
                        "Responden"
                      ], selectedValue: selectedPeran, onChanged: (value) {
                        setState(() {
                          selectedPeran = value!;
                        });
                      }),
                      SizedBox(width: 8),
                      _buildDropdown("Semua Lokasi", [
                        "Semua lokasi",
                        "Sidoarjo",
                        "Surabaya"
                      ], selectedValue: selectedLokasi, onChanged: (value) {
                        setState(() {
                          selectedLokasi = value!;
                        });
                      }),
                      SizedBox(width: 8),
                      _buildDropdown("Semua Komisi", [
                        "Semua komisi",
                        "0 - 100.000 rupiah",
                        "100.000 - 200.000 rupiah",
                        "200.000 - 500.000 rupiah",
                        "500.000 - 1.000.000 rupiah",
                        "1.000.000 - 5.000.000 rupiah",
                        "5.000.000 - 10.000.000 rupiah",
                        "10.000.000 - 20.000.000 rupiah",
                        "20.000.000 - 30.000.000 rupiah",
                        "> 30.000.000 rupiah"
                      ], selectedValue: selectedKomisi, onChanged: (value) {
                        setState(() {
                          selectedKomisi = value!;
                        });
                      }, isWide: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: ListView.builder(
          itemCount: containerData.length,
          itemBuilder: (context, index) {
            var data = containerData[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ContainerDesign(data),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memilih desain berdasarkan tipe
  Widget ContainerDesign(Map<String, dynamic> data) {
    if (data["type"] == "A") {
      return ContainerA(data);
    } else {
      return ContainerB(data);
    }
  }

  // Desain untuk Container A
  Widget ContainerA(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data["title"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          // Menampilkan gambar dan teks secara eksplisit
          Image.asset(data["images"][0]),
          SizedBox(height: 10),
          Text(data["texts"][0], style: TextStyle(color: Colors.white)),
          SizedBox(height: 10),
          if (data["images"].length > 1) Image.asset(data["images"][1]),
          if (data["texts"].length > 1) Text(data["texts"][1], style: TextStyle(color: Colors.white)),
          SizedBox(height: 10),
          if (data["images"].length > 2) Image.asset(data["images"][2]),
          if (data["texts"].length > 2) Text(data["texts"][2], style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // Desain untuk Container B
  Widget ContainerB(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.greenAccent,
      child: Row(
        children: [
          // Menampilkan gambar dan teks secara eksplisit
          Image.asset(data["images"][0]),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data["title"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: 10),
              Text(data["texts"][0], style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              if (data["images"].length > 1) Image.asset(data["images"][1]),
              if (data["texts"].length > 1) Text(data["texts"][1], style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              if (data["images"].length > 2) Image.asset(data["images"][2]),
              if (data["texts"].length > 2) Text(data["texts"][2], style: TextStyle(color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildDropdown(String hint, List<String> options, {required String selectedValue, required ValueChanged<String?> onChanged, bool isWide = false}) {
  return Container(
    width: isWide ? 300 : 200, // Conditional width based on isWide parameter
    height: 40, // Set the total height of the dropdown to 40
    child: DropdownButtonFormField<String>(
      isDense: true, // Make the dropdown more compact
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0), // Padding to control internal spacing
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
          borderSide: BorderSide(
            color: Color(0xFF705D54), // Default border color
            width: 1, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Color(0xFF705D54), // Warna border saat fokus
            width: 2.0, // Lebar border saat fokus
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Color(0xFF705D54), // Warna border saat tidak fokus
            width: 1.0, // Lebar border saat tidak fokus
          ),
        ),
      ),
      hint: Text(
        hint,
        style: TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 21.82 / 16, // line-height calculated as ratio of font-size
          decoration: TextDecoration.none, // No underline decoration
          color: Color(0xFF705D54), // Text color
        ),
      ),
      value: selectedValue, // Set the current selected value
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 21.82 / 16,
              decoration: TextDecoration.none,
              color: Color(0xFF705D54), // Text color
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged, // Set the onChanged callback
      icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF705D54)), // Icon color
    ),
  );
}

Widget _buildIconBox() {
  return GestureDetector(
    onTap: () {
      setState(() {
        // Reset the status, role, location, and commission selections when the icon box is tapped
        selectedStatus = "Semua status";
        selectedPeran = "Semua peran";
        selectedLokasi = "Semua lokasi";
        selectedKomisi = "Semua komisi";
      });
    },
    child: Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Rounded corners
        border: Border.all(
          color: Color(0xFF705D54), // Border color
          width: 1, // Border width of 1px
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
        crossAxisAlignment: CrossAxisAlignment.start, // Center align horizontally
        children: [
          // Top line (full width)
          Container(
            width: double.infinity, // Max width
            height: 2,
            color: Color(0xFF705D54),
          ),
          SizedBox(height: 4), // Add spacing between lines
          // Middle line (2/3 of the box width)
          Container(
            width: 2 / 3 * 20, // 2/3 width of the box
            height: 2,
            color: Color(0xFF705D54),
          ),
          SizedBox(height: 4), // Add spacing between lines
          // Bottom line (half the width of the box)
          Container(
            width: 1 / 2 * 20, // 1/2 width of the box
            height: 2,
            color: Color(0xFF705D54),
          ),
        ],
      ),
    ),
  );
}
