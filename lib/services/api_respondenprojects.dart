import 'dart:convert';
import 'package:http/http.dart' as http;

class Respond {
  String idRespond;
  String namaProyek;
  String deskripsiProyek;
  String tenggatPengerjaan;
  String lokasi;
  String metodeSurvey;
  String idClient;
  String kompensasi;
  int jumlahResponden;
  List<String> keahlian;
  String createdAt;
  String statusTask;
  String idLuaran;

  Respond({
    required this.idRespond,
    required this.namaProyek,
    required this.deskripsiProyek,
    required this.tenggatPengerjaan,
    required this.lokasi,
    required this.metodeSurvey,
    required this.idClient,
    required this.kompensasi,
    required this.jumlahResponden,
    required this.keahlian,
    required this.createdAt,
    required this.statusTask,
    required this.idLuaran,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_respond': idRespond,
      'nama_proyek': namaProyek,
      'deskripsi_proyek': deskripsiProyek,
      'tenggat_pengerjaan': tenggatPengerjaan,
      'lokasi': lokasi,
      'metode_survey': metodeSurvey,
      'id_client': idClient,
      'kompensasi': kompensasi,
      'jumlah_responden': jumlahResponden,
      'keahlian': keahlian,
      'created_at': createdAt,
      'status_task': statusTask,
      'id_luaran': idLuaran,
    };
  }

  static Respond fromJson(Map<String, dynamic> json) {
    return Respond(
      idRespond: json['id_respond'] ?? '',
      namaProyek: json['nama_proyek'] ?? '',
      deskripsiProyek: json['deskripsi_proyek'] ?? '',
      tenggatPengerjaan: json['tenggat_pengerjaan'] ?? '',
      lokasi: json['lokasi'] ?? '',
      metodeSurvey: json['metode_survey'] ?? '',
      idClient: json['id_client'] ?? '',
      kompensasi: json['kompensasi'] ?? '',
      jumlahResponden: json['jumlah_responden'] ?? 0,
      keahlian: List<String>.from(json['keahlian'] ?? []),
      createdAt: json['created_at'] ?? '',
      statusTask: json['status_task'] ?? '',
      idLuaran: json['id_luaran'] ?? '',
    );
  }

  int calculateDeadline() {
    try {
      DateTime deadline = DateTime.parse(tenggatPengerjaan).toLocal();
      DateTime now = DateTime.now();
      return deadline
          .difference(now)
          .inDays; // Mengembalikan jumlah hari sebagai int
    } catch (e) {
      print("Error parsing tenggat pengerjaan: $e");
      return 0; // Default jika parsing gagal
    }
  }
}

class ApiService {
  final String baseUrl;
  final String authToken;

  ApiService(this.baseUrl, this.authToken);

  Future<List<Respond>> getResponds() async {
    final response = await http.get(
      Uri.parse('$baseUrl/responds/getAllRespondTask'),
      headers: {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is List) {
        List<dynamic> data = jsonResponse['data'];
        return data.map((survey) => Respond.fromJson(survey)).toList();
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load surveys');
    }
  }
}
