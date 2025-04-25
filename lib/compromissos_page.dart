import 'package:flutter/material.dart';
import 'seletor_data.dart';
import 'storage_helper.dart';
import 'compromisso_model.dart';
import 'popup_compromisso.dart';

class CompromissosPage extends StatefulWidget {
  const CompromissosPage({super.key});

  @override
  State<CompromissosPage> createState() => _CompromissosPageState();
}

class _CompromissosPageState extends State<CompromissosPage> {
  DateTime? dataSelecionada;
  List<Compromisso> compromissos = [];

  @override
  void initState() {
    super.initState();
    carregarCompromissos();
  }

  Future<void> carregarCompromissos() async {
    List<Compromisso> lista = await StorageHelper.carregarCompromissos();

    lista.sort((a, b) {
      DateTime dateA = DateTime.parse(a.data).add(Duration(
          hours: int.parse(a.hora.split(":")[0]), minutes: int.parse(a.hora.split(":")[1])));
      DateTime dateB = DateTime.parse(b.data).add(Duration(
          hours: int.parse(b.hora.split(":")[0]), minutes: int.parse(b.hora.split(":")[1])));

      return dateA.compareTo(dateB);
    });

    setState(() {
      compromissos = lista;
    });
  }

  Future<void> selecionarData(BuildContext context) async {
    DateTime? novaData = await SeletorData.selecionarDataFutura(context, DateTime.now());

    if (novaData != null) {
      setState(() {
        dataSelecionada = novaData;
      });

      abrirPopupCompromisso(context, novaData);
    }
  }

  void abrirPopupCompromisso(BuildContext context, DateTime data, {int? index}) {
    Compromisso? compromissoExistente = index != null ? compromissos[index] : null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupCompromisso(
          data: data,
          compromisso: compromissoExistente,
          onSalvar: (Compromisso compromissoAtualizado) async {
            if (compromissoAtualizado.descricao.trim().isEmpty) {
              // 🔥 Exibe um aviso amigável para o usuário antes da tentativa de criação
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("❌ É preciso colocar uma descrição para o compromisso."),
                  backgroundColor: Colors.redAccent,
                ),
              );
              return;
            }

            if (index == null) {
              await StorageHelper.salvarCompromisso(compromissoAtualizado);
            } else {
              await StorageHelper.atualizarCompromisso(index, compromissoAtualizado);
            }
            carregarCompromissos();
          },
          onExcluir: () async {
            if (index != null) {
              await StorageHelper.excluirCompromisso(index);
              carregarCompromissos();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Compromissos")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: compromissos.length,
              itemBuilder: (context, index) {
                final compromisso = compromissos[index];
                return GestureDetector(
                  onTap: () => abrirPopupCompromisso(context, DateTime.parse(compromisso.data), index: index),
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(compromisso.descricao),
                      subtitle: Text("📅 ${compromisso.dataFormatada}\n📍 ${compromisso.local}\n⏰ ${compromisso.hora}"),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => selecionarData(context),
                  child: Row(
                    children: const [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text("Novo compromisso", textAlign: TextAlign.left),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}