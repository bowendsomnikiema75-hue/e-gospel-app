import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Tuile de catégorie : carré noir aux coins arrondis, icône orange,
/// titre dessous. Léger effet d'enfoncement au toucher.
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
        requiresLocation: widget.category.requiresLocation,
      ),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 76),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConfig.colorBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      widget.category.icon,
                      color: AppConfig.colorOrange,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.category.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: AppConfig.colorBlack,
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
