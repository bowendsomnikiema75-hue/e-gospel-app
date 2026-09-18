import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Tuile d'icône utilisée dans la grille de rubriques de l'accueil.
///
/// Traitement volontairement neutre et unique pour toutes les rubriques
/// (fond gris très clair, icône noire) : l'orange reste réservé aux
/// actions principales, pas décoré sur chaque icône.
class IconGridItem extends StatelessWidget {
  final AppCategory category;

  const IconGridItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
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
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppConfig.colorLightGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(category.icon, color: AppConfig.colorBlack, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            category.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppConfig.colorBlack,
            ),
          ),
        ],
      ),
    );
  }
}
