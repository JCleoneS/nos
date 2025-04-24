import 'dart:async';

class TempoJuntos {
  static String calcularTempo(DateTime dataInicio) {
    DateTime hoje = DateTime.now();
    Duration diferenca = hoje.difference(dataInicio);

    int anos = (diferenca.inDays / 365).floor();
    int meses = ((diferenca.inDays % 365) / 30).floor();
    int dias = (diferenca.inDays % 30);

    if (anos > 0) {
      return "Juntos há $anos ${anos == 1 ? "ano" : "anos"}";
    } else if (meses > 0) {
      return "Juntos há $meses ${meses == 1 ? "mês" : "meses"}";
    } else {
      return "Juntos há $dias ${dias == 1 ? "dia" : "dias"}";
    }
  }
}