import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Tuile d'icône utilisée dans la grille de rubriques de l'accueil.
///
/// Traitement neutre (fond gris très clair, icône noire) avec un léger
/// retour tactile au toucher (échelle) pour une sensation plus fluide.
class IconGridItem extends StatefulWidget {
  final AppCategory category;

  const IconGridItem({super.key, required this.category});

  @override
  State<IconGridItem> createState() => _IconGridItemState();
}

class _IconGridItemState extends State<IconGridItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: () => WebNavigationService.openPage(
        context,
        widget.category.url,
        title: widget.category.title,
      ),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppConfig.colorLightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(widget.category.icon,
                  color: AppConfig.colorBlack, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              widget.category.title,
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
      ),
    );
  }
}
