import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/hero_banner.dart';
import '../widgets/icon_grid_item.dart';
import '../widgets/rubrique_list_tile.dart';

/// Page d'accueil : en-tête, bannière carrousel, grille d'icônes des
/// rubriques principales et liste détaillée de toutes les rubriques.
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
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            _buildHeader(context),
            const SizedBox(height: 18),
            HeroBanner(onCtaPressed: onSeeAllPressed),
            const SizedBox(height: 22),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppConfig.featuredCategories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return IconGridItem(
                  category: AppConfig.featuredCategories[index],
                );
              },
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SectionTitle('Rubriques'),
                TextButton(
                  onPressed: onSeeAllPressed,
                  child: Row(
                    children: const [
                      Text(
                        'Tout voir',
                        style: TextStyle(
                          color: AppConfig.colorOrange,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.arrow_forward_rounded,
                          color: AppConfig.colorOrange, size: 16),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...AppConfig.categories.map(
              (category) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: RubriqueListTile(category: category),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/images/logo.png',
            width: 46,
            height: 46,
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
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppConfig.colorOrange,
                ),
              ),
              Text(
                AppConfig.appSlogan,
                style: TextStyle(
                  fontSize: 11.5,
                  color: AppConfig.colorBlack.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notifications bientôt disponibles'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppConfig.colorOrange.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded,
                    color: AppConfig.colorBlack),
                Positioned(
                  top: -1,
                  right: -1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppConfig.colorOrange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppConfig.colorBlack,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 28,
          height: 3,
          decoration: BoxDecoration(
            color: AppConfig.colorOrange,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
