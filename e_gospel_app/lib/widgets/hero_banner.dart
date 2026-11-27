import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Bannière d'accueil : carrousel de 3 slides (glisser pour changer).
/// Fond noir, illustration à droite, titre blanc avec une fin en orange.
class HeroBanner extends StatefulWidget {
  /// Action du bouton des slides qui n'ont pas de page dédiée
  /// (ouvre le menu complet).
  final VoidCallback onDiscover;

  const HeroBanner({super.key, required this.onDiscover});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCta(HeroSlide slide) {
    final url = slide.url;
    if (url == null) {
      widget.onDiscover();
      return;
    }
    WebNavigationService.openPage(
      context,
      url,
      title: slide.urlTitle,
      requiresLocation: slide.requiresLocation,
    );
  }

  @override
  Widget build(BuildContext context) {
    final slides = AppConfig.heroSlides;
    // La hauteur suit la taille de police du téléphone (accessibilité).
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    final height = 360.0 * (textScale > 1 ? textScale : 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConfig.radiusLarge),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: slides.length,
              onPageChanged: (index) => setState(() => _page = index),
              itemBuilder: (context, index) => _SlideView(
                slide: slides[index],
                onPressed: () => _onCta(slides[index]),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 22,
              child: Row(
                children: List.generate(slides.length, (index) {
                  final active = index == _page;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 6),
                    width: active ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active
                          ? AppConfig.colorOrange
                          : const Color(0xFF777777),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  final HeroSlide slide;
  final VoidCallback onPressed;

  const _SlideView({required this.slide, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConfig.colorBlack,
      child: Stack(
        children: [
          // Illustration à droite, sur toute la hauteur
          Positioned.fill(
            child: Image.asset(
              slide.illustration,
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerRight,
            ),
          ),
          // Voile noir de gauche à droite : le texte reste lisible
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 0.40, 0.72],
                  colors: [
                    AppConfig.colorBlack,
                    AppConfig.colorBlack.withOpacity(0.85),
                    AppConfig.colorBlack.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final titleSize =
                  (constraints.maxWidth * 0.078).clamp(21.0, 28.0).toDouble();
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 0, 48),
                  child: SizedBox(
                    width: constraints.maxWidth * 0.62,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${slide.title} ',
                                style: const TextStyle(
                                    color: AppConfig.colorWhite),
                              ),
                              TextSpan(
                                text: slide.accent,
                                style: const TextStyle(
                                    color: AppConfig.colorOrange),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          slide.description,
                          style: TextStyle(
                            color: AppConfig.colorWhite.withOpacity(0.78),
                            fontSize: 13.5,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConfig.colorOrange,
                            foregroundColor: AppConfig.colorWhite,
                            elevation: 0,
                            padding: const EdgeInsets.fromLTRB(18, 13, 12, 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppConfig.radiusMedium),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  slide.ctaLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.chevron_right_rounded,
                                  size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
