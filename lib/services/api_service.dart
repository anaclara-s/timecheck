import 'dart:convert';
import 'package:http/http.dart' as http;

import '../shared/constants/record_types.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.0.57:3000';
  static const Duration _timeout = Duration(seconds: 10);

  static Future<List<Map<String, dynamic>>> getRecords(int employeeId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/registros/$employeeId'),
          )
          .timeout(_timeout);

      _validateResponse(response);

      final data = jsonDecode(response.body);
      if (data['sucess'] != true) {
        throw ApiException(data['mensage'] ?? 'Invalid API response');
      }

      return List<Map<String, dynamic>>.from(data['registros'] ?? []);
    } catch (e) {
      throw ApiException('Failed to load records: ${e.toString()}');
    }
  }

  static Future<void> recordTime(int employeeId, String recordType) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/registrar-ponto'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'id_funcionario': employeeId,
              'tipo_registro': RecordTypeConstant.getBackendType(recordType),
            }),
          )
          .timeout(_timeout);

      _validateResponse(response);
      final responseBody = jsonDecode(response.body);

      if (responseBody['sucess'] != true) {
        throw ApiException(responseBody['mensage'] ?? 'Failed to record time');
      }
    } catch (e) {
      throw ApiException('Failed to record time: ${e.toString()}');
    }
  }

  static void _validateResponse(http.Response response) {
    if (response.statusCode != 200) {
      throw ApiException('HTTP Error ${response.statusCode}');
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
