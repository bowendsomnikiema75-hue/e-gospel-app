import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/daily_verse_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/icon_grid_item.dart';

/// Page d'accueil : en-tête, bannière, verset du jour et grille des
/// catégories. La liste complète est dans l'onglet Menu.
class HomeScreen extends StatefulWidget {
  /// Callback pour basculer sur l'onglet Menu (bouton de la bannière et
  /// "Tout voir").
  final VoidCallback onSeeAllPressed;

  const HomeScreen({super.key, required this.onSeeAllPressed});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(_fade);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width >= 600 ? 6 : 4;

    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                HeroBanner(onCtaPressed: widget.onSeeAllPressed),
                const SizedBox(height: 14),
                const DailyVerseCard(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Catégories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppConfig.colorBlack,
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onSeeAllPressed,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Tout voir',
                        style: TextStyle(
                          color: AppConfig.colorOrange,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppConfig.featuredCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    return IconGridItem(
                      category: AppConfig.featuredCategories[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 46,
          height: 46,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'E-',
                    style: TextStyle(color: AppConfig.colorBlack),
                  ),
                  TextSpan(
                    text: 'Gospel',
                    style: TextStyle(color: AppConfig.colorOrange),
                  ),
                ],
              ),
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            Text(
              AppConfig.appSlogan,
              style: const TextStyle(
                fontSize: 11.5,
                color: AppConfig.colorTextMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
