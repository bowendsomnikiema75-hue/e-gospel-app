import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../widgets/category_card.dart';

/// Onglet Explorer : recherche et grille de toutes les rubriques du
/// site. C'est ici que mène le lien "Tout voir" et l'icône de
/// recherche de l'accueil.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width >= 600 ? 3 : 2;

    final filtered = _query.isEmpty
        ? AppConfig.categories
        : AppConfig.categories
            .where((c) =>
                c.title.toLowerCase().contains(_query.toLowerCase().trim()))
            .toList();

    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      appBar: AppBar(
        backgroundColor: AppConfig.colorWhite,
        elevation: 0.5,
        foregroundColor: AppConfig.colorBlack,
        title: const Text(
          'Explorer',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Rechercher une rubrique',
                  hintStyle: const TextStyle(
                    color: AppConfig.colorTextMuted,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppConfig.colorTextMuted,
                    size: 20,
                  ),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppConfig.colorTextMuted,
                            size: 18,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  filled: true,
                  fillColor: AppConfig.colorLightGrey,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: filtered.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryCard(category: filtered[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppConfig.colorTextMuted,
            ),
            const SizedBox(height: 12),
            Text(
              'Aucune rubrique ne correspond à "$_query"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppConfig.colorTextMuted,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
