import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/ai_ticket_analyzer_page.dart';
import 'pages/chat_bot_page.dart';
import 'pages/disability_page.dart';
import 'pages/station_details_page.dart';
import 'services/theme_service.dart'; // If you use a ThemeService, ensure it's linked here

void main() {
  runApp(const RailBuddyApp());
}

class RailBuddyApp extends StatefulWidget {
  const RailBuddyApp({super.key});

  @override
  State<RailBuddyApp> createState() => _RailBuddyAppState();
}

class _RailBuddyAppState extends State<RailBuddyApp> {
  ThemeMode _themeMode = ThemeMode.system; // Default theme mode

  // Toggle between Light and Dark mode
  void toggleTheme(bool isLightMode) {
    setState(() {
      _themeMode = isLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RailBuddy',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.blue, // Add any primary color to your theme
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode: _themeMode, // Current theme mode based on toggle
      initialRoute: '/', // Set login page as the initial route
      routes: {
        '/': (context) => LoginPage(toggleTheme: toggleTheme), // Login Page
        '/home': (context) => HomePage(toggleTheme: toggleTheme), // Home Page
        '/ai_ticket_analyzer': (context) => AiTicketAnalyzerPage(toggleTheme: toggleTheme), // AI Ticket Analyzer Page
        '/chat_bot': (context) => ChatBotPage(toggleTheme: toggleTheme), // Chat Bot Page
        '/disability': (context) => DisabilityPage(toggleTheme: toggleTheme), // Disability Page
        '/station_details': (context) => StationDetailsPage(toggleTheme: toggleTheme), // Station Details Page
      },
    );
  }
}
