import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.0.57:3000';

  // Função para obter registros
  static Future<List<dynamic>> getRegistros(int idFuncionario) async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/registros/$idFuncionario'),
          )
          .timeout(Duration(seconds: 10));

      print('Resposta da API: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['sucess'] == true) {
          return data['registros'] ?? [];
        }
        throw Exception('Resposta inválida da API: ${data['mensage']}');
      }
      throw Exception('Erro HTTP ${response.statusCode}');
    } catch (e) {
      print('Erro no getRegistros: $e');
      throw Exception('Falha ao carregar registros. Tente novamente.');
    }
  }

  // Função para registrar ponto (apenas uma declaração)
  static Future<void> registrarPonto(
    int idFuncionario,
    String tipoRegistro,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/registrar-ponto'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_funcionario': idFuncionario,
        'tipo_registro': tipoRegistro,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao registrar ponto');
    }
  }
}
