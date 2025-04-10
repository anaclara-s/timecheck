import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/record_types.dart';

class ApiService {
  static const String _baseUrl = 'https://api-timecheck-i1lv.onrender.com';
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
      final now = DateTime.now();
      final formattedTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
      final response = await http
          .post(
            Uri.parse('$_baseUrl/registrar-ponto'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'id_funcionario': employeeId,
              'tipo_registro': RecordTypeConstant.getBackendType(recordType),
              'horario': formattedTime,
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

  static Future<void> updateRecordTime(int recordId, TimeOfDay newTime) async {
    try {
      final response = await http
          .put(
            Uri.parse('$_baseUrl/atualizar-registro/$recordId'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'novo_horario': '${newTime.hour}:${newTime.minute}:00',
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        throw ApiException(
            errorBody['mensage'] ?? 'Limite de alterações atingido');
      }

      _validateResponse(response);
      final responseBody = jsonDecode(response.body);

      if (responseBody['sucess'] != true) {
        throw ApiException(responseBody['mensage'] ?? 'Failed to update time');
      }
    } on SocketException {
      throw ApiException('Sem conexão com o servidor');
    } on TimeoutException {
      throw ApiException('Tempo de conexão esgotado');
    } on FormatException {
      throw ApiException('Erro no formato dos dados');
    } catch (e) {
      throw ApiException('Erro ao atualizar horário: ${e.toString()}');
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
