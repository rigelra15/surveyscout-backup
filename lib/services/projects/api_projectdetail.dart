import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectDetail {
  final String idSurvey;
  final String namaProyek;
  final String deskripsiProyek;
  final String tenggatPengerjaan;
  final String lokasi;
  final String alamat;
  final String keahlian;
  List<String> tipeHasil;
  final String kompensasi;
  final String idClient;
  final String createdAt;
  final String statusTask;
  final String orderId;
  final String metodeSurvey;
  final bool statusRevisi;
  final String? idLuaran;
  final String? midtransToken;
  final String? midtransLink;

  ProjectDetail({
    this.idSurvey = '',
    this.namaProyek = '',
    this.deskripsiProyek = '',
    this.tenggatPengerjaan = '',
    this.lokasi = '',
    this.alamat = '',
    this.keahlian = '',
    this.tipeHasil = const [],
    this.kompensasi = '',
    this.idClient = '',
    this.createdAt = '',
    this.statusTask = '',
    this.orderId = '',
    this.metodeSurvey = '',
    this.statusRevisi = false,
    this.idLuaran,
    this.midtransToken,
    this.midtransLink,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_survey': idSurvey,
      'nama_proyek': namaProyek,
      'deskripsi_proyek': deskripsiProyek,
      'tenggat_pengerjaan': tenggatPengerjaan,
      'lokasi': lokasi,
      'alamat': alamat,
      'keahlian': keahlian,
      'tipe_hasil': tipeHasil,
      'kompensasi': kompensasi,
      'id_client': idClient,
      'created_at': createdAt,
      'status_task': statusTask,
      'order_id': orderId,
      'metode_survey': metodeSurvey,
      'status_revisi': statusRevisi,
      'id_luaran': idLuaran,
      'midtrans_token': midtransToken,
      'midtrans_link': midtransLink,
    };
  }

  static ProjectDetail fromJson(Map<String, dynamic> json) {
    return ProjectDetail(
      idSurvey: json['id_survey'] ?? '',
      namaProyek: json['nama_proyek'] ?? '',
      deskripsiProyek: json['deskripsi_proyek'] ?? '',
      tenggatPengerjaan: json['tenggat_pengerjaan'] ?? '',
      lokasi: json['lokasi'] ?? '',
      alamat: json['alamat'] ?? '',
      keahlian: json['keahlian'] ?? '',
      tipeHasil: List<String>.from(json['tipe_hasil'] ?? []),
      kompensasi: json['kompensasi'] ?? '',
      idClient: json['id_client'] ?? '',
      createdAt: json['created_at'] ?? '',
      statusTask: json['status_task'] ?? '',
      orderId: json['order_id'] ?? '',
      metodeSurvey: json['metode_survey'] ?? '',
      statusRevisi: json['status_revisi'] ?? false,
      idLuaran: json['id_luaran'],
      midtransToken: json['midtrans_token'],
      midtransLink: json['midtrans_link'],
    );
  }
}

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<ProjectDetail> getASurveyTask(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/projects/$id'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is Map<String, dynamic>) {
        return ProjectDetail.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }

  Future<ProjectDetail> getARespondTask(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/projects/$id'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['data'] is Map<String, dynamic>) {
        return ProjectDetail.fromJson(jsonResponse['data']);
      } else {
        throw Exception("Unexpected data format: ${jsonResponse['data']}");
      }
    } else {
      throw Exception('Failed to load survey');
    }
  }
}
