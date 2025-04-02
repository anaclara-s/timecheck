import 'package:flutter/material.dart';

import 'controller/reports_controller.dart';
import 'widget/reports_error.dart';
import 'widget/reports_list.dart';
import '../core/widgets/custom_appbar.dart';

class ReportsPage extends StatefulWidget {
  final int employeeId;

  const ReportsPage({Key? key, required this.employeeId}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late ReportsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ReportsController(employeeId: widget.employeeId);
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    await _controller.loadRecords();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        text: 'Relatorios de ponto',
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadRecords,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_controller.isLoading) {
      return ReportsErrorWidget(
        errorMessage: _controller.errorMessage ?? 'Erro desconhecido',
        onRetry: _loadRecords,
      );
    }
    return ReportsListWidget(
      records: _controller.records,
    );
  }
}
