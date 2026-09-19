import 'package:flutter/material.dart';

/// Modèle simple représentant une rubrique du site e-gospel.com.
class AppCategory {
  final String title;
  final String url;
  final IconData icon;
  final String description;
  final String? imagePath;

  const AppCategory({
    required this.title,
    required this.url,
    required this.icon,
    required this.description,
    this.imagePath,
  });
}

/// Un slide de la bannière d'accueil.
class HeroSlide {
  final String eyebrow;
  final String title;
  final String subtitle;
  final String ctaLabel;
  final String? backgroundImage;
  final String targetUrl;

  const HeroSlide({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.targetUrl,
    this.backgroundImage,
  });
}

/// Configuration centrale de l'application.
///
/// L'application sert de portail mobile : les boutons ouvrent les pages
/// existantes de e-gospel.com, sans reconstruire le site dans Flutter.
class AppConfig {
  AppConfig._();

  // ---------------------------------------------------------------------
  // Identité
  // ---------------------------------------------------------------------
  static const String appName = 'E-Gospel';
  static const String appSlogan = "La lumière de l'Évangile, partout";
  static const String baseUrl = 'https://e-gospel.com';

  // ---------------------------------------------------------------------
  // URLs des rubriques
  // ---------------------------------------------------------------------
  static const String musicUrl =
      'https://e-gospel.com/music-chretienne-copy/';
  static const String videosUrl = 'https://e-gospel.com/gospel-nostalgie/';
  static const String exhortationUrl =
      'https://e-gospel.com/predication-et-enseignement/';
  static const String prayerUrl = 'https://e-gospel.com/ma-priere/';
  static const String churchesUrl = 'https://e-gospel.com/eglise/';
  static const String memoryUrl = 'https://e-gospel.com/memoire/';
  static const String formationsUrl = 'https://e-gospel.com/formations/';
  static const String eventsUrl = 'https://e-gospel.com/evenementiel/';
  static const String othersUrl = 'https://e-gospel.com/';

  // ---------------------------------------------------------------------
  // Bannière d'accueil
  // ---------------------------------------------------------------------
  static const List<HeroSlide> heroSlides = [
    HeroSlide(
      eyebrow: 'MUSIQUE',
      title: 'Louez Dieu\nen esprit et en vérité',
      subtitle: 'Des chants qui élèvent le cœur et nourrissent la foi.',
      ctaLabel: 'Écouter maintenant',
      targetUrl: musicUrl,
      backgroundImage: 'assets/images/hero_banner.jpg',
    ),
    HeroSlide(
      eyebrow: 'PRIÈRE',
      title: 'Demeurez dans\nla présence de Dieu',
      subtitle: 'Confiez vos intentions et priez chaque jour avec nous.',
      ctaLabel: 'Prier maintenant',
      targetUrl: prayerUrl,
      backgroundImage: 'assets/images/hero_prayer.jpg',
    ),
  ];

  // ---------------------------------------------------------------------
  // Liste des rubriques
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

  // Les 5 premières rubriques apparaissent horizontalement sur l'accueil.
  static List<AppCategory> get featuredCategories =>
      categories.take(5).toList();

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
