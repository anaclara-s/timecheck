import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  //URL API
  // static const String _baseUrl = 'http://localhost:3000';

  //IP maquina
  static const String _baseUrl = 'http://192.168.0.57:3000';

  //função para fazer login
  static Future<Map<String, dynamic>> makeLogin(
      String usuario, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'usuario': usuario, 'senha': senha}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return {'sucess': false, 'mensage': 'Erro ao conectar ao servidor1'};
      }
    } catch (e) {
      return {'sucess': false, 'mensage': 'Erro ao conectar ao servidor2'};
    }
  }
}
