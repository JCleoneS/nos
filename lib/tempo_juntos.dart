class TempoJuntos {
  static final Map<int, String> bodasNomes = {
    1: "Papel", 2: "Algodão", 3: "Couro", 4: "Flores", 5: "Madeira",
    6: "Perfume", 7: "Latão", 8: "Papoula", 9: "Cerâmica", 10: "Estanho",
    11: "Aço", 12: "Seda", 15: "Cristal", 20: "Porcelana", 25: "Prata",
    30: "Pérola", 40: "Rubi", 50: "Ouro", 60: "Diamante"
  };

  static String calcularTempo(DateTime dataInicio) {
    DateTime hoje = DateTime.now();
    Duration diferenca = hoje.difference(dataInicio);

    int anos = (diferenca.inDays / 365).floor();
    int meses = ((diferenca.inDays % 365) / 30).floor();
    int dias = (diferenca.inDays % 30);

    if (anos > 0) {
      return "Juntos há $anos ${anos == 1 ? 'Ano' : 'Anos'}";
    } else if (meses > 0) {
      return "Juntos há $meses ${meses == 1 ? 'Mês' : 'Meses'}";
    } else {
      return "Juntos há $dias ${dias == 1 ? 'Dia' : 'Dias'}";
    }
  }

  static String calcularBoda(DateTime dataInicio) {
    DateTime hoje = DateTime.now();
    Duration diferenca = hoje.difference(dataInicio);

    int anos = (diferenca.inDays / 365).floor();
    int meses = ((diferenca.inDays % 365) / 30).floor();

    String nomeBoda = bodasNomes[anos > 0 ? anos : meses] ?? "Especial 💖";
    String tempo = anos >= 1
        ? "$anos ${anos == 1 ? 'Ano' : 'Anos'}"
        : "$meses ${meses == 1 ? 'Mês' : 'Meses'}";

    return "Estamos na bodas de: $nomeBoda ($tempo)";
  }

  static String calcularProximaBoda(DateTime dataInicio) {
    DateTime hoje = DateTime.now();
    Duration diferenca = hoje.difference(dataInicio);

    int anos = (diferenca.inDays / 365).floor();
    int meses = ((diferenca.inDays % 365) / 30).floor();

    int proximoMarco = anos >= 1 ? anos + 1 : meses + 1;
    String proximaBoda = bodasNomes[proximoMarco] ?? "Especial 💖";

    return "Próxima boda: $proximaBoda";
  }
}