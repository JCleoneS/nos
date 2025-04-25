import 'package:flutter/material.dart';
import 'seletor_data.dart';
import 'storage_helper.dart';
import 'compromissos_page.dart';
import 'nos_page.dart';
import 'fotos_page.dart'; // 🔥 Importando a nova página de fotos

class MenuDrawer extends StatelessWidget {
  final DateTime? dataSelecionada;
  final Function(DateTime) atualizarData;

  const MenuDrawer({super.key, required this.dataSelecionada, required this.atualizarData});

  Future<void> selecionarData(BuildContext context) async {
    DateTime? novaData = await SeletorData.selecionarDataPassada(context, dataSelecionada ?? DateTime.now());
    if (novaData != null) {
      await StorageHelper.salvarData(novaData);
      atualizarData(novaData);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color corFundoMenu = Color.alphaBlend(
      Colors.black.withOpacity(0.25),
      Theme.of(context).appBarTheme.backgroundColor ?? Colors.blueAccent, // 🔥 Verificação de nulidade
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
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
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NosPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.people),
                    SizedBox(width: 10),
                    Text("Nós"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CompromissosPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.event),
                    SizedBox(width: 10),
                    Text("Compromissos"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FotosPage()), // 🔥 Navegação para a nova tela de fotos
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.photo_album),
                    SizedBox(width: 10),
                    Text("Fotos"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}