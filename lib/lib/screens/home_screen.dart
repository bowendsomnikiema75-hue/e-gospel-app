import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/daily_verse_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/home_category_tile.dart';

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
    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                _buildHeader(),
                const SizedBox(height: 8),
                HeroBanner(onCtaPressed: widget.onSeeAllPressed),
                const SizedBox(height: 16),
                const DailyVerseCard(),
                const SizedBox(height: 28),
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
                Row(
                  children: [
                    for (var i = 0;
                        i < AppConfig.homeCategories.length;
                        i++) ...[
                      if (i > 0) const SizedBox(width: 12),
                      Expanded(
                        child: HomeCategoryTile(
                          category: AppConfig.homeCategories[i],
                        ),
                      ),
                    ],
                  ],
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
      height: 96,
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 64,
            height: 64,
          ),
          const SizedBox(width: 14),
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
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  AppConfig.appSlogan,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: AppConfig.colorTextMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppConfig.colorLightGrey,
            shape: const CircleBorder(
              side: BorderSide(color: AppConfig.colorBorder),
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Aucune notification pour le moment'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              },
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 22,
                  color: AppConfig.colorBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
