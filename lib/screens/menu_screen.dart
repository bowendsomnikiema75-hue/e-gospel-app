import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/category_card.dart';

/// Écran Menu : affiche l'ensemble des rubriques du site.
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width >= 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      appBar: AppBar(
        backgroundColor: AppConfig.colorWhite,
        elevation: 0.5,
        foregroundColor: AppConfig.colorBlack,
        title: const Text(
          'Toutes les rubriques',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: AppConfig.categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            return CategoryCard(category: AppConfig.categories[index]);
          },
        ),
      ),
    );
  }
}
