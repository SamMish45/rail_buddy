import 'package:flutter/material.dart';
import '../widgets/brightness_button.dart';
import '../widgets/bottom_navigation.dart';

class StationDetailsPage extends StatelessWidget {
  final Function(bool) toggleTheme;

  const StationDetailsPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Station Details'),
        actions: [
          BrightnessButton(toggleTheme: toggleTheme),
        ],
      ),
      body: Column(
        children: [
          // Top half with the interactive map image
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InteractiveViewer(
                panEnabled: true, // Enable panning
                boundaryMargin: const EdgeInsets.all(80),
                minScale: 0.5,  // Minimum zoom scale
                maxScale: 4.0,  // Maximum zoom scale
                child: Image.asset(
                  'assets/images/map.png', // Ensure this image exists in your assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Bottom half with feature options
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildOption(
                    icon: Icons.view_in_ar,
                    label: 'Explore in AR',
                    onTap: () {
                      // AR feature can be linked here later
                    },
                  ),
                  _buildOption(
                    icon: Icons.map,
                    label: 'Use Map',
                    onTap: () {
                      // Map feature can be linked here later
                    },
                  ),
                  _buildOption(
                    icon: Icons.store_mall_directory,
                    label: 'Find Amenities',
                    onTap: () {
                      // Amenities feature can be linked here later
                    },
                  ),
                  _buildOption(
                    icon: Icons.query_builder,
                    label: 'Query Box',
                    onTap: () {
                      // Query or support feature can be linked here later
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0, // Assuming this is still part of the home section
      ),
    );
  }

  // Helper method to build each option in the grid
  Widget _buildOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.blueAccent),
          const SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
