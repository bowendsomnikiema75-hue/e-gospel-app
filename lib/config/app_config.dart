import 'package:flutter/material.dart';

/// Modèle simple représentant une rubrique du site e-gospel.com
/// affichée sous forme de carte dans l'application.
class AppCategory {
  final String title;
  final String url;
  final IconData icon;
  final String description;
  /// Chemin vers une photo dédiée (assets/images/categories/...).
  /// Si null, la rubrique affiche l'icône neutre à la place.
  final String? imagePath;

  const AppCategory({
    required this.title,
    required this.url,
    required this.icon,
    required this.description,
    this.imagePath,
  });
}

/// Un slide de la bannière d'accueil (carrousel).
class HeroSlide {
  final String title;
  final String subtitle;
  final String ctaLabel;
  final String? backgroundImage;

  const HeroSlide({
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    this.backgroundImage,
  });
}

/// Configuration centrale de l'application.
///
/// Toutes les URL du site sont regroupées ICI. Pour changer une adresse
/// (ex: si une page change de chemin sur e-gospel.com), il suffit de
/// modifier la valeur correspondante ci-dessous — aucun autre fichier
/// n'a besoin d'être touché.
class AppConfig {
  AppConfig._();

  // ---------------------------------------------------------------------
  // Identité
  // ---------------------------------------------------------------------
  static const String appName = 'E-Gospel';
  static const String appSlogan = "La lumière de l'Évangile, partout";
  static const String baseUrl = 'https://e-gospel.com';

  // ---------------------------------------------------------------------
  // Bannière d'accueil (carrousel) — ajoute d'autres HeroSlide ici pour
  // que le carrousel affiche plusieurs slides.
  // ---------------------------------------------------------------------
  static const List<HeroSlide> heroSlides = [
    HeroSlide(
      title: 'Musique, prière et enseignements',
      subtitle: 'Des contenus pour nourrir votre foi, où que vous soyez.',
      ctaLabel: 'Découvrir E-Gospel',
      backgroundImage: 'assets/images/hero_banner.jpg',
    ),
  ];

  // ---------------------------------------------------------------------
  // URLs des rubriques (à adapter si besoin)
  // ---------------------------------------------------------------------
  static const String musicUrl = 'https://e-gospel.com/music-chretienne-copy/';
  static const String videosUrl = 'https://e-gospel.com/gospel-nostalgie/';
  static const String exhortationUrl = 'https://e-gospel.com/predication-et-enseignement/';
  static const String prayerUrl = 'https://e-gospel.com/ma-priere/';
  static const String churchesUrl = 'https://e-gospel.com/eglise/';
  static const String memoryUrl = 'https://e-gospel.com/memoire/';
  static const String formationsUrl = 'https://e-gospel.com/formations/';
  static const String eventsUrl = 'https://e-gospel.com/evenementiel/';
  static const String othersUrl = 'https://e-gospel.com/';

  // ---------------------------------------------------------------------
  // Liste des rubriques utilisée par les écrans (accueil + menu)
  // ---------------------------------------------------------------------
  static const List<AppCategory> categories = [
    AppCategory(
      title: 'Musique',
      url: musicUrl,
      icon: Icons.music_note_rounded,
      description: 'Chants, artistes et playlists gospel.',
    ),
    AppCategory(
      title: 'Vidéos',
      url: videosUrl,
      icon: Icons.smart_display_outlined,
      description: 'Témoignages, concerts, interviews et bien plus.',
      imagePath: 'assets/images/categories/videos.jpg',
    ),
    AppCategory(
      title: 'Exhortations',
      url: exhortationUrl,
      icon: Icons.menu_book_outlined,
      description: 'Des messages pour fortifier votre foi.',
      imagePath: 'assets/images/categories/exhortations.jpg',
    ),
    AppCategory(
      title: 'Prière',
      url: prayerUrl,
      icon: Icons.volunteer_activism_outlined,
      description: 'Confiez vos intentions et demeurez dans la présence de Dieu.',
      imagePath: 'assets/images/categories/priere.jpg',
    ),
    AppCategory(
      title: 'Églises',
      url: churchesUrl,
      icon: Icons.church_outlined,
      description: 'Découvrez les églises et assemblées de votre région.',
      imagePath: 'assets/images/categories/eglises.jpg',
    ),
    AppCategory(
      title: 'Mémoire',
      url: memoryUrl,
      icon: Icons.image_outlined,
      description: 'Hommages et souvenirs de serviteurs de Dieu.',
      imagePath: 'assets/images/categories/memoire.jpg',
    ),
    AppCategory(
      title: 'Formations',
      url: formationsUrl,
      icon: Icons.school_outlined,
      description: 'Apprenez, grandissez, équipez-vous pour le ministère.',
      imagePath: 'assets/images/categories/formations.jpg',
    ),
    AppCategory(
      title: 'Événements',
      url: eventsUrl,
      icon: Icons.calendar_month_outlined,
      description: 'Concerts, conférences, rencontres à ne pas manquer.',
      imagePath: 'assets/images/categories/evenements.jpg',
    ),
    AppCategory(
      title: 'Autres contenus',
      url: othersUrl,
      icon: Icons.apps_rounded,
      description: 'Tout le reste du contenu disponible sur e-gospel.com.',
      imagePath: 'assets/images/categories/autres.jpg',
    ),
  ];

  // Rubriques mises en avant sur la page d'accueil (les 8 premières,
  // affichées en grille 4 colonnes x 2 lignes).
  static List<AppCategory> get featuredCategories =>
      categories.take(8).toList();

  // ---------------------------------------------------------------------
  // Charte graphique
  // ---------------------------------------------------------------------
  static const Color colorOrange = Color(0xFFF57905);
  static const Color colorBlack = Color(0xFF141414);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorLightGrey = Color(0xFFF6F6F5);
  static const Color colorBorder = Color(0xFFE7E5E2);
  static const Color colorTextMuted = Color(0xFF6B6B6B);
}
