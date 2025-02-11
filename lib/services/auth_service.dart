import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = "https://1999-114-10-17-121.ngrok-free.app";

  Future<String?> signInWithGoogle() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/auth/google'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error Login Google: $e");
      return null;
    }
  }
}