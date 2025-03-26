import 'package:flutter/material.dart';

import '../../services/record_service.dart';
import '../../shared/constants/record_types.dart';
import '../../shared/extencions/format_date_extension.dart';
import '../../shared/models/time_record.dart';
import '../home_page.dart';

class HomeController extends State<HomePage> {
  String nextRecordType = RecordTypeConstant.checkIn;
  bool isLoading = false;
  List<TimeRecordModel> recentRecords = [];
  late final RecordService recordService;

  @override
  void initState() {
    super.initState();
    recordService = RecordService(
      employeeId: widget.employeeId,
      onRecordsUpdated: _onRecordsUpdated,
    );
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await recordService.loadRecentRecords();
  }

  void _onRecordsUpdated(List<TimeRecordModel> records) {
    if (!mounted) return;

    setState(() {
      recentRecords = records;
      nextRecordType = recordService.determineNextRecordType(records);
    });
  }

  Future<void> recordTime() async {
    final today = DateTime.now().toDateString();
    final isDayComplete = recentRecords.any((r) =>
        r.date == today &&
        r.recordType ==
            RecordTypeConstant.toBackend[RecordTypeConstant.checkOut]);

    if (isDayComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jornada já finalizada hoje')),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      await recordService.recordTime(nextRecordType);
      await recordService.loadRecentRecords();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  String get buttonText => RecordTypeConstant.getDisplayText(nextRecordType);

  String formatRecordType(String type) {
    return RecordTypeConstant.typeDisplayNames[type.toLowerCase()] ?? type;
  }

  @override
  Widget build(BuildContext context) {
    return HomePageView(state: this);
  }
}
