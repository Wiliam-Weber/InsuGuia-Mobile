import 'package:flutter/material.dart';
import 'screen/splash_screen.dart'; // Importa a tela de splash

void main() {
  runApp(const InsuGuiaApp());
}

class InsuGuiaApp extends StatelessWidget {
  const InsuGuiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color corPrimaria = Colors.blue;
    // Cor de fundo clara
    const Color corDeFundo = Color(0xFFF4F6F8);
    // Cor de superfície (dos cards e campos de texto)
    const Color corSuperficie = Colors.white;

    return MaterialApp(
      title: 'InsuGuia Mobile',
      theme: ThemeData(
        useMaterial3: true, // Habilita o design Material 3
        
        // Geramos o esquema de cores
        colorScheme: ColorScheme.fromSeed(
          seedColor: corPrimaria,
          surface: corSuperficie, // Cor dos Cards
          background: corDeFundo, // Cor de Fundo
        ),
        
        // Cor de fundo padrão para todos os Scaffolds
        scaffoldBackgroundColor: corDeFundo,
        
        // Define o tema para todos os AppBars
        appBarTheme: const AppBarTheme(
          backgroundColor: corPrimaria,
          foregroundColor: Colors.white, 
          elevation: 2,
        ),

        // ------ CORREÇÃO APLICADA AQUI ------
        // O construtor está limpo, sem os comentários que causei.
        cardTheme: CardThemeData(
          elevation: 1, 
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // O Card agora usará a cor 'surface' (Colors.white)
          // definida no ColorScheme acima.
        ),
        // ------------------------------------

        // Define o tema para todos os campos de input
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: corSuperficie, // Usa a mesma cor 'surface'
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none, // Sem borda
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),

        // Define o tema para os botões principais
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: corPrimaria,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const SplashScreen(), // Inicia na SplashScreen
    );
  }
}

// Backwards-compatible alias used by some tests/examples
class MyApp extends InsuGuiaApp {
  const MyApp({super.key});
}