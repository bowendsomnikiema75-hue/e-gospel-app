import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Carte cliquable représentant une rubrique du site.
///
/// Design sobre : fond blanc, bordure fine, coins arrondis, icône dans
/// un cercle à contour orange — même traitement visuel que la rangée
/// de rubriques de l'accueil, pour une charte cohérente dans toute
/// l'application.
class CategoryCard extends StatelessWidget {
  final AppCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppConfig.colorWhite,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => WebNavigationService.openPage(
          context,
          category.url,
          title: category.title,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppConfig.colorBorder),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppConfig.colorWhite,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: AppConfig.colorOrange, width: 1.4),
                ),
                child: Icon(category.icon,
                    color: AppConfig.colorOrange, size: 22),
              ),
              const SizedBox(height: 10),
              Text(
                category.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppConfig.colorBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
