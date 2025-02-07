import 'package:flutter/material.dart';

class CobaPage extends StatefulWidget {
  @override
  _CobaPageState createState() => _CobaPageState();
}

class _CobaPageState extends State<CobaPage> {
  // Dummy variables for the dropdowns
  String selectedStatus = "Semua status";
  String selectedPeran = "Semua peran";
  String selectedLokasi = "Semua lokasi";
  String selectedKomisi = "Semua komisi";

  // Function to show the Bottom Sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFFF1E9E5),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "This is a Bottom Sheet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "You can add more content here.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the Bottom Sheet
                },
                child: Text("Close"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF705D54), // Use backgroundColor instead of primary
                ),

              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1E9E5), // Background berwarna #F1E9E5
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
      body: Stack(),
      bottomNavigationBar: Container(
        child: ElevatedButton(
          onPressed: () => _showBottomSheet(context), // Call the Bottom Sheet function
          child: Text("Show Bottom Sheet"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF705D54), // Use backgroundColor instead of primary
          ),

        ),
      ),
    );
  }

  // Dummy methods for your dropdown and icon box
  Widget _buildDropdown(String label, List<String> items, {String? selectedValue, Function(String?)? onChanged, bool isWide = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: isWide ? 150 : 120,
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIconBox() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFF705D54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.filter_list,
        color: Colors.white,
      ),
    );
  }
}
