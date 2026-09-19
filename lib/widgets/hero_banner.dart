import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Bannière d'accueil : une photo, une étiquette de rubrique, un titre,
/// un bouton d'action qui ouvre directement le contenu du slide.
/// Le voile dégradé sur la photo est purement fonctionnel (lisibilité
/// du texte), pas décoratif.
class HeroBanner extends StatefulWidget {
  const HeroBanner({super.key});

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
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppConfig.colorOrange, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          height: 300,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: slides.length,
                onPageChanged: (index) =>
                    setState(() => _currentPage = index),
                itemBuilder: (context, index) => _SlideContent(
                  slide: slides[index],
                ),
              ),
              if (slides.length > 1)
                Positioned(
                  bottom: 16,
                  left: 20,
                  child: Row(
                    children: List.generate(slides.length, (index) {
                      final active = index == _currentPage;
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        width: active ? 16 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: active
                              ? AppConfig.colorOrange
                              : AppConfig.colorWhite.withOpacity(0.6),
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

  const _SlideContent({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
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
              AppConfig.colorBlack.withOpacity(0.35),
              AppConfig.colorBlack.withOpacity(0.85),
            ],
            stops: const [0.0, 0.55, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              slide.eyebrow,
              style: const TextStyle(
                color: AppConfig.colorOrange,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              slide.title,
              style: const TextStyle(
                color: AppConfig.colorWhite,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                height: 1.22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              slide.subtitle,
              style: TextStyle(
                color: AppConfig.colorWhite.withOpacity(0.85),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => WebNavigationService.openPage(
                context,
                slide.targetUrl,
                title: slide.eyebrow,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConfig.colorOrange,
                foregroundColor: AppConfig.colorWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.play_arrow_rounded, size: 18),
                  const SizedBox(width: 6),
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
      ),
    );
  }
}
