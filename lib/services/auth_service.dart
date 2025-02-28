import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  //Api
  static const String _baseUrl = 'http://localhost:3000';

  //função para fazer login
  static Future<Map<String, dynamic>> makeLogin(
      String usuario, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'usuario': usuario, 'senha': senha}),
      );

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'sucess': false, 'mensage': 'Erro ao conectar ao servidor'};
    }
  }
}
