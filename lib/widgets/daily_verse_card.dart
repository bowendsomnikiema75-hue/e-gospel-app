import 'package:flutter/material.dart';

import '../config/app_config.dart';

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
/// liste locale (aucune connexion requise).
class DailyVerseCard extends StatelessWidget {
  const DailyVerseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dayOfYear = int.parse(
      DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays.toString(),
    );
    final verse = _verses[dayOfYear % _verses.length];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppConfig.colorLightGrey,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: AppConfig.colorOrange, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VERSET DU JOUR',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppConfig.colorOrange,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            verse.text,
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              fontStyle: FontStyle.italic,
              color: AppConfig.colorBlack,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            verse.reference,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppConfig.colorTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
