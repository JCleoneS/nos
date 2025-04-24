import 'package:flutter/material.dart';
import 'seletor_data.dart';
import 'storage_helper.dart';

class MenuDrawer extends StatelessWidget {
  final DateTime? dataSelecionada;
  final Function(DateTime) atualizarData;

  const MenuDrawer({super.key, required this.dataSelecionada, required this.atualizarData});

  Future<void> selecionarData(BuildContext context) async {
    DateTime? novaData = await SeletorData.selecionarData(context, dataSelecionada);
    if (novaData != null) {
      await StorageHelper.salvarData(novaData);
      atualizarData(novaData);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Criando um tom mais escuro baseado na cor da AppBar
    Color corFundoMenu = Color.alphaBlend(
      Colors.black.withOpacity(0.25),
      Theme.of(context).appBarTheme.backgroundColor!,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5, // Mantendo a largura proporcional
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              color: corFundoMenu,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16, top: 30),
              child: const Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(thickness: 1, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200], // Cinza claro
                  foregroundColor: Colors.black87, // Texto e ícone escuros para contraste
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.calendar_today),
                label: const Text("Início do namoro"),
                onPressed: () => selecionarData(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }