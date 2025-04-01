import 'package:flutter/material.dart';

import '../core/services/reports_service.dart';
import '../core/widgets/custom_appbar.dart';
import '../shared/models/report_record_model.dart';

class ReportsPage extends StatefulWidget {
  final int employeeId;

  const ReportsPage({Key? key, required this.employeeId}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late ReportsService _reportsService;
  List<ReportRecordModel> _records = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _reportsService = ReportsService(employeeId: widget.employeeId);
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final records = await _reportsService.getAllRecords();
      setState(() {
        _records = records;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Erro ao carregar relatórios',
                style: TextStyle(color: Colors.red)),
            Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadRecords,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _records.length,
      itemBuilder: (context, index) {
        final record = _records[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.access_time, color: Colors.blue),
            title: Text(record.formattedType),
            subtitle: Text(record.formattedDate),
            trailing: Text(
              record.formattedTime,
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
