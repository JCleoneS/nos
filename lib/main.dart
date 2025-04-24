import 'package:flutter/material.dart';
import 'storage_helper.dart';
import 'tempo_juntos.dart';
import 'theme.dart';
import 'menu_drawer.dart';
import 'calendar_widget.dart'; // Importando o widget do calendário

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nós',
      theme: AppTheme.lightTheme,
      home: const MyHomePage(title: 'Nós'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? dataSelecionada;

  Future<void> carregarData() async {
    DateTime? data = await StorageHelper.carregarData();
    if (data != null) {
      setState(() {
        dataSelecionada = data;
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Center(
          child: Text(
            "Nós",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: MenuDrawer(
        dataSelecionada: dataSelecionada,
        atualizarData: (novaData) {
          setState(() {
            dataSelecionada = novaData;
          });
        },
      ),
      body: SingleChildScrollView( // Evita erro de RenderFlex overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Center(
              child: Text(
                dataSelecionada != null
                    ? TempoJuntos.calcularTempo(dataSelecionada!)
                    : "Selecione a data de início",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 20),
            if (dataSelecionada != null) // Exibe o calendário apenas se a data foi escolhida
              CalendarWidget(
                selectedDay: dataSelecionada!, // Agora passando o dia exato escolhido
              ),
          ],
        ),
      ),
    );
  }
}