import 'package:flutter/material.dart';
import 'brightness_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(bool) toggleTheme;

  CustomAppBar({super.key, required this.title, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        BrightnessButton(toggleTheme: toggleTheme),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
