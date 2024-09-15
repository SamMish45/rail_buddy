import 'package:flutter/material.dart';

class BrightnessButton extends StatelessWidget {
  final Function(bool) toggleTheme;

  const BrightnessButton({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => toggleTheme(!isBright),
      ),
    );
  }
}
