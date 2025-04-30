import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/theme_service.dart';
import 'ros_connection_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const RosConnectionScreen(),
    const SettingsScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            activeIcon: const Icon(Icons.home_filled),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            activeIcon: const Icon(Icons.settings_applications),
            label: l10n.settings,
          ),
        ],
        selectedItemColor: themeService.themeMode == ThemeMode.dark 
            ? Colors.white 
            : const Color(0xFF2C2C2C),
        unselectedItemColor: themeService.themeMode == ThemeMode.dark 
            ? Colors.grey 
            : Colors.grey[600],
        backgroundColor: themeService.themeMode == ThemeMode.dark 
            ? const Color(0xFF1E1E1E) 
            : Colors.white,
        elevation: 8,
      ),
    );
  }
} 