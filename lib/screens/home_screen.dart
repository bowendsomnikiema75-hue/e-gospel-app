import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/daily_verse_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/icon_grid_item.dart';

/// Page d'accueil : en-tête, bannières, verset du jour et catégories.
/// La liste complète des catégories est dans l'onglet Menu.
class HomeScreen extends StatefulWidget {
  /// Bascule sur l'onglet Menu ("Découvrir E-Gospel" et "Tout voir").
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
    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: AppConfig.maxContentWidth),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                  children: [
                    _buildHeader(),
                    HeroBanner(onDiscover: widget.onSeeAllPressed),
                    const SizedBox(height: 12),
                    const DailyVerseCard(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppConfig.featuredCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 104,
                      ),
                      itemBuilder: (context, index) => IconGridItem(
                        category: AppConfig.featuredCategories[index],
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

  Widget _buildHeader() {
    return SizedBox(
      height: 76,
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 52,
            height: 52,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  AppConfig.appSlogan,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppConfig.colorTextMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
