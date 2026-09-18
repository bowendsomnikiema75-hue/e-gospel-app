import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Ligne détaillée d'une rubrique : photo (ou icône neutre), titre,
/// courte description, flèche. Utilisée dans la section "Rubriques".
class RubriqueListTile extends StatelessWidget {
  final AppCategory category;

  const RubriqueListTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final hasImage = category.imagePath != null;

    return InkWell(
      onTap: () => WebNavigationService.openPage(
        context,
        category.url,
        title: category.title,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: hasImage
                  ? Image.asset(
                      category.imagePath!,
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      color: AppConfig.colorLightGrey,
                      child: Icon(category.icon,
                          color: AppConfig.colorBlack, size: 22),
                    ),
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
                      fontWeight: FontWeight.w600,
                      color: AppConfig.colorBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppConfig.colorTextMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppConfig.colorTextMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
