import 'dart:convert';
import 'package:http/http.dart' as http;

class Survey {
  final String idSurvey;
  final String idClient;
  final String namaProyek;
  final String deskripsiProyek;
  final String tenggatPengerjaan;
  final String lokasi;
  final String kompensasi;
  final List<String> keahlian;
  final List<String> tipeHasil;
  final String createdAt;
  final String statusTask;
  final String idLuaran;
  final String orderId;
  final String statusRating;
  final bool statusRevisi;
  final String statusSurveyor;
  final String taskRevisi;

  Survey({
    this.idSurvey = '',
    this.idClient = '',
    this.namaProyek = '',
    this.deskripsiProyek = '',
    this.tenggatPengerjaan = '',
    this.lokasi = '',
    this.kompensasi = '',
    this.keahlian = const [],
    this.tipeHasil = const [],
    this.createdAt = '',
    this.statusTask = '',
    this.idLuaran = '',
    this.orderId = '',
    this.statusRating = '',
    this.statusRevisi = false,
    this.statusSurveyor = '',
    this.taskRevisi = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id_survey': idSurvey,
      'id_client': idClient,
      'nama_proyek': namaProyek,
      'deskripsi_proyek': deskripsiProyek,
      'tenggat_pengerjaan': tenggatPengerjaan,
      'lokasi': lokasi,
      'kompensasi': kompensasi,
      'keahlian': keahlian,
      'created_at': createdAt,
      'status_task': statusTask,
      'id_luaran': idLuaran,
      'order_id': orderId,
      'status_rating': statusRating,
      'status_revisi': statusRevisi,
      'status_surveyor': statusSurveyor,
      'task_revisi': taskRevisi,
    };
  }

  static Survey fromJson(Map<String, dynamic> json) {
    return Survey(
      idSurvey: json['id_survey'] ?? '',
      idClient: json['id_client'] ?? '',
      namaProyek: json['nama_proyek'] ?? '',
      deskripsiProyek: json['deskripsi_proyek'] ?? '',
      tenggatPengerjaan: json['tenggat_pengerjaan'] ?? '',
      lokasi: json['lokasi'] ?? 'Tidak diketahui',
      kompensasi: json['kompensasi'] ?? '',
      keahlian: List<String>.from(json['keahlian'] ?? []),
      tipeHasil: List<String>.from(json['tipe_hasil'] ?? []),
      createdAt: json['created_at'] ?? '',
      statusTask: json['status_task'] ?? '',
      idLuaran: json['id_luaran'] ?? '',
      orderId: json['order_id'] ?? '',
      statusRating: json['status_rating'] ?? '',
      statusRevisi: json['status_revisi'] ?? false,
      statusSurveyor: json['status_surveyor'] ?? '',
      taskRevisi: json['task_revisi'] ?? 'Tidak ada revisi',
    );
  }

  int calculateDeadline() {
    try {
      DateTime deadline = DateTime.parse(tenggatPengerjaan).toLocal();
      DateTime now = DateTime.now();
      return deadline.difference(now).inDays;
    } catch (e) {
      print("Error parsing tenggat pengerjaan: $e");
      return 0;
    }
  }

  String calculateDeadlineToString() {
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
  String? token;

  ApiService(this.baseUrl, {this.token = ''});

  Future<List<Survey>> getSurveys() async {
    final response = await http.get(
      Uri.parse('$baseUrl/surveys/'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is List) {
        List<dynamic> data = jsonResponse['data'];
        return data.map((survey) => Survey.fromJson(survey)).toList();
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load surveys');
    }
  }

  Future<Survey> getASurvey(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/surveys/$id'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is Map<String, dynamic>) {
        return Survey.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }

  Future<List<Survey>> getMySurveys() async {
    final response = await http.get(
      Uri.parse('$baseUrl/surveys/mySurvey'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is Map<String, dynamic> &&
          jsonResponse['data']['projectCardDetail'] is List) {
        List<dynamic> data = jsonResponse['data']['projectCardDetail'];
        return data.map((survey) => Survey.fromJson(survey)).toList();
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }

  Future<Survey> getAppliedSurveys(String id_survey) async {
    final response = await http.get(
      Uri.parse('$baseUrl/surveys/$id_survey/applied'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is Map<String, dynamic>) {
        return Survey.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }
}
