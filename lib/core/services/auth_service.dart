import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  //URL API render
  static const String _baseUrl = 'https://api-timecheck-i1lv.onrender.com';

  //função para login
  static Future<Map<String, dynamic>> makeLogin(
      String user, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'usuario': user, 'senha': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      }
      // Retorna a mensagem de erro da API
      else {
        return {
          'sucess': false,
          'mensage': data['mensage'] ?? 'Erro desconhecido'
        };
      }
    } catch (e) {
      // print('Erro ao conectar ao servidor: $e');
      return {'sucess': false, 'mensage': 'Erro ao conectar ao servidor'};
    }
  }

  //função para cadastro
  static Future<Map<String, dynamic>> registerUser(
      String nome, String email, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/cadastro'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome,
          'email': email,
          'senha': senha,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return data;
      } else {
        return {
          'sucess': false,
          'mensage': data['mensage'] ?? 'Erro no cadastro'
        };
      }
    } catch (e) {
      return {'sucess': false, 'mensage': 'Erro ao conectar ao servidor'};
    }
  }
}
