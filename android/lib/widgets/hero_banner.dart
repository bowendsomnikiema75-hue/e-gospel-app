import 'dart:async';

import 'package:flutter/material.dart';

import '../config/app_config.dart';
import 'hero_illustrations.dart';

/// Bannière d'accueil (hauteur 360, coins 28) : fond noir, illustration
/// vectorielle à droite (3 scènes qui défilent, une par thème), dégradé
/// noir à gauche pour la lisibilité, titre avec un mot en orange, bouton
/// et 3 indicateurs de carrousel.
class HeroBanner extends StatefulWidget {
  final VoidCallback onCtaPressed;

  const HeroBanner({super.key, required this.onCtaPressed});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  static const int _pageCount = 3;

  final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_controller.hasClients) return;
      _controller.animateToPage(
        (_page + 1) % _pageCount,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const hero = AppConfig.hero;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConfig.radiusLarge),
      child: Container(
        height: 360,
        width: double.infinity,
        color: AppConfig.colorBlack,
        child: LayoutBuilder(
          builder: (context, box) {
            final w = box.maxWidth;
            return Stack(
              children: [
                // Illustration (à droite), balayable du doigt.
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  width: w * 0.7,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pageCount,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemBuilder: (_, i) => HeroIllustration(index: i),
                  ),
                ),
                // Dégradé 90° : noir plein -> transparent.
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppConfig.colorBlack,
                            AppConfig.colorBlack.withOpacity(0.85),
                            AppConfig.colorBlack.withOpacity(0),
                          ],
                          stops: const [0, 0.45, 1],
                        ),
                      ),
                    ),
                  ),
                ),
                // Contenu.
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: w * 0.74),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${hero.title}\n',
                                      style: const TextStyle(
                                          color: AppConfig.colorWhite),
                                    ),
                                    TextSpan(
                                      text: hero.titleAccent,
                                      style: const TextStyle(
                                          color: AppConfig.colorOrange),
                                    ),
                                  ],
                                ),
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                hero.subtitle,
                                style: TextStyle(
                                  color: AppConfig.colorWhite.withOpacity(0.8),
                                  fontSize: 14,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        ElevatedButton(
                          onPressed: widget.onCtaPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConfig.colorOrange,
                            foregroundColor: AppConfig.colorWhite,
                            elevation: 0,
                            padding: const EdgeInsets.fromLTRB(22, 14, 14, 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                hero.ctaLabel,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.chevron_right_rounded, size: 22),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(_pageCount, (i) {
                            final active = i == _page;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.only(right: 6),
                              width: active ? 22 : 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: active
                                    ? AppConfig.colorOrange
                                    : AppConfig.colorIndicatorInactive,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
