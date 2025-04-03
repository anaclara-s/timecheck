import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String toDateString() => DateFormat('yyyy-MM-dd').format(this);

  String toTimeString() => DateFormat('HH:mm:ss').format(this);

  String toReadableString() => DateFormat('dd/MM/yyyy HH:mm').format(this);

  String toDayMonthYearString() => DateFormat('dd/MM/yyyy').format(this);
}
