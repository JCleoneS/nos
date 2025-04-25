import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'menu_drawer.dart'; // 🔥 Importando o menu novamente

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nós',
      theme: ThemeData.light(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      home: const DeclaracoesPage(), // 🔥 Página inicial com declarações e menu
    );
  }
}

class DeclaracoesPage extends StatefulWidget {
  const DeclaracoesPage({super.key});

  @override
  State<DeclaracoesPage> createState() => _DeclaracoesPageState();
}

class _DeclaracoesPageState extends State<DeclaracoesPage> {
  final List<Map<String, String>> declaracoes = [
    {
      "texto": "Sabe por que eu te amo?\n\nPorque eu já vivi sem você.\nJá fui feliz antes de te conhecer.\nJá tive momentos bons sem sua presença.\n\nMas nada, nada se compara ao que é ter você por perto...\nNão é que eu precise de você para viver, é que agora que conheci a vida contigo, qualquer coisa sem isso parece menos intensa.\nEu já soube ser feliz sozinho, mas eu quero ser feliz com você.\n\nEu te amo porque você é incrível, porque você é você, e você é o meu amor.\n\nTe amo, princesa!",
      "assinatura": "JCPS",
      "data": "27.03.2025 - 15:58"
    },
    {
      "texto": "Hoje começa nossa 'Primeira' competição... Sinto muito ter de mostrar a você que eu te amo muito, muito mais do que pode imaginar!\n\nSabe por que eu sei que te amo mais?\n01. Porque eu acordo pensando em você todos os dias.\n02. Porque já me vi morando com você.\n03. Porque amo cuidar de você.\n04. Porque sinto que posso fazer qualquer coisa por você.\n05. Amo ver o universo nos seus olhos.\n06. Me apaixono pelos seus beijos todas as vezes que seus lábios tocam os meus.\n07. Gosto dos seus pensamentos.\n08. Seu corpo é como as notas de uma música de amor.\n09. O seu tom de voz é como um abraço.\n10. Teu abraço é tão confortável que me faz querer dormir às vezes, kkkkk.\n\nSinto muito, meu amor, eu quero você para sempre.\n\nEu amo você com todo o meu coração, toda minha saúde, toda minha fé, todo o meu corpo, toda a minha alma e todo o meu amor.\n\nVocê é incrível!",
      "assinatura": "JCPS",
      "data": "19.03.2025 - 15:40"
    },
    {
      "texto": "Vou tentar explicar aqui um pouco do que sinto por você, mas antes disso, um ponto muito importante!\nNão ligue para os erros! 😆\n\nAlgumas psicologias dizem que o amor é uma ilusão, que o que sentimos por alguém um dia irá passar.\nQue, em algum momento, esse sentimento deixará de existir, e veremos que tudo não passa de uma ilusão passageira.\n\nEu não poderia discordar mais.\nComo gostar de você pode ser um erro?\nComo a alegria que sinto ao ver você pode ser ilusão?\nComo querer ter uma vida com você pode ser um erro?\nComo querer estar com você para sempre pode ser passageiro?\n\nVou te dizer: não importam os momentos ruins, os dias chuvosos, as noites frias, os dias sem cor,\na distância entre nós dois, os problemas que estão por vir, os traumas que já passou,\nas decepções que sofremos...\n\nEu quero estar com você, apoiar, abraçar, beijar, cheirar, apertar e amar você para sempre!\n\nVocê é incrível!",
      "assinatura": "JCPS",
      "data": "03.03.2025 - 22:32"
    }
  ];

  int _indiceAtual = 0;
  late Timer _timer;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _trocarTextoAutomaticamente();
  }

  void _trocarTextoAutomaticamente() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) { // 🔥 Alterado para 2 minutos
      setState(() {
        _opacity = 0.0;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _indiceAtual = (_indiceAtual + 1) % declaracoes.length;
          _opacity = 1.0;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Declarações")),
      drawer: MenuDrawer(dataSelecionada: DateTime.now(), atualizarData: (_) {}), // 🔥 Menu reintegrado
      body: SingleChildScrollView( // 🔥 Envolvendo em um ScrollView para evitar problemas de layout
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 🔥 Alinhado à esquerda
              children: [
                Text(
                  declaracoes[_indiceAtual]["texto"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // 🔥 Destaque no texto
                    color: Colors.black,
                    shadows: [Shadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 3)], // 🔥 Contorno suave
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  declaracoes[_indiceAtual]["assinatura"]!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  declaracoes[_indiceAtual]["data"]!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}