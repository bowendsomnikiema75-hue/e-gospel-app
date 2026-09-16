import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Carte cliquable représentant une rubrique du site.
///
/// Design sobre : fond blanc, ombre très légère, coins arrondis, une
/// touche de couleur propre à chaque rubrique sur l'icône seulement —
/// pas de gradient, pas d'ombre excessive.
class CategoryCard extends StatefulWidget {
  final AppCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;

    return Semantics(
      button: true,
      label: category.title,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) => _setPressed(false),
        child: AnimatedScale(
          scale: _pressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Material(
            color: AppConfig.colorWhite,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              splashColor: category.color.withOpacity(0.08),
              highlightColor: category.color.withOpacity(0.05),
              onTap: () {
                HapticFeedback.selectionClick();
                WebNavigationService.openPage(
                  context,
                  category.url,
                  title: category.title,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppConfig.colorBorder),
                  boxShadow: [
                    BoxShadow(
                      color: AppConfig.colorBlack.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        category.emoji,
                        style: const TextStyle(fontSize: 22),
                      ),
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
          ),
        ),
      ),
    );
  }
}
