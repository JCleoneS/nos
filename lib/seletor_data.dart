import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeletorData {
  static Future<DateTime?> selecionarData(BuildContext context, DateTime? dataAtual) async {
    DateTime hoje = DateTime.now();
    DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: dataAtual ?? hoje,
      firstDate: DateTime(1900),
      lastDate: hoje, // Bloqueia datas futuras
    );

    // Verifica se a data selecionada é no futuro
    if (novaData != null && novaData.isAfter(hoje)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Data inválida"),
            content: const Text("Você não pode escolher uma data no futuro!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return null; // Retorna `null` para impedir a seleção
    }

    return novaData; // Retorna a data válida
  }

  static Future<void> salvarData(DateTime data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("dataInicio", data.toIso8601String());
    print("✅ Data salva com sucesso: ${data.toIso8601String()}");
  }
}