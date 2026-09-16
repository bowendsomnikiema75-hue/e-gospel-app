import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_config.dart';

/// Barre de navigation basse simple : Accueil / Menu.
class EGospelBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const EGospelBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConfig.colorWhite,
        border: Border(top: BorderSide(color: AppConfig.colorBorder)),
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index != currentIndex) HapticFeedback.selectionClick();
            onTap(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppConfig.colorWhite,
          selectedItemColor: AppConfig.colorOrange,
          unselectedItemColor: AppConfig.colorBlack.withOpacity(0.55),
          elevation: 0,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded),
              activeIcon: Icon(Icons.menu_rounded),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
