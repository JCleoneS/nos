import 'package:flutter/material.dart';
import 'storage_helper.dart';
import 'calendar_widget.dart';
import 'tempo_juntos.dart';

class NosPage extends StatefulWidget {
  const NosPage({super.key});

  @override
  State<NosPage> createState() => _NosPageState();
}

class _NosPageState extends State<NosPage> {
  DateTime? dataSelecionada;
  DateTime mesSelecionado = DateTime.now();

  Future<void> carregarData() async {
    DateTime? data = await StorageHelper.carregarData();
    setState(() {
      dataSelecionada = data ?? DateTime.now();
      mesSelecionado = DateTime(dataSelecionada!.year, dataSelecionada!.month);
    });
  }

  Future<void> selecionarMes(BuildContext context) async {
    DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: mesSelecionado,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale("pt", "BR"),
    );

    if (novaData != null) {
      await StorageHelper.salvarData(novaData);
      setState(() {
        mesSelecionado = DateTime(novaData.year, novaData.month);
        dataSelecionada = novaData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    carregarData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nós")),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Center(
            child: Text(
              dataSelecionada != null
                  ? TempoJuntos.calcularTempo(dataSelecionada!)
                  : "Carregando...",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              dataSelecionada != null
                  ? TempoJuntos.calcularBoda(dataSelecionada!)
                  : "Carregando...",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              dataSelecionada != null
                  ? TempoJuntos.calcularProximaBoda(dataSelecionada!)
                  : "Carregando...",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: Center( // 🔥 Centralizando o calendário na tela
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 🔥 Garantindo posição centralizada verticalmente
                children: [
                  CalendarWidget(
                    key: ValueKey(mesSelecionado),
                    selectedDay: mesSelecionado,
                    highlightedDay: dataSelecionada,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => selecionarMes(context),
                child: const Text("Nossa Data"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}