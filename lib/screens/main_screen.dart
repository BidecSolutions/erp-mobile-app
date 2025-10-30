import 'package:flutter/material.dart';
import 'package:flutter_app/screens/notifications_screen.dart';
import 'package:flutter_app/widgets/bottom_nav_bar.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 👇 Use your actual screens instead of placeholder texts
  final List<Widget> _pages = const [
    HomeScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
