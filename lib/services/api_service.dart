import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.0.57:3000';

  // Função para obter registros
  static Future<List<dynamic>> getRecords(int employeeId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/registros/$employeeId'),
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
      print('Erro no getRecords: $e');
      throw Exception('Falha ao carregar registros. Tente novamente.');
    }
  }

  static Future<void> recordTime(int employeeId, String recordType) async {
    try {
      final Map<String, String> typeMapping = {
        'check_in': 'entrada',
        'start_break': 'saida_intervalo',
        'end_break': 'volta_intervalo',
        'check_out': 'saida_final',
      };

      final backendType = typeMapping[recordType] ?? 'entrada';

      print(
          'Sending to backend - recordType: $recordType, backendType: $backendType');

      final response = await http
          .post(
            Uri.parse('$_baseUrl/registrar-ponto'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'id_funcionario': employeeId,
              'tipo_registro': backendType,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final responseBody = jsonDecode(response.body);
      print('Backend response: $responseBody');

      if (response.statusCode != 200 || responseBody['sucess'] != true) {
        throw Exception(responseBody['mensage'] ?? 'Failed to record time');
      }
    } catch (e) {
      print('Error in recordTime: $e');
      rethrow;
    }
  }
}
