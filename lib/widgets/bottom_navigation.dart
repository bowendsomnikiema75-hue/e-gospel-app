import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_config.dart';

/// Barre de navigation basse : Accueil / Explorer / Menu. L'onglet
/// actif se distingue par la couleur (orange), avec une transition
/// douce et un léger retour tactile.
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
      decoration: const BoxDecoration(
        color: AppConfig.colorWhite,
        border: Border(top: BorderSide(color: AppConfig.colorBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Accueil',
                  active: currentIndex == 0,
                  onTap: () => _handleTap(0),
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.explore_outlined,
                  activeIcon: Icons.explore_rounded,
                  label: 'Explorer',
                  active: currentIndex == 1,
                  onTap: () => _handleTap(1),
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.menu_rounded,
                  activeIcon: Icons.menu_rounded,
                  label: 'Menu',
                  active: currentIndex == 2,
                  onTap: () => _handleTap(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTap(int index) {
    if (index != currentIndex) HapticFeedback.selectionClick();
    onTap(index);
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppConfig.colorOrange : AppConfig.colorTextMuted;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Icon(
              active ? activeIcon : icon,
              key: ValueKey(active),
              color: color,
              size: 23,
            ),
          ),
          const SizedBox(height: 3),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
