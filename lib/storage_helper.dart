import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'compromisso_model.dart';

class StorageHelper {
  static Future<void> salvarData(DateTime data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("dataInicio", data.toIso8601String());
  }

  static Future<DateTime?> carregarData() async {
    final prefs = await SharedPreferences.getInstance();
    String? dataSalva = prefs.getString("dataInicio");

    if (dataSalva != null) {
      return DateTime.parse(dataSalva);
    }
    return null;
  }

  // 🔥 Método para salvar compromissos
  static Future<void> salvarCompromisso(Compromisso compromisso) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> compromissosSalvos = prefs.getStringList("compromissos") ?? [];

    compromissosSalvos.add(jsonEncode(compromisso.toMap()));
    await prefs.setStringList("compromissos", compromissosSalvos);
  }

  // 🔥 Método corrigido para carregar compromissos
  static Future<List<Compromisso>> carregarCompromissos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> compromissosSalvos = prefs.getStringList("compromissos") ?? [];

    return compromissosSalvos.map((compromissoJson) {
      try {
        final Map<String, dynamic> mapaDinamico = jsonDecode(compromissoJson);
        final Map<String, String> mapaConvertido =
        mapaDinamico.map((key, value) => MapEntry(key.toString(), value.toString()));
        return Compromisso.fromMap(mapaConvertido);
      } catch (e) {
        return Compromisso(data: "", descricao: "Erro ao carregar compromisso", local: "", hora: "");
      }
    }).toList();
  }

  // 🔥 Método para excluir compromissos
  static Future<void> excluirCompromisso(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> compromissosSalvos = prefs.getStringList("compromissos") ?? [];

    if (index >= 0 && index < compromissosSalvos.length) {
      compromissosSalvos.removeAt(index);
      await prefs.setStringList("compromissos", compromissosSalvos);
    }
  }

  // 🔥 Método para atualizar compromissos
  static Future<void> atualizarCompromisso(int index, Compromisso compromissoAtualizado) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> compromissosSalvos = prefs.getStringList("compromissos") ?? [];

    if (index >= 0 && index < compromissosSalvos.length) {
      compromissosSalvos[index] = jsonEncode(compromissoAtualizado.toMap());
      await prefs.setStringList("compromissos", compromissosSalvos);
    }
  }
}