class ReportRecordModel {
  final int id;
  final DateTime date;
  final String type;
  final DateTime time;
  final String recordType;
  final String? location;
  final int changesCount;
  ReportRecordModel({
    required this.id,
    required this.date,
    required this.type,
    required this.time,
    required this.recordType,
    this.location,
    required this.changesCount,
  });

  factory ReportRecordModel.fromJson(Map<String, dynamic> json) {
    try {
      final date = DateTime.parse(json['data']);
      final timeParts = (json['horario'] as String).split(':');
      final time = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
        int.parse(timeParts[2]),
      );

      return ReportRecordModel(
        id: json['id'],
        date: date,
        type: json['tipo'] ?? 'desconhecido',
        time: time,
        recordType: json['tipo_registro'],
        location: json['local'],
        changesCount: json['alteracoes'] ?? 0,
      );
    } catch (e) {
      throw FormatException('Failed to parse record: ${e.toString()}');
    }
  }

  String get formattedDate => '${date.day}/${date.month}/${date.year}';

  String get formattedTime =>
      '${time.hour}:${time.minute.toString().padLeft(2, '0')}';

  String get formattedType {
    switch (recordType) {
      case 'entrada':
        return 'Entrada';
      case 'saida_intervalo':
        return 'Início Intervalo';
      case 'volta_intervalo':
        return 'Fim Intervalo';
      case 'saida_final':
        return 'Saída';
      default:
        return recordType;
    }
  }
}
