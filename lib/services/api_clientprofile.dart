import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientProfile {
  String idClient;
  int pinAkses;
  String namaLengkap;
  String jenisKelamin;
  String nomorTelepon;
  String email;
  String nik;
  String namaPerusahaan;
  String jenisUsaha;
  String nomorRekening;
  String profilePicture;
  String namaBank;
  String tanggalLahir;

  ClientProfile({
    required this.idClient,
    required this.pinAkses,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.nomorTelepon,
    required this.email,
    required this.nik,
    required this.namaPerusahaan,
    required this.jenisUsaha,
    required this.nomorRekening,
    required this.profilePicture,
    required this.namaBank,
    required this.tanggalLahir,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_client': idClient,
      'pin_akses': pinAkses,
      'nama_lengkap': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'nomor_telepon': nomorTelepon,
      'email': email,
      'nik': nik,
      'nama_perusahaan': namaPerusahaan,
      'jenis_usaha': jenisUsaha,
      'nomor_rekening': nomorRekening,
      'profile_picture': profilePicture,
      'nama_bank': namaBank,
      'tanggal_lahir': tanggalLahir,
    };
  }

  static ClientProfile fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      idClient: json['id_client'] ?? '',
      pinAkses: json['pin_akses'] ?? 0,
      namaLengkap: json['nama_lengkap'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      nomorTelepon: json['nomor_telepon'] ?? '',
      email: json['email'] ?? '',
      nik: json['nik'] ?? '',
      namaPerusahaan: json['nama_perusahaan'] ?? '',
      jenisUsaha: json['jenis_usaha'] ?? '',
      nomorRekening: json['nomor_rekening'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      namaBank: json['nama_bank'] ?? '',
      tanggalLahir: json['tanggal_lahir'] ?? '',
    );
  }
}

class ApiService {
  final String baseUrl;
  final String authToken;

  ApiService(this.baseUrl, this.authToken);

  Future<ClientProfile> getClientProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/clients/getClientInfo'),
      headers: {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json",
      },
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is Map<String, dynamic>) {
        return ClientProfile.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }
}
