import '../../core/services/reports_service.dart';
import '../../shared/models/report_record_model.dart';

class ReportsController {
  final int employeeId;
  final ReportsService _reportsService;

  List<ReportRecordModel> records = [];
  bool isLoading = true;
  String? errorMessage;

  ReportsController({required this.employeeId})
      : _reportsService = ReportsService(employeeId: employeeId);

  Future<void> loadRecords() async {
    isLoading = true;
    errorMessage = null;

    try {
      records = await _reportsService.getAllRecords();
      // errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      records = [];
    } finally {
      isLoading = false;
    }
  }
}
