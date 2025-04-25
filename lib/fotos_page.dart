import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FotosPage extends StatefulWidget {
  const FotosPage({super.key});

  @override
  State<FotosPage> createState() => _FotosPageState();
}

class _FotosPageState extends State<FotosPage> {
  List<File> fotosSalvas = [];
  List<File> fotosSelecionadas = [];
  bool modoSelecaoAtivo = false;

  @override
  void initState() {
    super.initState();
    carregarFotosSalvas();
  }

  Future<void> carregarFotosSalvas() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> arquivos = directory.listSync();

    setState(() {
      fotosSalvas = arquivos.whereType<File>().where((file) => file.existsSync()).toList();
    });
  }

  Future<void> abrirFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada = await picker.pickImage(source: ImageSource.gallery);

    if (imagemSelecionada != null) {
      final File novaFoto = await salvarFotoLocalmente(File(imagemSelecionada.path));
      setState(() {
        fotosSalvas.add(novaFoto);
      });
    }
  }

  Future<File> salvarFotoLocalmente(File foto) async {
    final directory = await getApplicationDocumentsDirectory();
    final String novoCaminho = "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png";
    return foto.copy(novoCaminho);
  }

  void ativarModoSelecao() {
    setState(() {
      modoSelecaoAtivo = !modoSelecaoAtivo;
      fotosSelecionadas.clear();
    });
  }

  void selecionarOuRemoverFoto(File foto) {
    setState(() {
      if (fotosSelecionadas.contains(foto)) {
        fotosSelecionadas.remove(foto);
      } else {
        fotosSelecionadas.add(foto);
      }
    });
  }

  Future<void> excluirFotosSelecionadas() async {
    for (File foto in fotosSelecionadas) {
      if (foto.existsSync()) {
        await foto.delete();
      }
    }
    setState(() {
      fotosSalvas.removeWhere((foto) => !foto.existsSync());
      fotosSelecionadas.clear();
      modoSelecaoAtivo = false;
    });
  }

  void abrirImagemTelaCheia(File foto) {
    if (modoSelecaoAtivo) {
      selecionarOuRemoverFoto(foto);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text("Imagem", style: TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    excluirFotosSelecionadas();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Center(
              child: foto.existsSync()
                  ? Image.file(foto, fit: BoxFit.contain)
                  : const Icon(Icons.error, color: Colors.white, size: 100),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fotos"),
        actions: modoSelecaoAtivo
            ? [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: excluirFotosSelecionadas,
          ),
        ]
            : [],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: abrirFoto,
                  child: const Text("Abrir Foto"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: ativarModoSelecao,
                  child: Text(modoSelecaoAtivo ? "Cancelar Seleção" : "Selecionar Foto"),
                ),
              ],
            ),
          ),
          Expanded(
            child: fotosSalvas.isEmpty
                ? const Center(child: Text("Nenhuma foto salva 📸"))
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: fotosSalvas.length,
              itemBuilder: (context, index) {
                File foto = fotosSalvas[index];
                return GestureDetector(
                  onTap: () => abrirImagemTelaCheia(foto),
                  child: foto.existsSync()
                      ? Image.file(foto, fit: BoxFit.cover)
                      : const Icon(Icons.error, color: Colors.red, size: 100),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}