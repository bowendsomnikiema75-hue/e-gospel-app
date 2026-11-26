import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Tuile de catégorie de l'accueil : carré noir (coins 22), icône orange
/// de 30, titre blanc dessous. Retour tactile par légère réduction.
class HomeCategoryTile extends StatefulWidget {
  final AppCategory category;

  const HomeCategoryTile({super.key, required this.category});

  @override
  State<HomeCategoryTile> createState() => _HomeCategoryTileState();
}

class _HomeCategoryTileState extends State<HomeCategoryTile> {
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
        requiresLocation: widget.category.requiresLocation,
      ),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: AppConfig.colorBlack,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.category.icon,
                    color: AppConfig.colorOrange, size: 30),
                const SizedBox(height: 8),
                Text(
                  widget.category.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppConfig.colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
