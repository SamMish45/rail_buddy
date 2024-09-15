import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,  // Keep icons and labels visible
      selectedItemColor: Colors.blueGrey[800],  // Highlighted color
      unselectedItemColor: Colors.grey,  // Unselected color
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,  // Adapts to light/dark modes
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Ticket AI',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.accessibility),
          label: 'Disability',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat Bot',
        ),
      ],
      onTap: (index) {
        // Handle navigation logic to avoid building multiple instances
        switch (index) {
          case 0:
            if (currentIndex != 0) {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }
            break;
          case 1:
            if (currentIndex != 1) {
              Navigator.pushNamedAndRemoveUntil(context, '/ai_ticket_analyzer', (route) => false);
            }
            break;
          case 2:
            if (currentIndex != 2) {
              Navigator.pushNamedAndRemoveUntil(context, '/disability', (route) => false);
            }
            break;
          case 3:
            if (currentIndex != 3) {
              Navigator.pushNamedAndRemoveUntil(context, '/chat_bot', (route) => false);
            }
            break;
        }
      },
    );
  }
}
