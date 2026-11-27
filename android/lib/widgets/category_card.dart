import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Carte cliquable représentant une rubrique du site.
///
/// Design sobre : fond blanc, bordure fine, coins légèrement arrondis,
/// accent orange uniquement sur l'icône — pas de gradient ni d'ombre
/// excessive, conformément à la charte demandée.
class CategoryCard extends StatelessWidget {
  final AppCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppConfig.colorWhite,
      borderRadius: BorderRadius.circular(AppConfig.radiusMedium),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConfig.radiusMedium),
        onTap: () => WebNavigationService.openPage(
          context,
          category.url,
          title: category.title,
        requiresLocation: category.requiresLocation,
      ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.radiusMedium),
            border: Border.all(color: AppConfig.colorBorder),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppConfig.colorBlack,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(category.icon, color: AppConfig.colorOrange, size: 26),
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
