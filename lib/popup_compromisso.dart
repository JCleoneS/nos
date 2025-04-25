import 'package:flutter/material.dart';
import 'compromisso_model.dart';

class PopupCompromisso extends StatefulWidget {
  final Compromisso? compromisso;
  final DateTime data;
  final Function(Compromisso) onSalvar;
  final Function onExcluir;

  const PopupCompromisso({
    super.key,
    required this.data,
    required this.onSalvar,
    required this.onExcluir,
    this.compromisso,
  });

  @override
  State<PopupCompromisso> createState() => _PopupCompromissoState();
}

class _PopupCompromissoState extends State<PopupCompromisso> {
  late TextEditingController descricaoController;
  late TextEditingController localController;
  late TextEditingController horaController;

  @override
  void initState() {
    super.initState();
    descricaoController = TextEditingController(text: widget.compromisso?.descricao ?? "");
    localController = TextEditingController(text: widget.compromisso?.local ?? "");
    horaController = TextEditingController(text: widget.compromisso?.hora.replaceAll(":", "") ?? "");
  }

  bool validarHora(String hora) {
    if (hora.length != 4 || int.tryParse(hora) == null) return false;

    int horas = int.parse(hora.substring(0, 2));
    int minutos = int.parse(hora.substring(2, 4));

    return horas >= 0 && horas < 24 && minutos >= 0 && minutos < 60;
  }

  void atualizarHora(String texto) {
    String entrada = texto.replaceAll(RegExp(r'[^0-9]'), ''); // 🔥 Remove caracteres inválidos

    if (entrada.length > 4) entrada = entrada.substring(0, 4); // 🔥 Limita a 4 dígitos

    if (entrada.length > 2) {
      entrada = "${entrada.substring(0, 2)}:${entrada.substring(2)}"; // 🔥 Insere ":" no lugar correto
    }

    setState(() {
      horaController.text = entrada;
      horaController.selection = TextSelection.fromPosition(TextPosition(offset: entrada.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.compromisso == null ? "Novo compromisso" : "Editar compromisso"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: descricaoController, decoration: const InputDecoration(labelText: "Descrição")),
          TextField(controller: localController, decoration: const InputDecoration(labelText: "Local")),
          TextField(
            controller: horaController,
            keyboardType: TextInputType.number, // 🔥 Apenas números
            maxLength: 5, // 🔥 Máximo de 5 caracteres (inclui ":")
            decoration: const InputDecoration(labelText: "Hora", counterText: ""), // 🔥 Remove contador "0/5"
            onChanged: atualizarHora, // 🔥 Atualiza e adiciona ":" automaticamente
          ),
        ],
      ),
      actions: [
        if (widget.compromisso != null)
          TextButton(
            onPressed: () {
              widget.onExcluir();
              Navigator.pop(context);
            },
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
        TextButton(
          onPressed: () {
            if (!validarHora(horaController.text.replaceAll(":", ""))) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Horário inválido!")));
              return;
            }
            widget.onSalvar(Compromisso(
              data: widget.data.toIso8601String().split("T")[0],
              descricao: descricaoController.text,
              local: localController.text,
              hora: horaController.text, // 🔥 Hora já formatada
            ));
            Navigator.pop(context);
          },
          child: const Text("Salvar"),
        ),
      ],
    );
  }
}