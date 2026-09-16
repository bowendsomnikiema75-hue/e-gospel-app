import 'package:flutter/material.dart';

import '../config/app_config.dart';

/// Bannière carrousel de l'écran d'accueil.
///
/// En attendant de vraies photos (à fournir), le fond utilise un dégradé
/// aux couleurs de la marque plutôt qu'une image — remplaçable plus tard
/// par une DecorationImage sans changer la structure du widget.
class HeroBanner extends StatefulWidget {
  final VoidCallback onCtaPressed;

  const HeroBanner({super.key, required this.onCtaPressed});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = AppConfig.heroSlides;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: slides.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return _SlideContent(
                  slide: slides[index],
                  onCtaPressed: widget.onCtaPressed,
                );
              },
            ),
            if (slides.length > 1)
              Positioned(
                bottom: 16,
                right: 20,
                child: Row(
                  children: List.generate(slides.length, (index) {
                    final active = index == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(left: 5),
                      width: active ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: active
                            ? AppConfig.colorOrange
                            : AppConfig.colorWhite.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
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

class _SlideContent extends StatelessWidget {
  final HeroSlide slide;
  final VoidCallback onCtaPressed;

  const _SlideContent({required this.slide, required this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 20),
      decoration: const BoxDecoration(
        // Dégradé de marque en attendant une vraie photo de fond.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConfig.colorBlack, Color(0xFF3A2410)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            slide.kicker,
            style: const TextStyle(
              color: AppConfig.colorOrange,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${slide.titleLine1}\n',
                  style: const TextStyle(
                    color: AppConfig.colorWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 26,
                    height: 1.2,
                  ),
                ),
                TextSpan(
                  text: slide.titleLine2Accent,
                  style: const TextStyle(
                    color: AppConfig.colorOrange,
                    fontWeight: FontWeight.w800,
                    fontSize: 26,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            slide.subtitle,
            style: TextStyle(
              color: AppConfig.colorWhite.withOpacity(0.85),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: onCtaPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConfig.colorOrange,
              foregroundColor: AppConfig.colorWhite,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  slide.ctaLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_rounded, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
