import 'package:flutter/material.dart';

import '../config/app_config.dart';

/// Bannière d'accueil : une photo, un titre, un bouton. Le voile
/// dégradé sur la photo est purement fonctionnel (lisibilité du texte),
/// pas décoratif.
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppConfig.colorOrange.withOpacity(0.35)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 190,
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
                bottom: 14,
                right: 18,
                child: Row(
                  children: List.generate(slides.length, (index) {
                    final active = index == _currentPage;
                    return Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: active ? 14 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: active
                            ? AppConfig.colorWhite
                            : AppConfig.colorWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
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
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: AppConfig.colorBlack,
        image: slide.backgroundImage != null
            ? DecorationImage(
                image: AssetImage(slide.backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppConfig.colorBlack.withOpacity(0.75),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              slide.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppConfig.colorWhite,
                fontWeight: FontWeight.w700,
                fontSize: 19,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              slide.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppConfig.colorWhite.withOpacity(0.85),
                fontSize: 12,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onCtaPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConfig.colorOrange,
                foregroundColor: AppConfig.colorWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                slide.ctaLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
