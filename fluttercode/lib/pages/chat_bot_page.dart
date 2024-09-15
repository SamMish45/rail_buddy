import 'package:flutter/material.dart';
import '../widgets/brightness_button.dart';
import '../widgets/bottom_navigation.dart';

class ChatBotPage extends StatelessWidget {
  final Function(bool) toggleTheme;

  const ChatBotPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        actions: [
          BrightnessButton(toggleTheme: toggleTheme),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(child: Text('Chat with our AI assistant')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Ask something...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 3, // Chat Bot Page
      ),
    );
  }
}
