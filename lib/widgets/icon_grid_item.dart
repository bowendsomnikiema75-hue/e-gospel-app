import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Tuile carrée avec icône, utilisée dans la grille de rubriques de
/// l'écran d'accueil (fond orange / noir / crème en alternance).
class IconGridItem extends StatelessWidget {
  final AppCategory category;

  const IconGridItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(category.tileColor);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => WebNavigationService.openPage(
        context,
        category.url,
        title: category.title,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(category.icon, color: colors.icon, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            category.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppConfig.colorBlack,
            ),
          ),
        ],
      ),
    );
  }

  _TileColors _colorsFor(TileColor color) {
    switch (color) {
      case TileColor.orange:
        return const _TileColors(
          background: AppConfig.colorOrange,
          icon: AppConfig.colorWhite,
        );
      case TileColor.black:
        return const _TileColors(
          background: AppConfig.colorBlack,
          icon: AppConfig.colorWhite,
        );
      case TileColor.cream:
        return _TileColors(
          background: AppConfig.colorOrange.withOpacity(0.16),
          icon: AppConfig.colorBlack,
        );
    }
  }
}

class _TileColors {
  final Color background;
  final Color icon;
  const _TileColors({required this.background, required this.icon});
}
