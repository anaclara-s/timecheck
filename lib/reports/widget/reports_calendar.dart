import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

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
          markerBuilder: (context, date, events) {
            if (widget.markedDates
                .any((markedDate) => isSameDay(markedDate, date))) {
              return Positioned(
                right: 1,
                bottom: 1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(73, 0, 255, 64),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
            return null;
          },
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            // border: Border.all(color: const Color.fromARGB(255, 11, 64, 179)),
            borderRadius: BorderRadius.circular(8),
          ),
          // formatButtonTextStyle:
          //     const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: Color.fromARGB(255, 243, 110, 33),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
