import 'package:flutter/material.dart';

import '../../shared/models/report_record_model.dart';

class ReportsListWidget extends StatelessWidget {
  final List<ReportRecordModel> records;

  const ReportsListWidget({
    super.key,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
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
