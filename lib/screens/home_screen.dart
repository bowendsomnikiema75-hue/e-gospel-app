import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/daily_verse_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/icon_grid_item.dart';

/// Page d'accueil : en-tête, bannière, rubriques en rangée horizontale
/// et verset du jour. La liste complète et la recherche vivent dans
/// l'onglet Explorer.
class HomeScreen extends StatefulWidget {
  /// Bascule vers l'onglet Explorer (lien "Tout voir" et icône recherche).
  final VoidCallback onExplorePressed;

  const HomeScreen({super.key, required this.onExplorePressed});

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
                _buildHeader(context),
                const SizedBox(height: 18),
                const HeroBanner(),
                const SizedBox(height: 26),
                _buildSectionHeader('Catégories'),
                const SizedBox(height: 12),
                _buildCategoriesRow(),
                const SizedBox(height: 24),
                const DailyVerseCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
        Expanded(
          child: Column(
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
        ),
        IconButton(
          onPressed: widget.onExplorePressed,
          icon: const Icon(Icons.search_rounded),
          color: AppConfig.colorBlack,
          tooltip: 'Rechercher une rubrique',
        ),
        IconButton(
          onPressed: () => _showComingSoon(context),
          icon: const Icon(Icons.person_outline_rounded),
          color: AppConfig.colorBlack,
          tooltip: 'Mon compte',
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppConfig.colorBlack,
          ),
        ),
        InkWell(
          onTap: widget.onExplorePressed,
          borderRadius: BorderRadius.circular(6),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tout voir',
                  style: TextStyle(
                    color: AppConfig.colorOrange,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 3),
                Icon(Icons.arrow_forward_rounded,
                    size: 15, color: AppConfig.colorOrange),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesRow() {
    final items = AppConfig.featuredCategories;
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return IconGridItem(
            category: items[index],
            highlighted: index == 0,
          );
        },
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Espace compte bientôt disponible.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
