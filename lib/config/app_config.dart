import 'package:flutter/material.dart';

/// Couleur de fond utilisée pour les tuiles d'icônes (grille + vignettes),
/// en alternance, comme sur la maquette.
enum TileColor { orange, black, cream }

/// Modèle simple représentant une rubrique du site e-gospel.com
/// affichée sous forme de carte dans l'application.
class AppCategory {
  final String title;
  final String emoji;
  final String url;
  final IconData icon;
  final String description;
  final TileColor tileColor;

  const AppCategory({
    required this.title,
    required this.emoji,
    required this.url,
    required this.icon,
    required this.description,
    required this.tileColor,
  });
}

/// Un slide de la bannière d'accueil (carrousel).
class HeroSlide {
  final String kicker;
  final String titleLine1;
  final String titleLine2Accent;
  final String subtitle;
  final String ctaLabel;

  const HeroSlide({
    required this.kicker,
    required this.titleLine1,
    required this.titleLine2Accent,
    required this.subtitle,
    required this.ctaLabel,
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
  static const String appIntro =
      "L'application officielle de e-gospel.com. Retrouvez en un clic la "
      "musique, les vidéos, la prière et toutes les rubriques de la "
      "plateforme, directement depuis votre téléphone.";
  static const String baseUrl = 'https://e-gospel.com';

  // ---------------------------------------------------------------------
  // Bannière d'accueil (carrousel) — ajoute d'autres HeroSlide ici pour
  // que le carrousel affiche plusieurs slides.
  // ---------------------------------------------------------------------
  static const List<HeroSlide> heroSlides = [
    HeroSlide(
      kicker: 'VOTRE PORTAIL SPIRITUEL',
      titleLine1: 'Musique, prière &',
      titleLine2Accent: 'enseignements',
      subtitle: 'Des contenus pour nourrir votre foi, vous encourager et '
          'vous rapprocher de Dieu.',
      ctaLabel: 'Découvrir E-Gospel',
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
      emoji: '🎵',
      url: musicUrl,
      icon: Icons.music_note_rounded,
      description: 'Chants, artistes et playlists gospel.',
      tileColor: TileColor.orange,
    ),
    AppCategory(
      title: 'Vidéos',
      emoji: '🎬',
      url: videosUrl,
      icon: Icons.movie_creation_outlined,
      description: 'Témoignages, concerts, interviews et bien plus.',
      tileColor: TileColor.black,
    ),
    AppCategory(
      title: 'Exhortations',
      emoji: '📖',
      url: exhortationUrl,
      icon: Icons.menu_book_outlined,
      description: 'Des messages pour fortifier votre foi.',
      tileColor: TileColor.cream,
    ),
    AppCategory(
      title: 'Prière',
      emoji: '🙏',
      url: prayerUrl,
      icon: Icons.volunteer_activism_outlined,
      description: 'Confiez vos intentions et demeurez dans la présence de Dieu.',
      tileColor: TileColor.orange,
    ),
    AppCategory(
      title: 'Églises',
      emoji: '⛪',
      url: churchesUrl,
      icon: Icons.church_outlined,
      description: 'Découvrez les églises et assemblées de votre région.',
      tileColor: TileColor.black,
    ),
    AppCategory(
      title: 'Mémoire',
      emoji: '🕊️',
      url: memoryUrl,
      icon: Icons.image_outlined,
      description: 'Hommages et souvenirs de serviteurs de Dieu.',
      tileColor: TileColor.cream,
    ),
    AppCategory(
      title: 'Formations',
      emoji: '🎓',
      url: formationsUrl,
      icon: Icons.school_outlined,
      description: 'Apprenez, grandissez, équipez-vous pour le ministère.',
      tileColor: TileColor.orange,
    ),
    AppCategory(
      title: 'Événements',
      emoji: '📅',
      url: eventsUrl,
      icon: Icons.calendar_month_outlined,
      description: 'Concerts, conférences, rencontres à ne pas manquer.',
      tileColor: TileColor.black,
    ),
    AppCategory(
      title: 'Autres contenus',
      emoji: '📚',
      url: othersUrl,
      icon: Icons.apps_rounded,
      description: 'Tout le reste du contenu disponible sur e-gospel.com.',
      tileColor: TileColor.cream,
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
  static const Color colorLightGrey = Color(0xFFF7F7F5);
  static const Color colorBorder = Color(0xFFE8E5E0);
}
