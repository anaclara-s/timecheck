import 'package:flutter/material.dart';

import '../core/services/reports_service.dart';
import '../core/widgets/custom_appbar.dart';
import 'controller/report_list_controller.dart';
import 'controller/reports_controller.dart';
import 'widget/reports_calendar.dart';
import 'widget/reports_error.dart';
import 'widget/reports_list.dart';

class ReportsPage extends StatefulWidget {
  final int employeeId;

  const ReportsPage({Key? key, required this.employeeId}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late ReportsController _controller;
  late DateTime _currentSelectedDate;

  @override
  void initState() {
    super.initState();
    _currentSelectedDate = DateTime.now();
    _controller = ReportsController(employeeId: widget.employeeId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRecords();
    });
  }

  Future<void> _loadRecords() async {
    await _controller.loadRecords();
    if (mounted) {
      setState(() {
        _controller.filterByDate(_currentSelectedDate);
      });
    }
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _currentSelectedDate = day;
    });
    _controller.filterByDate(day);
  }

  void _clearDateFilter() {
    _controller.clearDateFilter();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
          text: 'Relatórios de ponto',
          actions: [
            if (_controller.selectedDate != null)
              IconButton(
                icon: const Icon(Icons.clear),
                tooltip: 'Limpar filtro',
                onPressed: _clearDateFilter,
                color: Colors.white,
              ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _loadRecords,
              color: Colors.white,
            ),
          ],
        ),
        body: Column(
          children: [
            ReportsCalendarWidget(
              selectedDay: _currentSelectedDate,
              onDaySelected: _onDaySelected,
              markedDates: _controller.getMarkedDates(),
            ),
            Divider(height: 1),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ));
  }

  Widget _buildBody() {
    if (_controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_controller.errorMessage != null &&
        _controller.errorMessage!.isNotEmpty) {
      return ReportsErrorWidget(
        errorMessage: _controller.errorMessage ?? 'Erro desconhecido',
        onRetry: _loadRecords,
      );
    }

    return ReportsListWidget(
      records: _controller.filteredRecords,
      selectedDate: _currentSelectedDate,
      controller:
          ReportListController(ReportsService(employeeId: widget.employeeId)),
    );
  }
}
