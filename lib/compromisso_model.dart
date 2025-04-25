class Compromisso {
  final String data;
  final String descricao;
  final String local;
  final String hora;

  Compromisso({
    required this.data,
    required this.descricao,
    required this.local,
    required this.hora,
  });

  String get dataFormatada {
    DateTime parsedDate = DateTime.parse(data);
    return "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}";
  }

  Map<String, String> toMap() {
    return {
      "data": data,
      "descricao": descricao,
      "local": local,
      "hora": hora,
    };
  }

  static Compromisso fromMap(Map<String, String> map) {
    return Compromisso(
      data: map["data"] ?? "",
      descricao: map["descricao"] ?? "",
      local: map["local"] ?? "",
      hora: map["hora"] ?? "",
    );
  }
}