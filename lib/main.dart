import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api_client.dart';
import 'core/storage_service.dart';
import 'core/theme_controller.dart';
import 'features/chat/chat_controller.dart';
import 'features/chat/chat_repository.dart';
import 'features/chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs: prefs);
  final apiClient = ApiClient();
  final chatRepository = ChatRepository(apiClient: apiClient);
  final themeController = ThemeController(storageService: storageService);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => themeController,
        ),
        ChangeNotifierProvider(
          create: (context) => ChatController(
            repository: chatRepository,
            storageService: storageService,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    
    return MaterialApp(
      title: 'Chatbot RAG - Richi',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: themeController.themeMode,
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  // Tema claro 
  ThemeData _buildLightTheme() {
    const primaryColor = Color(0xFF81C784); // Verde pastel medio
    const secondaryColor = Color(0xFFA5D6A7); // Verde pastel claro
    const accentColor = Color(0xFF66BB6A); // Verde menta
    const backgroundColor = Color(0xFFF1F8F4); // Verde muy claro casi blanco
    const surfaceColor = Color(0xFFFFFFFF);
    const bubbleAssistantColor = Color(0xFFE8F5E9); // Verde pastel muy claro para burbujas
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: backgroundColor,
        surface: surfaceColor,
        surfaceVariant: bubbleAssistantColor,
        onPrimary: Colors.white,
        onSecondary: const Color(0xFF2E7D32),
        onBackground: const Color(0xFF1B5E20),
        onSurface: const Color(0xFF2E7D32),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: surfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC8E6C9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC8E6C9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF66BB6A),
      ),
    );
  }

  // Tema oscuro
  ThemeData _buildDarkTheme() {
    const primaryColor = Color(0xFF81C784); // Verde pastel
    const secondaryColor = Color(0xFFA5D6A7); // Verde pastel claro
    const accentColor = Color(0xFF66BB6A); // Verde menta
    const backgroundColor = Color(0xFF1A2F23); // Verde oscuro profundo
    const surfaceColor = Color(0xFF263832); // Verde gris oscuro
    const bubbleAssistantColor = Color(0xFF2F4538); // Verde grisáceo para burbujas
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: backgroundColor,
        surface: surfaceColor,
        surfaceVariant: bubbleAssistantColor,
        onPrimary: const Color(0xFF1B5E20),
        onSecondary: const Color(0xFF1B5E20),
        onBackground: const Color(0xFFE8F5E9),
        onSurface: const Color(0xFFE8F5E9),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: surfaceColor,
        foregroundColor: Color(0xFFE8F5E9),
        iconTheme: IconThemeData(color: Color(0xFFE8F5E9)),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: surfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3D5A47)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3D5A47)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF81C784),
      ),
    );
  }
}