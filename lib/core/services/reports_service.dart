import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/models/report_record_model.dart';
import 'api_service.dart';

class ReportsService {
  final int employeeId;
  static const String _baseUrl = 'https://api-timecheck-i1lv.onrender.com';

  ReportsService({required this.employeeId});

  Future<void> updateRecordTime(int recordId, TimeOfDay newTime) async {
    try {
      debugPrint(
          'Tentando atualizar registro $recordId para ${newTime.hour}:${newTime.minute}');

      final response = await http
          .put(
            Uri.parse('$_baseUrl/atualizar-registro/$recordId'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'novo_horario':
                  '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}:00',
            }),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('Resposta da API: ${response.statusCode} - ${response.body}');

      if (response.statusCode != 200) {
        final responseBody = jsonDecode(response.body);
        final message =
            responseBody['mensage'] ?? 'Erro HTTP ${response.statusCode}';
        throw ApiException(message);
      }

      final responseBody = jsonDecode(response.body);
      if (responseBody['sucess'] != true) {
        throw ApiException(
            responseBody['mensage'] ?? 'Erro desconhecido na API');
      }
    } on SocketException {
      throw ApiException('Sem conexão com o servidor');
    } on TimeoutException {
      throw ApiException('Tempo de conexão esgotado');
    } on FormatException catch (e) {
      throw ApiException('Erro no formato dos dados: ${e.message}');
    } catch (e) {
      throw ApiException('Erro ao atualizar horário: ${e.toString()}');
    }
  }

  Future<List<ReportRecordModel>> getAllRecords() async {
    try {
      final records = await ApiService.getRecords(employeeId);

      return records
          .map((record) {
            try {
              return ReportRecordModel.fromJson(record);
            } catch (e) {
              // print('Error parsing record $record: $e');
              return null;
            }
          })
          .where((record) => record != null)
          .cast<ReportRecordModel>()
          .toList();
    } catch (e) {
      // print('Erro ao carregar registros: $e');
      throw Exception('Failed to load reports: ${e.toString()}');
    }
  }
}
