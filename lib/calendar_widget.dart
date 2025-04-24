import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;

  const CalendarWidget({super.key, required this.selectedDay});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat formatoCalendario = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 01, 01),
        lastDay: DateTime.utc(2050, 12, 31),
        focusedDay: DateTime(widget.selectedDay.year, widget.selectedDay.month, 1),
        selectedDayPredicate: (day) => isSameDay(day, widget.selectedDay),
        calendarFormat: formatoCalendario,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronVisible: false,
          rightChevronVisible: false,
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Mês',
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 2), // Criando a argola vermelha
          ),
          selectedTextStyle: const TextStyle(color: Colors.black), // Mantendo o texto visível
        ),
      ),
    );
  }
}