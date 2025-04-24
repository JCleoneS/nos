import 'package:shared_preferences/shared_preferences.dart';

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
}