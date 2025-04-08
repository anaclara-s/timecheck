import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/record_types.dart';
import '../../../core/services/reports_service.dart';
import '../../../shared/models/report_record_model.dart';

class ReportsController {
  final int employeeId;
  final ReportsService _reportsService;

  List<ReportRecordModel> allRecords = [];
  List<ReportRecordModel> filteredRecords = [];
  bool isLoading = true;
  String? errorMessage;
  DateTime? selectedDate;

  ReportsController({
    required this.employeeId,
  }) : _reportsService = ReportsService(employeeId: employeeId);

  Future<void> loadRecords() async {
    try {
      isLoading = true;
      errorMessage = null;

      allRecords = await _reportsService.getAllRecords();
      filteredRecords = allRecords;
      selectedDate = null;
      // errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      allRecords = [];
      filteredRecords = [];
    } finally {
      isLoading = false;
    }
  }

  void filterByDate(DateTime date) {
    selectedDate = date;
    filteredRecords = allRecords.where((record) {
      return record.date.year == date.year &&
          record.date.month == date.month &&
          record.date.day == date.day;
    }).toList();
  }

  void clearDateFilter() {
    selectedDate = null;
    filteredRecords = allRecords;
  }

  List<DateTime> getMarkedDates() {
    final dates = <DateTime>[];
    final now = DateTime.now();
    final firstDay = DateTime(now.year - 1);
    final lastDay = DateTime(now.year + 1);

    for (final record in allRecords) {
      final date =
          DateTime(record.date.year, record.date.month, record.date.day);
      if (!dates.any((d) => isSameDate(d, date)) &&
          (date.isAfter(firstDay) || isSameDay(date, firstDay)) &&
          (date.isBefore(lastDay) || isSameDay(date, lastDay))) {
        dates.add(date);
      }
    }
    return dates;
  }

  DateTime get initialSelectedDate {
    return selectedDate ?? DateTime.now();
  }

  String formatRecordType(String type) {
    return RecordTypeConstant.typeDisplayNames[type.toLowerCase()] ?? type;
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
