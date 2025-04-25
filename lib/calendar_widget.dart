import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime? highlightedDay;

  const CalendarWidget({super.key, required this.selectedDay, this.highlightedDay});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final List<String> diasSemana = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"];

  @override
  Widget build(BuildContext context) {
    int totalDays = DateTime(widget.selectedDay.year, widget.selectedDay.month + 1, 0).day;
    int firstWeekday = DateTime(widget.selectedDay.year, widget.selectedDay.month, 1).weekday;

    return Column(
      children: [
        // 🔥 Adicionando nomes dos dias da semana
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: diasSemana.map((dia) => Text(
              dia,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )).toList(),
          ),
        ),
        // 🔥 Grid com os dias do mês, respeitando o dia inicial correto
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalDays + (firstWeekday - 1), // 🔥 Ajustamos o total de itens para incluir espaços vazios antes do primeiro dia
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // Mantendo 7 colunas para cada dia da semana
          ),
          itemBuilder: (context, index) {
            // 🔥 Ajustando para que o primeiro dia do mês apareça na posição correta
            if (index < firstWeekday - 1) {
              return const SizedBox(); // 🔥 Espaço vazio antes do primeiro dia do mês
            }

            int dayNumber = index - (firstWeekday - 2); // 🔥 Correção para calcular corretamente os dias

            DateTime currentDay = DateTime(widget.selectedDay.year, widget.selectedDay.month, dayNumber);
            bool isHighlighted = widget.highlightedDay != null &&
                currentDay.year == widget.highlightedDay!.year &&
                currentDay.month == widget.highlightedDay!.month &&
                currentDay.day == widget.highlightedDay!.day;

            return Container(
              margin: const EdgeInsets.all(4),
              decoration: isHighlighted
                  ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 2),
              )
                  : null,
              child: Center(
                child: Text(
                  "$dayNumber",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}