import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/webview_screen.dart';

/// Point d'entrée UNIQUE pour ouvrir une page du site e-gospel.com.
///
/// Toute la logique de navigation web passe par ce service. Si demain
/// la stratégie change (ex: toujours ouvrir dans le navigateur externe,
/// ou ajouter un tracking d'ouverture), un seul fichier est à modifier —
/// aucun bouton de l'application n'a besoin d'être touché.
class WebNavigationService {
  WebNavigationService._();

  /// Ouvre [url] dans une page in-app (WebView) pour une expérience fluide,
  /// avec un titre affiché dans la barre du haut.
  static Future<void> openPage(
    BuildContext context,
    String url, {
    String title = '',
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WebViewScreen(url: url, title: title),
      ),
    );
  }

  /// Solution de repli : ouvre l'URL dans le navigateur externe du
  /// téléphone. Utilisée notamment quand la WebView interne échoue.
  static Future<void> openInExternalBrowser(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
