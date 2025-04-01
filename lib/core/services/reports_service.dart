import '../../shared/models/report_record_model.dart';
import 'api_service.dart';

class ReportsService {
  final int employeeId;

  ReportsService({required this.employeeId});

  Future<List<ReportRecordModel>> getAllRecords() async {
    try {
      final records = await ApiService.getRecords(employeeId);

      return records
          .map((record) {
            try {
              return ReportRecordModel.fromJson(record);
            } catch (e) {
              print('Error parsing record $record: $e');
              return null;
            }
          })
          .where((record) => record != null)
          .cast<ReportRecordModel>()
          .toList();
    } catch (e) {
      print('Erro ao carregar registros: $e');
      throw Exception('Failed to load reports: ${e.toString()}');
    }
  }
}
