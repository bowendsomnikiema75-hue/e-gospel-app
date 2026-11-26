import 'package:flutter/material.dart';

import '../config/app_config.dart';

/// Bannière d'accueil : fond noir, titre blanc avec un mot en orange,
/// un bouton. Aucune photo : la hauteur s'adapte au texte (pas de
/// débordement, même avec une grande taille de police du téléphone).
///
/// Le seul élément graphique est un arc orange fin en haut à droite,
/// qui reprend le cercle du logo.
class HeroBanner extends StatelessWidget {
  final VoidCallback onCtaPressed;

  const HeroBanner({super.key, required this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    const hero = AppConfig.hero;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        color: AppConfig.colorBlack,
        child: Stack(
          children: [
            Positioned(
              top: -52,
              right: -52,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppConfig.colorOrange.withOpacity(0.75),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${hero.title}\n',
                          style: const TextStyle(color: AppConfig.colorWhite),
                        ),
                        TextSpan(
                          text: hero.titleAccent,
                          style:
                              const TextStyle(color: AppConfig.colorOrange),
                        ),
                      ],
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    hero.subtitle,
                    style: TextStyle(
                      color: AppConfig.colorWhite.withOpacity(0.78),
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onCtaPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConfig.colorOrange,
                      foregroundColor: AppConfig.colorWhite,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      hero.ctaLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
