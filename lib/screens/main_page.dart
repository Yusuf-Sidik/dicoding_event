import 'package:dicoding_event/screens/finished_event.dart';
import 'package:dicoding_event/screens/search_event.dart';
import 'package:dicoding_event/screens/setting.dart';
import 'package:dicoding_event/screens/upcoming_event.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;

  const MainPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const UpcomingEvent(),
      const FinishedEvent(),
      const SearchEvent(),
      Setting(
        isDarkMode: widget.isDarkMode,
        onThemeToggle: widget.onThemeToggle,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicoding Event App'),
        centerTitle: true,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Finishing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
