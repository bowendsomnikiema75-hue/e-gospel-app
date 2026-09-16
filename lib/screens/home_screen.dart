import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/category_card.dart';

/// Page d'accueil : logo, slogan, courte intro, rubriques principales
/// et bouton vers le menu complet.
class HomeScreen extends StatelessWidget {
  /// Callback pour basculer sur l'onglet Menu depuis le bouton
  /// "Découvrir E-Gospel" / "Voir toutes les rubriques".
  final VoidCallback onSeeAllPressed;

  const HomeScreen({super.key, required this.onSeeAllPressed});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Bonne nuit';
    if (hour < 12) return 'Bonjour';
    if (hour < 18) return 'Bon après-midi';
    return 'Bonsoir';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Grille adaptative : 2 colonnes sur petits écrans, 3 sur écrans larges.
    final crossAxisCount = width >= 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      body: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 12),
                child: child,
              ),
            );
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildIntro(),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onSeeAllPressed,
                icon: const Icon(Icons.explore_outlined, size: 19),
                label: const Text(
                  'Découvrir E-Gospel',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.colorOrange,
                  foregroundColor: AppConfig.colorWhite,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 28),
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
                  TextButton.icon(
                    onPressed: onSeeAllPressed,
                    icon: const Text(
                      'Tout voir',
                      style: TextStyle(color: AppConfig.colorOrange),
                    ),
                    label: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: AppConfig.colorOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppConfig.featuredCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: AppConfig.featuredCategories[index],
                  );
                },
              ),
            ],
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
          width: 52,
          height: 52,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConfig.appName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppConfig.colorBlack,
                ),
              ),
              Text(
                AppConfig.appSlogan,
                style: TextStyle(
                  fontSize: 12.5,
                  color: AppConfig.colorBlack.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIntro() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConfig.colorLightGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_greeting()} 👋',
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: AppConfig.colorBlack,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppConfig.appIntro,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.45,
              color: AppConfig.colorBlack.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
