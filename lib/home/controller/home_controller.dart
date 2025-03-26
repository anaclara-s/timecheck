import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/record_service.dart';
import '../home_page.dart';

class HomeController extends State<HomePage> {
  String nextRecordType = 'check_in';
  bool isLoading = false;
  List<dynamic> recentRecords = [];
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

  void _onRecordsUpdated(List<dynamic> records) {
    if (!mounted) return;

    setState(() {
      recentRecords = records;
      nextRecordType = recordService.determineNextRecordType(records);
    });
  }

  Future<void> recordTime() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todayRecords = recentRecords.where((r) {
      final dateRecord = r['data']?.toString().split(' ')[0] ?? '';
      return dateRecord == today;
    }).toList();

    final dayComplete =
        todayRecords.any((r) => r['tipo_registro'] == 'saida_final');

    if (dayComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jornada já finalizada hoje')),
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

  String get buttonText {
    if (nextRecordType == 'Completed') {
      return 'Jornada finalizada';
    }

    switch (nextRecordType) {
      case 'check_in':
        return 'Registrar entrada';
      case 'start_break':
        return 'Registrar saída intervalo';
      case 'end_break':
        return 'Registrar volta intervalo';
      case 'check_out':
        return 'Registrar saída';
      default:
        return 'Marcar ponto';
    }
  }

  String formatRecordType(String type) {
    switch (type.toLowerCase()) {
      case 'check_in':
        return 'Checked In';
      case 'start_break':
        return 'Started Break';
      case 'end_break':
        return 'Ended Break';
      case 'check_out':
        return 'Checked Out';
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePageView(state: this);
  }
}
