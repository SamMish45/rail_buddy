import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/brightness_button.dart'; // Make sure this widget is implemented
import '../widgets/bottom_navigation.dart'; // Custom Bottom Navigation widget

class AiTicketAnalyzerPage extends StatelessWidget {
  final Function(bool) toggleTheme; // Function to toggle theme

  const AiTicketAnalyzerPage({super.key, required this.toggleTheme});

  // Function to handle image picking from Camera or Gallery
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    // Request permission for camera or gallery based on source
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image selected: ${pickedFile.path}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission required to access media')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Ticket Analyzer'),
        actions: [
          BrightnessButton(toggleTheme: toggleTheme), // Theme toggle button
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(context, ImageSource.camera),
              child: const Text('Upload from Camera'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(context, ImageSource.gallery),
              child: const Text('Upload from Gallery'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Files',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Placeholder for the recent files, replace this with actual logic to list files
            const Text('Files will be listed here...'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 1, // Current index for the AI Ticket Analyzer Page
      ),
    );
  }
}
