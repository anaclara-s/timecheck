import 'package:intl/intl.dart';

import 'api_service.dart';

class RecordService {
  final int employeeId;
  final Function(List<dynamic>) onRecordsUpdated;

  RecordService({
    required this.employeeId,
    required this.onRecordsUpdated,
  });

  Future<void> loadRecentRecords() async {
    try {
      final records = await ApiService.getRecords(employeeId);
      onRecordsUpdated(records);
    } catch (e) {
      rethrow;
    }
  }

  String determineNextRecordType(List<dynamic> records) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todayRecords = records.where((r) {
      final dateRecord = r['data']?.toString().split(' ')[0] ?? '';
      return dateRecord == today;
    }).toList()
      ..sort((a, b) => (b['horario'] ?? '').compareTo(a['horario'] ?? ''));

    // Verifica se já tem uma saída final hoje
    final temSaidaFinal =
        todayRecords.any((r) => r['tipo_registro'] == 'saida_final');
    if (temSaidaFinal) {
      return 'completed'; // Estado especial
    }

    if (todayRecords.isEmpty) return 'check_in';

    final ultimo = todayRecords.first;
    switch (ultimo['tipo_registro']?.toString() ?? '') {
      case 'entrada':
        return 'start_break';
      case 'saida_intervalo':
        return 'end_break';
      case 'volta_intervalo':
        return 'check_out';
      case 'saida_final':
        return 'completed'; // Já finalizou hoje
      default:
        return 'check_in';
    }
  }

  Future<void> recordTime(String recordType) async {
    try {
      await ApiService.recordTime(employeeId, recordType);
      await loadRecentRecords();
    } catch (e) {
      rethrow;
    }
  }
}
