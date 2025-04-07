import 'package:flutter/material.dart';

import '../../core/services/api_service.dart';
import '../../core/services/reports_service.dart';
import '../../shared/models/report_record_model.dart';

class ReportListController {
  final ReportsService reportsService;

  ReportListController(this.reportsService);

  Future<void> onTapChangeTime(
    BuildContext context,
    ReportRecordModel record,
    Function(TimeOfDay newTime)? onSuccess,
  ) async {
    if (record.changesCount >= 2) {
      _showSnackBar(context, 'Limite de alterações atingido', Colors.orange);
      return;
    }

    final confirm = await _showConfirmationDialog(context, record);
    if (confirm != true) return;

    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(record.time),
    );

    if (newTime != null) {
      try {
        await reportsService.updateRecordTime(record.id, newTime);

        _showSnackBar(context, 'Horário atualizado com sucesso!', Colors.green);

        if (onSuccess != null) onSuccess(newTime);
      } on ApiException catch (e) {
        final isLimitError =
            e.message.contains('Limite de alterações atingido');
        _showSnackBar(
          context,
          isLimitError ? 'Limite de alterações atingido' : 'Erro: ${e.message}',
          isLimitError ? Colors.orange : Colors.red,
        );
      } catch (e) {
        _showSnackBar(context, 'Erro ao atualizar horário', Colors.red);
      }
    }
  }

  Future<bool?> _showConfirmationDialog(
      BuildContext context, ReportRecordModel record) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alterar horário'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Deseja alterar o horário desta marcação?'),
            if (record.changesCount > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Você já alterou este registro ${record.changesCount} vez(es)',
                  style: TextStyle(color: Colors.orange[800]),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirmar')),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
