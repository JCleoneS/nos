import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeletorData {
  // 🔥 Método para selecionar apenas datas passadas (para "Nossa Data")
  static Future<DateTime?> selecionarDataPassada(BuildContext context, DateTime? dataAtual) async {
    DateTime hoje = DateTime.now();
    DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: (dataAtual != null && dataAtual.isAfter(hoje)) ? hoje : dataAtual ?? hoje,
      firstDate: DateTime(1900), // Permite qualquer data passada
      lastDate: hoje, // 🔥 Bloqueia datas futuras
    );
    return novaData;
  }

  // 🔥 Método para selecionar apenas datas futuras (para "Compromissos")
  static Future<DateTime?> selecionarDataFutura(BuildContext context, DateTime? dataAtual) async {
    DateTime hoje = DateTime.now();
    DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: (dataAtual != null && dataAtual.isBefore(hoje)) ? hoje : dataAtual ?? hoje,
      firstDate: hoje, // 🔥 Bloqueia datas passadas
      lastDate: DateTime(2100), // Permite qualquer data futura
    );
    return novaData;
  }

  // 🔥 Método para salvar a data
  static Future<void> salvarData(DateTime data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("dataInicio", data.toIso8601String());
    debugPrint("✅ Data salva com sucesso: ${data.toIso8601String()}");
  }
}