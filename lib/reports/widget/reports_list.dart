import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/models/report_record_model.dart';

class ReportsListWidget extends StatelessWidget {
  final List<ReportRecordModel> records;
  final DateTime selectedDate;

  const ReportsListWidget({
    Key? key,
    required this.records,
    required this.selectedDate,
  }) : super(key: key);

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
              'Nenhum registro encontrado para ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
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
            DateFormat('EEEE, d MMMM y', 'pt_BR').format(records.first.date),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
                  title: Text(record.formattedType),
                  subtitle: Text(record.formattedDate),
                  trailing: Text(
                    record.formattedTime,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
