import 'dart:convert';
import 'package:http/http.dart' as http;

class Project {
  String idSurvey;
  String namaProyek;
  String deskripsiProyek;
  String tenggatPengerjaan;
  String lokasi;
  List<String> keahlian;
  List<String> tipeHasil;
  String kompensasi;
  String idClient;
  String createdAt;
  String statusTask;
  String? idLuaran;
  String orderId;
  String statusRating;
  String? midtransToken;
  String? midtransLink;
  int? jumlahResponden;

  Project({
    required this.idSurvey,
    required this.namaProyek,
    required this.deskripsiProyek,
    required this.tenggatPengerjaan,
    required this.lokasi,
    required this.keahlian,
    required this.tipeHasil,
    required this.kompensasi,
    required this.idClient,
    required this.createdAt,
    required this.statusTask,
    this.midtransToken,
    required this.orderId,
    this.idLuaran,
    required this.statusRating,
    this.midtransLink,
    this.jumlahResponden,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_survey': idSurvey,
      'nama_proyek': namaProyek,
      'deskripsi_proyek': deskripsiProyek,
      'tenggat_pengerjaan': tenggatPengerjaan,
      'lokasi': lokasi,
      'keahlian': keahlian,
      'tipe_hasil': tipeHasil,
      'kompensasi': kompensasi,
      'id_client': idClient,
      'created_at': createdAt,
      'status_task': statusTask,
      'midtrans_token': midtransToken,
      'order_id': orderId,
      'id_luaran': idLuaran,
      'status_rating': statusRating,
      'midtrans_link': midtransLink,
      'jumlah_responden': jumlahResponden,
    };
  }

  static Project fromJson(Map<String, dynamic> json) {
    return Project(
      idSurvey: json['id_survey'] ?? '',
      namaProyek: json['nama_proyek'] ?? '',
      deskripsiProyek: json['deskripsi_proyek'] ?? '',
      tenggatPengerjaan: json['tenggat_pengerjaan'] ?? '',
      lokasi: json['lokasi'] ?? '',
      keahlian: List<String>.from(json['keahlian'] ?? []),
      tipeHasil: List<String>.from(json['tipe_hasil'] ?? []),
      kompensasi: json['kompensasi'] ?? '',
      idClient: json['id_client'] ?? '',
      createdAt: json['created_at'] ?? '',
      statusTask: json['status_task'] ?? '',
      midtransToken: json['midtrans_token'] ?? null,
      orderId: json['order_id'] ?? null,
      idLuaran: json['id_luaran'] ?? null,
      statusRating: json['status_rating'] ?? '',
      midtransLink: json['midtrans_link'] ?? null,
      jumlahResponden:
          (json['jumlah_responden'] != null && json['jumlah_responden'] is int)
              ? json['jumlah_responden']
              : null,
    );
  }

  String calculateDeadline() {
    try {
      DateTime deadline = DateTime.parse(tenggatPengerjaan).toLocal();
      DateTime now = DateTime.now();

      Duration difference = deadline.difference(now);
      bool isPast = difference.isNegative;
      int days = difference.inDays.abs();
      int weeks = (days / 7).floor();
      int months = (days / 30).floor();
      int years = (days / 365).floor();

      if (years > 0) {
        return "$years tahun ${isPast ? 'lalu' : 'lagi'}";
      } else if (months > 0) {
        return "$months bulan ${isPast ? 'lalu' : 'lagi'}";
      } else if (weeks > 0) {
        return "$weeks minggu ${isPast ? 'lalu' : 'lagi'}";
      } else if (days > 0) {
        return "$days hari ${isPast ? 'lalu' : 'lagi'}";
      } else {
        return isPast ? "Sudah lewat" : "Hari ini";
      }
    } catch (e) {
      print("Error parsing tenggat pengerjaan: $e");
      return "Format tidak valid";
    }
  }
}

class ApiService {
  final String baseUrl;
  final String authToken;

  ApiService(this.baseUrl, this.authToken);

  Future<List<Project>> getSurveys() async {
    final response = await http.get(
      Uri.parse('$baseUrl/surveys/clientSurveys'),
      headers: {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is List) {
        List<dynamic> data = jsonResponse['data'];
        return data.map((survey) => Project.fromJson(survey)).toList();
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load surveys');
    }
  }

  Future<Project> getSurvey(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/surveys/clientSurveys/$id'),
      headers: {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is Map<String, dynamic>) {
        return Project.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }
}
