import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../shared/extencions/format_date_extension.dart';

class ReportsCalendarWidget extends StatefulWidget {
  final DateTime? selectedDay;
  final Function(DateTime) onDaySelected;
  final List<DateTime> markedDates;

  const ReportsCalendarWidget({
    Key? key,
    this.selectedDay,
    required this.onDaySelected,
    required this.markedDates,
  }) : super(key: key);

  @override
  _ReportsCalendarWidgetState createState() => _ReportsCalendarWidgetState();
}

class _ReportsCalendarWidgetState extends State<ReportsCalendarWidget> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    _firstDay = DateTime(now.year - 1);
    _lastDay = DateTime(now.year + 1);
    _selectedDay = widget.selectedDay ?? now;
    _focusedDay = widget.selectedDay ?? now;

    if (_focusedDay.isBefore(_firstDay)) {
      _focusedDay = _firstDay;
    } else if (_focusedDay.isAfter(_lastDay)) {
      _focusedDay = _lastDay;
    }

    _calendarFormat = CalendarFormat.week;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeDateFormatting('pt_BR');
    });
  }

  @override
  void didUpdateWidget(ReportsCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDay != oldWidget.selectedDay &&
        widget.selectedDay != null) {
      _selectedDay = widget.selectedDay!;
      _focusedDay = widget.selectedDay!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: TableCalendar(
        locale: 'pt_BR',
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          widget.onDaySelected(selectedDay);
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            return Center(
              child: Text(
                day.toShortWeekday()[0],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          markerBuilder: (context, date, events) {
            if (widget.markedDates
                .any((markedDate) => isSameDay(markedDate, date))) {
              return Positioned(
                top: 1,
                bottom: 1,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(72, 105, 185, 125),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
            return null;
          },
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Mês',
          CalendarFormat.twoWeeks: '2 Semanas',
          CalendarFormat.week: 'Semana'
        },
        headerStyle: HeaderStyle(
          titleTextFormatter: (date, _) =>
              date.toFullMonthNamesString() + ' ' + date.year.toString(),
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(137, 11, 64, 179),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 102, 255),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: const Color.fromARGB(141, 0, 140, 255),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
