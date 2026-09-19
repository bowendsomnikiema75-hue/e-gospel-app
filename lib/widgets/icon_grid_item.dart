import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Carte de rubrique utilisée dans la rangée horizontale de l'accueil.
///
/// La première rubrique de la rangée est mise en avant avec un cercle
/// orange plein (icône blanche) ; les autres ont un cercle blanc avec
/// une icône orange — même logique visuelle que la maquette.
class IconGridItem extends StatefulWidget {
  final AppCategory category;
  final bool highlighted;

  const IconGridItem({
    super.key,
    required this.category,
    this.highlighted = false,
  });

  @override
  State<IconGridItem> createState() => _IconGridItemState();
}

class _IconGridItemState extends State<IconGridItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.highlighted;

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
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          width: 84,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          decoration: BoxDecoration(
            color: AppConfig.colorWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppConfig.colorBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: highlighted
                      ? AppConfig.colorOrange
                      : AppConfig.colorWhite,
                  shape: BoxShape.circle,
                  border: highlighted
                      ? null
                      : Border.all(color: AppConfig.colorOrange, width: 1.4),
                ),
                child: Icon(
                  widget.category.icon,
                  color: highlighted
                      ? AppConfig.colorWhite
                      : AppConfig.colorOrange,
                  size: 21,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.category.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppConfig.colorBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
