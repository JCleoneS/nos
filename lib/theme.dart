import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.purpleAccent, // Cor principal do app
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFD1B3FF), // Roxo suave e delicado
      foregroundColor: Colors.white, // Ícones e textos brancos
      elevation: 4, // Sombra leve para destaque
      titleTextStyle: TextStyle(
        color: Colors.white, // Mantém o título branco para contraste
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.purpleAccent,
      secondary: Colors.pinkAccent,
      background: Colors.white, // Fundo da tela deve ser branco
      surface: Colors.white, // Certifica que elementos como Scaffold fiquem brancos
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade200), // Cinza ainda mais suave
        foregroundColor: MaterialStateProperty.all(Colors.black), // Texto preto para contraste
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black, // Mantém o texto preto
        fontSize: 18, // Agora está dois níveis acima do tamanho padrão do botão
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}