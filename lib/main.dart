import 'package:flutter/material.dart';

import 'config/app_config.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  runApp(const EGospelApp());
}

class EGospelApp extends StatelessWidget {
  const EGospelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppConfig.colorWhite,
        splashFactory: InkRipple.splashFactory,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConfig.colorOrange,
          primary: AppConfig.colorOrange,
          background: AppConfig.colorWhite,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConfig.colorWhite,
          foregroundColor: AppConfig.colorBlack,
        ),
      ),
      home: const MainShell(),
    );
  }
}

/// Coquille principale de l'app : gère la navigation basse entre
/// l'écran Accueil et l'écran Menu, en conservant l'état de chaque
/// écran (IndexedStack) pour une navigation instantanée et fluide.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _goToMenu() => setState(() => _currentIndex = 1);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onSeeAllPressed: _goToMenu),
      const MenuScreen(),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: EGospelBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
