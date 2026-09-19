import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Un court verset biblique (texte du domaine public, traduction Louis
/// Segond) et sa référence.
class _Verse {
  final String text;
  final String reference;
  const _Verse(this.text, this.reference);
}

const List<_Verse> _verses = [
  _Verse("L'Éternel est mon berger : je ne manquerai de rien.", 'Psaume 23.1'),
  _Verse('Car je connais les projets que j\'ai formés sur vous, dit l\'Éternel, projets de paix et non de malheur.', 'Jérémie 29.11'),
  _Verse('Je puis tout par celui qui me fortifie.', 'Philippiens 4.13'),
  _Verse("L'Éternel est ma lumière et mon salut : de qui aurais-je crainte ?", 'Psaume 27.1'),
  _Verse('Ne crains rien, car je suis avec toi.', 'Ésaïe 41.10'),
  _Verse('Que votre cœur ne se trouble point. Croyez en Dieu, et croyez en moi.', 'Jean 14.1'),
  _Verse('Confie-toi en l\'Éternel de tout ton cœur.', 'Proverbes 3.5'),
  _Verse('La joie de l\'Éternel sera votre force.', 'Néhémie 8.10'),
  _Verse('Venez à moi, vous tous qui êtes fatigués et chargés, et je vous donnerai du repos.', 'Matthieu 11.28'),
  _Verse('Dieu est amour.', '1 Jean 4.8'),
  _Verse('Persévérez dans la prière, veillez-y avec actions de grâces.', 'Colossiens 4.2'),
  _Verse('Heureux ceux qui ont faim et soif de la justice, car ils seront rassasiés.', 'Matthieu 5.6'),
  _Verse('L\'Éternel est près de tous ceux qui l\'invoquent.', 'Psaume 145.18'),
  _Verse('Que la grâce et la paix vous soient multipliées.', '1 Pierre 1.2'),
];

/// Carte "Verset du jour" : un verset différent chaque jour, tiré d'une
/// liste locale (aucune connexion requise). Fond photo + voile sombre
/// pour la lisibilité, dans le même esprit que la bannière d'accueil.
class DailyVerseCard extends StatelessWidget {
  const DailyVerseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dayOfYear = int.parse(
      DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays.toString(),
    );
    final verse = _verses[dayOfYear % _verses.length];

    return GestureDetector(
      onTap: () => WebNavigationService.openPage(
        context,
        AppConfig.prayerUrl,
        title: 'Prière',
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppConfig.colorOrange, width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 16, 16, 18),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hero_prayer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppConfig.colorBlack.withOpacity(0.72),
                    AppConfig.colorBlack.withOpacity(0.30),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu_book_outlined,
                          color: AppConfig.colorOrange, size: 15),
                      const SizedBox(width: 6),
                      const Text(
                        'VERSET DU JOUR',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: AppConfig.colorOrange,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.chevron_right_rounded,
                          color: AppConfig.colorWhite.withOpacity(0.85),
                          size: 20),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    verse.text,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      fontStyle: FontStyle.italic,
                      color: AppConfig.colorWhite,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    verse.reference,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppConfig.colorWhite.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
