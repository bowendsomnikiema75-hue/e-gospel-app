import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/hero_banner.dart';
import '../widgets/icon_grid_item.dart';
import '../widgets/rubrique_list_tile.dart';

/// Page d'accueil : en-tête, bannière, grille d'icônes des rubriques
/// principales et liste détaillée de toutes les rubriques.
class HomeScreen extends StatelessWidget {
  /// Callback pour basculer sur l'onglet Menu depuis "Tout voir".
  final VoidCallback onSeeAllPressed;

  const HomeScreen({super.key, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width >= 600 ? 6 : 4;

    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            HeroBanner(onCtaPressed: onSeeAllPressed),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rubriques',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppConfig.colorBlack,
                  ),
                ),
                TextButton(
                  onPressed: onSeeAllPressed,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Tout voir',
                    style: TextStyle(
                      color: AppConfig.colorTextMuted,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            ...AppConfig.categories.map(
              (category) => Column(
                children: [
                  RubriqueListTile(category: category),
                  const Divider(height: 1, color: AppConfig.colorBorder),
                ],
              ),
            ),
          ],
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
