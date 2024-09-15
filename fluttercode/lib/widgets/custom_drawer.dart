import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('RailBuddy Menu'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('AI Ticket Analyzer'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ai_ticket_analyzer');
            },
          ),
          ListTile(
            title: const Text('Disability Support'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/disability');
            },
          ),
          ListTile(
            title: const Text('ChatBot'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/chat_bot');
            },
          ),
        ],
      ),
    );
  }
}
