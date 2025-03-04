import 'dart:convert';
import 'package:http/http.dart' as http;

class RespondenProfile {
  String idResponden;
  String namaLengkap;
  String jenisKelamin;
  String nomorTelepon;
  String email;
  String nik;
  String statusPerkawinan;
  String domisili;
  String tingkatPendidikan;
  String pekerjaan;
  String nomorRekening;
  int pinAkses;
  String tanggalLahir;
  String namaBank;
  List<String> hobi;
  String profilePicture;

  RespondenProfile({
    required this.idResponden,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.nomorTelepon,
    required this.email,
    required this.nik,
    required this.statusPerkawinan,
    required this.domisili,
    required this.tingkatPendidikan,
    required this.pekerjaan,
    required this.nomorRekening,
    required this.pinAkses,
    required this.tanggalLahir,
    required this.namaBank,
    required this.hobi,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_responden': idResponden,
      'nama_lengkap': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'nomor_telepon': nomorTelepon,
      'email': email,
      'nik': nik,
      'status_perkawinan': statusPerkawinan,
      'domisili': domisili,
      'tingkat_pendidikan': tingkatPendidikan,
      'pekerjaan': pekerjaan,
      'nomor_rekening': nomorRekening,
      'pin_akses': pinAkses,
      'tanggal_lahir': tanggalLahir,
      'nama_bank': namaBank,
      'hobi': hobi,
      'profile_picture': profilePicture,
    };
  }

  static RespondenProfile fromJson(Map<String, dynamic> json) {
    return RespondenProfile(
      idResponden: json['id_responden'] ?? '',
      namaLengkap: json['nama_lengkap'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      nomorTelepon: json['nomor_telepon'] ?? '',
      email: json['email'] ?? '',
      nik: json['nik'] ?? '',
      statusPerkawinan: json['status_perkawinan'] ?? '',
      domisili: json['domisili'] ?? '',
      tingkatPendidikan: json['tingkat_pendidikan'] ?? '',
      pekerjaan: json['pekerjaan'] ?? '',
      nomorRekening: json['nomor_rekening'] ?? '',
      pinAkses: json['pin_akses'] ?? 0,
      tanggalLahir: json['tanggal_lahir'] ?? '',
      namaBank: json['nama_bank'] ?? '',
      hobi: List<String>.from(json['hobi'] ?? []),
      profilePicture: json['profile_picture'] ?? '',
    );
  }
}

class ApiService {
  final String baseUrl;
  final String authToken;

  ApiService(this.baseUrl, this.authToken);

  Future<RespondenProfile> getRespondenProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/respondents/getRespondenInfo'),
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
        return RespondenProfile.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }
}
