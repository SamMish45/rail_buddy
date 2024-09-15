import 'package:flutter/material.dart';
import '../widgets/brightness_button.dart';
import '../widgets/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  final Function(bool) toggleTheme;

  const HomePage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RailBuddy Home'),
        actions: [
          BrightnessButton(toggleTheme: toggleTheme),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Famous Railway Stations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Chennai'),
            trailing: const Text('MAS'),
          ),
          ListTile(
            title: const Text('Kolkata'),
            trailing: const Text('HWH'),
          ),
          ListTile(
            title: const Text('New Delhi'),
            trailing: const Text('NDLS'),
          ),
          ListTile(
            title: const Text('Test Station'),
            trailing: const Text('TEST'),
            onTap: () {
              Navigator.pushNamed(context, '/station_details');
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0, // Home Page
      ),
    );
  }
}
