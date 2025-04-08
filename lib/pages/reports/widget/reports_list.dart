import 'package:flutter/material.dart';

import '../../../shared/models/report_record_model.dart';
import '../controller/report_list_controller.dart';

class ReportsListWidget extends StatelessWidget {
  final List<ReportRecordModel> records;
  final DateTime selectedDate;
  final ReportListController controller;

  const ReportsListWidget({
    super.key,
    required this.records,
    required this.selectedDate,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nenhum registro encontrado para ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '${records.first.date.day}/${records.first.date.month}/${records.first.date.year}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        controller.onTapChangeTime(context, record, (_) {}),
                  ),
                  title: Text(record.formattedType),
                  subtitle: Text(record.formattedDate),
                  trailing: Text(record.formattedTime,
                      style: const TextStyle(fontSize: 18)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
