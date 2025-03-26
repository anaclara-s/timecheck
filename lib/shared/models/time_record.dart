class TimeRecordModel {
  final int id;
  final int employeeId;
  final String time;
  final String date;
  final String recordType;
  final String? location;

  TimeRecordModel({
    required this.id,
    required this.employeeId,
    required this.time,
    required this.date,
    required this.recordType,
    this.location,
  });

  factory TimeRecordModel.fromJson(Map<String, dynamic> json) {
    return TimeRecordModel(
      id: json['id'] as int,
      employeeId: json['id_funcionario'] as int,
      time: json['horario'] as String,
      date: json['data'] as String,
      recordType: json['tipo_registro'] as String,
      location: json['local'] as String?,
    );
  }
}
