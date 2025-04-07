import 'package:flutter/material.dart';

import '../../core/services/api_service.dart';
import '../../core/services/reports_service.dart';
import '../../shared/extencions/format_date_extension.dart';
import '../../shared/models/report_record_model.dart';

class ReportsListWidget extends StatelessWidget {
  final List<ReportRecordModel> records;
  final DateTime selectedDate;
  final Function(ReportRecordModel, TimeOfDay)? onTimeChanged;
  final ReportsService reportsService;

  const ReportsListWidget({
    Key? key,
    required this.records,
    required this.selectedDate,
    this.onTimeChanged,
    required this.reportsService,
  }) : super(key: key);

  Future<void> _showTimeChangeDialog(
      BuildContext context, ReportRecordModel record) async {
    try {
      if (record.changesCount >= 2) {
        _showMaxChangesReached(context);
        return;
      }

      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => _buildConfirmationDialog(context, record),
      );

      if (confirm != true) return;

      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(record.time),
      );

      if (newTime != null) {
        // Adicionando log antes da chamada
        debugPrint(
            'Tentando atualizar registro ${record.id} para ${newTime.format(context)}');

        await reportsService.updateRecordTime(record.id, newTime);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Horário atualizado com sucesso!'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } on ApiException catch (e) {
      debugPrint('Erro na API: ${e.toString()}');

      final isMaxLimitError =
          e.message.contains('Limite de alterações atingido');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isMaxLimitError
                ? 'Limite de alterações atingido'
                : 'Erro: ${e.message}',
          ),
          backgroundColor: isMaxLimitError
              ? Colors.orange
              : const Color.fromARGB(255, 54, 73, 244),
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('Erro inesperado: $e');
      debugPrint('Stack trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Erro ao atualizar horário'),
          backgroundColor: const Color.fromARGB(255, 152, 54, 244),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _showMaxChangesReached(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Este registro já foi alterado o máximo de vezes permitido (2 vezes)'),
        duration: Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildConfirmationDialog(
      BuildContext context, ReportRecordModel record) {
    return AlertDialog(
      title: const Text('Alterar horário'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Deseja alterar o horário desta marcação?'),
          if (record.changesCount > 0) ...[
            const SizedBox(height: 8),
            Text(
              'Você já alterou este registro ${record.changesCount} vez(es)',
              style: TextStyle(
                color: Colors.orange[800],
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }

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
              'Nenhum registro encontrado para ${selectedDate.toDayMonthYearString()}',
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
            '${records.first.date.toWeekdayNamesString()}, ${records.first.date.day} de ${records.first.date.toFullMonthNamesString()} de ${records.first.date.year}',
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
                  leading: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () => _showTimeChangeDialog(context, record),
                  ),
                  title: Text(record.formattedType),
                  subtitle: Text(record.date.toDayMonthYearString()),
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
