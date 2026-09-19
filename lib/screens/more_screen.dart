import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Onglet Menu : informations sur l'application et actions annexes
/// (à propos, visite du site, partage). Les rubriques de contenu
/// vivent dans Accueil et Explorer — cet onglet est pour "le reste".
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorWhite,
      appBar: AppBar(
        backgroundColor: AppConfig.colorWhite,
        elevation: 0.5,
        foregroundColor: AppConfig.colorBlack,
        title: const Text(
          'Menu',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            _MenuTile(
              icon: Icons.language_rounded,
              label: 'Visiter e-gospel.com',
              subtitle: 'Le site complet dans votre navigateur',
              onTap: () => WebNavigationService.openPage(
                context,
                AppConfig.baseUrl,
                title: AppConfig.appName,
              ),
            ),
            _MenuTile(
              icon: Icons.share_rounded,
              label: "Partager l'application",
              subtitle: 'Copier le lien pour l\'envoyer à un proche',
              onTap: () => _shareApp(context),
            ),
            _MenuTile(
              icon: Icons.star_outline_rounded,
              label: "Noter l'application",
              subtitle: 'Disponible après publication sur le Store',
              onTap: () => _showComingSoon(context),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Divider(color: AppConfig.colorBorder, height: 1),
            ),
            _MenuTile(
              icon: Icons.info_outline_rounded,
              label: 'À propos',
              subtitle: 'Version, équipe, mentions',
              onTap: () => _showAbout(context),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '${AppConfig.appName} · v1.0.0',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppConfig.colorTextMuted,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _shareApp(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: AppConfig.baseUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lien copié — vous pouvez le coller et l\'envoyer.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bientôt disponible.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          AppConfig.appName,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          "Application mobile officielle et non commerciale de "
          'e-gospel.com — musique, enseignements, prière et vie '
          "d'église, accessibles depuis votre téléphone.\n\n"
          'Version 1.0.0',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Fermer',
              style: TextStyle(color: AppConfig.colorOrange),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppConfig.colorWhite,
                shape: BoxShape.circle,
                border: Border.all(color: AppConfig.colorOrange, width: 1.4),
              ),
              child: Icon(icon, color: AppConfig.colorOrange, size: 19),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: AppConfig.colorBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppConfig.colorTextMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppConfig.colorTextMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
