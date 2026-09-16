import 'package:flutter/material.dart';

/// Modèle simple représentant une rubrique du site e-gospel.com
/// affichée sous forme de carte dans l'application.
class AppCategory {
  final String title;
  final String emoji;
  final String url;
  final Color color;

  const AppCategory({
    required this.title,
    required this.emoji,
    required this.url,
    this.color = AppConfig.colorOrange,
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
  static const String appSlogan = 'Votre portail spirituel, partout avec vous';
  static const String appIntro =
      "L'application officielle de e-gospel.com. Retrouvez en un clic la "
      "musique, les vidéos, la prière et toutes les rubriques de la "
      "plateforme, directement depuis votre téléphone.";
  static const String baseUrl = 'https://e-gospel.com';

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
        title: 'Musique', emoji: '🎵', url: musicUrl, color: colorOrange),
    AppCategory(
        title: 'Vidéos', emoji: '🎬', url: videosUrl, color: colorTeal),
    AppCategory(
        title: 'Exhortations',
        emoji: '📖',
        url: exhortationUrl,
        color: colorIndigo),
    AppCategory(
        title: 'Prière', emoji: '🙏', url: prayerUrl, color: colorAmber),
    AppCategory(
        title: 'Églises',
        emoji: '⛪',
        url: churchesUrl,
        color: colorTerracotta),
    AppCategory(
        title: 'Mémoire', emoji: '🕊️', url: memoryUrl, color: colorPlum),
    AppCategory(
        title: 'Formations',
        emoji: '🎓',
        url: formationsUrl,
        color: colorBlue),
    AppCategory(
        title: 'Événements', emoji: '📅', url: eventsUrl, color: colorGreen),
    AppCategory(
        title: 'Autres contenus',
        emoji: '📚',
        url: othersUrl,
        color: colorGrey),
  ];

  // Rubriques mises en avant sur la page d'accueil (les 6 premières).
  static List<AppCategory> get featuredCategories =>
      categories.take(6).toList();

  // ---------------------------------------------------------------------
  // Charte graphique
  // ---------------------------------------------------------------------
  static const Color colorOrange = Color(0xFFF57905);
  static const Color colorBlack = Color(0xFF141414);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorLightGrey = Color(0xFFF7F7F5);
  static const Color colorBorder = Color(0xFFE8E5E0);

  // Palette secondaire — une teinte distincte par rubrique pour repérer
  // les catégories en un coup d'œil, tout en restant sobre (pas de
  // couleurs saturées ni de dégradés).
  static const Color colorTeal = Color(0xFF1C7A70);
  static const Color colorIndigo = Color(0xFF4A4A9C);
  static const Color colorAmber = Color(0xFFB8860B);
  static const Color colorTerracotta = Color(0xFFA5502C);
  static const Color colorPlum = Color(0xFF7A3C6D);
  static const Color colorBlue = Color(0xFF2C6E9E);
  static const Color colorGreen = Color(0xFF3C7A3E);
  static const Color colorGrey = Color(0xFF5F5E5A);
}
