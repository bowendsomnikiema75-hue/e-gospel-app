import 'package:flutter/material.dart';

/// Une rubrique du site e-gospel.com, affichée sous forme de tuile.
class AppCategory {
  final String title;
  final String url;
  final IconData icon;
  final String description;

  /// true si la page a besoin de la localisation du téléphone (ex : Églises,
  /// pour afficher les assemblées à proximité).
  final bool requiresLocation;

  const AppCategory({
    required this.title,
    required this.url,
    required this.icon,
    required this.description,
    this.requiresLocation = false,
  });
}

/// Une bannière du carrousel de l'accueil.
class HeroSlide {
  /// Début du titre (blanc) et fin du titre (orange).
  final String title;
  final String accent;
  final String description;
  final String ctaLabel;

  /// Illustration affichée à droite (assets/images/...).
  final String illustration;

  /// Page ouverte par le bouton. Si null, le bouton mène au menu complet.
  final String? url;
  final String urlTitle;
  final bool requiresLocation;

  const HeroSlide({
    required this.title,
    required this.accent,
    required this.description,
    required this.ctaLabel,
    required this.illustration,
    this.url,
    this.urlTitle = '',
    this.requiresLocation = false,
  });
}

/// Configuration centrale de l'application.
///
/// Toutes les URL du site sont regroupées ICI. Pour changer une adresse
/// (ex : si une page change de chemin sur e-gospel.com), il suffit de
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

  /// Numéro de livraison affiché en bas du Menu : permet de vérifier d'un
  /// coup d'œil quelle version est installée sur le téléphone.
  static const String versionLabel = 'Version 4.2 · 28 nov. 2026';

  // ---------------------------------------------------------------------
  // Bannières du carrousel de l'accueil (3)
  // ---------------------------------------------------------------------
  static const List<HeroSlide> heroSlides = [
    HeroSlide(
      title: 'Musique, prière et',
      accent: 'enseignements',
      description: 'Des contenus pour nourrir votre foi, où que vous soyez.',
      ctaLabel: 'Découvrir E-Gospel',
      illustration: 'assets/images/hero_bible.png',
    ),
    HeroSlide(
      title: 'Les chants qui ont marqué',
      accent: 'votre foi',
      description: "Retrouvez la musique gospel, d'hier à aujourd'hui.",
      ctaLabel: 'Écouter maintenant',
      illustration: 'assets/images/hero_music.png',
      url: musicUrl,
      urlTitle: 'Musique',
    ),
    HeroSlide(
      title: 'Une église',
      accent: 'près de chez vous',
      description: 'Découvrez les assemblées chrétiennes de votre région.',
      ctaLabel: 'Trouver une église',
      illustration: 'assets/images/hero_church.png',
      url: churchesUrl,
      urlTitle: 'Églises',
      requiresLocation: true,
    ),
  ];

  // ---------------------------------------------------------------------
  // URLs des rubriques (à adapter si besoin)
  // ---------------------------------------------------------------------
  static const String musicUrl = 'https://e-gospel.com/music-chretienne-copy/';
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
  // Rubriques (accueil : 4 mises en avant ; menu : toutes)
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
    ),
    AppCategory(
      title: 'Études',
      url: exhortationUrl,
      icon: Icons.menu_book_outlined,
      description: 'Des messages pour fortifier votre foi.',
    ),
    AppCategory(
      title: 'Prière',
      url: prayerUrl,
      icon: Icons.volunteer_activism_outlined,
      description: 'Confiez vos intentions et demeurez dans la présence de Dieu.',
    ),
    AppCategory(
      title: 'Églises',
      url: churchesUrl,
      icon: Icons.church_outlined,
      description: 'Découvrez les églises et assemblées de votre région.',
      requiresLocation: true,
    ),
    AppCategory(
      title: 'Mémoire',
      url: memoryUrl,
      icon: Icons.image_outlined,
      description: 'Hommages et souvenirs de serviteurs de Dieu.',
    ),
    AppCategory(
      title: 'Formations',
      url: formationsUrl,
      icon: Icons.school_outlined,
      description: 'Apprenez, grandissez, équipez-vous pour le ministère.',
    ),
    AppCategory(
      title: 'Événements',
      url: eventsUrl,
      icon: Icons.calendar_month_outlined,
      description: 'Concerts, conférences, rencontres à ne pas manquer.',
    ),
    AppCategory(
      title: 'Autres contenus',
      url: othersUrl,
      icon: Icons.apps_rounded,
      description: 'Tout le reste du contenu disponible sur e-gospel.com.',
    ),
  ];

  /// Rubriques mises en avant sur l'accueil, dans cet ordre.
  static const List<String> featuredTitles = [
    'Églises',
    'Vidéos',
    'Études',
    'Prière',
  ];

  static List<AppCategory> get featuredCategories => [
        for (final title in featuredTitles)
          categories.firstWhere((c) => c.title == title),
      ];

  // ---------------------------------------------------------------------
  // Charte graphique (d'après la maquette)
  // ---------------------------------------------------------------------
  static const Color colorOrange = Color(0xFFFF8200);
  static const Color colorBlack = Color(0xFF171717);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorLightGrey = Color(0xFFF7F7F7);
  static const Color colorBorder = Color(0xFFEEEEEE);
  static const Color colorTextMuted = Color(0xFF757575);
  static const Color colorVerseBg = Color(0xFFFFF3E5);

  static const double radiusSmall = 12;
  static const double radiusMedium = 20;
  static const double radiusLarge = 24;

  /// Largeur maximale du contenu (tablettes).
  static const double maxContentWidth = 480;
}
