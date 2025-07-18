import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;

  const Setting({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
            const Text('Settings',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: onThemeToggle,
            ),
            // Center(
            //   child: SwitchListTile(
            //     title: const Text('Dark Mode'),
            //     value: isDarkMode,
            //     onChanged: onThemeToggle,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
