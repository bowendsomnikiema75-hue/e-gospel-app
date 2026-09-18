import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/daily_verse_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/icon_grid_item.dart';

/// Page d'accueil : en-tête, bannière, verset du jour et grille
/// d'icônes des rubriques. La liste détaillée est dans l'onglet Menu.
class HomeScreen extends StatefulWidget {
  /// Callback pour basculer sur l'onglet Menu depuis "Voir toutes les
  /// rubriques".
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                HeroBanner(onCtaPressed: widget.onSeeAllPressed),
                const SizedBox(height: 16),
                const DailyVerseCard(),
                const SizedBox(height: 26),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppConfig.featuredCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    return IconGridItem(
                      category: AppConfig.featuredCategories[index],
                    );
                  },
                ),
                const SizedBox(height: 30),
                OutlinedButton(
                  onPressed: widget.onSeeAllPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConfig.colorBlack,
                    side: const BorderSide(color: AppConfig.colorBorder),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Voir toutes les rubriques',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/logo.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConfig.appName,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppConfig.colorBlack,
              ),
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
