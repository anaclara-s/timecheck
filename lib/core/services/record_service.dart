import '../constants/record_types.dart';
import '../../shared/extencions/format_date_extension.dart';
import '../../shared/models/time_record.dart';
import 'api_service.dart';

class RecordService {
  final int employeeId;
  final Function(List<TimeRecordModel>) onRecordsUpdated;

  RecordService({
    required this.employeeId,
    required this.onRecordsUpdated,
  });

  Future<void> loadRecentRecords() async {
    try {
      final records = await ApiService.getRecords(employeeId);
      onRecordsUpdated(records.map(TimeRecordModel.fromJson).toList());
    } catch (e) {
      rethrow;
    }
  }

  String determineNextRecordType(List<TimeRecordModel> records) {
    final today = DateTime.now().toDateString();
    final todayRecords = records.where((r) => r.date == today).toList()
      ..sort((a, b) => b.time.compareTo(a.time));

    // Verifica se tem uma saida_final no dia
    final hasCompleted = todayRecords.any((r) =>
        r.recordType ==
        RecordTypeConstant.toBackend[RecordTypeConstant.checkOut]);
    if (hasCompleted) return RecordTypeConstant.completed;

    if (todayRecords.isEmpty) return RecordTypeConstant.checkIn;

    final last = todayRecords.first;

    switch (last.recordType) {
      case 'entrada':
        return RecordTypeConstant.startBreak;
      case 'saida_intervalo':
        return RecordTypeConstant.endBreak;
      case 'volta_intervalo':
        return RecordTypeConstant.checkOut;
      case 'saida_final':
        return RecordTypeConstant.completed;
      default:
        return RecordTypeConstant.checkIn;
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
