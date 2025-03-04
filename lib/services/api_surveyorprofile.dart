import 'dart:convert';
import 'package:http/http.dart' as http;

class SurveyorProfile {
  String idSurveyor;
  int pinAkses;
  String namaLengkap;
  String jenisKelamin;
  String nomorTelepon;
  String email;
  String nik;
  String domisili;
  String cvATS;
  String nomorRekening;
  String sumRating;
  String totalProject;
  String avgRating;
  int scoutTrust;
  String goodProject;
  String namaBank;
  List<String> keahlian;
  String tanggalLahir;
  String profilePicture;

  SurveyorProfile({
    required this.idSurveyor,
    required this.pinAkses,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.nomorTelepon,
    required this.email,
    required this.nik,
    required this.domisili,
    required this.cvATS,
    required this.nomorRekening,
    required this.sumRating,
    required this.totalProject,
    required this.avgRating,
    required this.scoutTrust,
    required this.goodProject,
    required this.namaBank,
    required this.keahlian,
    required this.tanggalLahir,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_surveyor': idSurveyor,
      'pin_akses': pinAkses,
      'nama_lengkap': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'nomor_telepon': nomorTelepon,
      'email': email,
      'nik': nik,
      'domisili': domisili,
      'cv_ats': cvATS,
      'nomor_rekening': nomorRekening,
      'sum_rating': sumRating,
      'total_project': totalProject,
      'avg_rating': avgRating,
      'scout_trust': scoutTrust,
      'good_project': goodProject,
      'nama_bank': namaBank,
      'keahlian': keahlian,
      'tanggal_lahir': tanggalLahir,
      'profile_picture': profilePicture,
    };
  }

  static SurveyorProfile fromJson(Map<String, dynamic> json) {
    return SurveyorProfile(
      idSurveyor: json['id_surveyor'] ?? '',
      pinAkses: json['pin_akses'] ?? 0,
      namaLengkap: json['nama_lengkap'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      nomorTelepon: json['nomor_telepon'] ?? '',
      email: json['email'] ?? '',
      nik: json['nik'] ?? '',
      domisili: json['domisili'] ?? '',
      cvATS: json['cv_ats'] ?? '',
      nomorRekening: json['nomor_rekening'] ?? '',
      sumRating: json['sum_rating'] ?? '',
      totalProject: json['total_project'] ?? '',
      avgRating: json['avg_rating'] ?? '',
      scoutTrust: json['scout_trust'] ?? 0,
      goodProject: json['good_project'] ?? '',
      namaBank: json['nama_bank'] ?? '',
      keahlian: json['keahlian'].cast<String>() ?? [],
      tanggalLahir: json['tanggal_lahir'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }
}

class ApiService {
  final String baseUrl;
  final String authToken;

  ApiService(this.baseUrl, this.authToken);

  Future<SurveyorProfile> getSurveyorProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/surveyors/getSurveyorInfo'),
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
        return SurveyorProfile.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }
}
