import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Ligne détaillée d'une rubrique : icône, titre, courte description,
/// flèche. Utilisée dans la section "Rubriques" de l'écran d'accueil.
class RubriqueListTile extends StatelessWidget {
  final AppCategory category;

  const RubriqueListTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final background = category.tileColor == TileColor.black
        ? AppConfig.colorBlack
        : category.tileColor == TileColor.orange
            ? AppConfig.colorOrange
            : AppConfig.colorOrange.withOpacity(0.16);
    final iconColor = category.tileColor == TileColor.cream
        ? AppConfig.colorBlack
        : AppConfig.colorWhite;

    return Material(
      color: AppConfig.colorWhite,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => WebNavigationService.openPage(
          context,
          category.url,
          title: category.title,
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppConfig.colorBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(category.icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppConfig.colorBlack,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.3,
                        color: AppConfig.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppConfig.colorOrange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
