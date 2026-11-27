import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_config.dart';
import '../services/web_navigation_service.dart';

/// Un verset biblique (texte du domaine public, traduction Louis Segond
/// 1910) et sa référence.
class _Verse {
  final String text;
  final String reference;
  const _Verse(this.text, this.reference);
}

const List<_Verse> _verses = [
  _Verse("L'Éternel est mon berger : je ne manquerai de rien.", 'Psaume 23:1'),
  _Verse(
      "Car je connais les projets que j'ai formés sur vous, dit l'Éternel, projets de paix et non de malheur, afin de vous donner un avenir et de l'espérance.",
      'Jérémie 29:11'),
  _Verse('Je puis tout par celui qui me fortifie.', 'Philippiens 4:13'),
  _Verse(
      "L'Éternel est ma lumière et mon salut : de qui aurais-je crainte ?",
      'Psaume 27:1'),
  _Verse('Ne crains rien, car je suis avec toi.', 'Ésaïe 41:10'),
  _Verse(
      'Que votre cœur ne se trouble point. Croyez en Dieu, croyez aussi en moi.',
      'Jean 14:1'),
  _Verse("Confie-toi en l'Éternel de tout ton cœur.", 'Proverbes 3:5'),
  _Verse("La joie de l'Éternel sera votre force.", 'Néhémie 8:10'),
  _Verse(
      'Venez à moi, vous tous qui êtes fatigués et chargés, et je vous donnerai du repos.',
      'Matthieu 11:28'),
  _Verse(
      "Car Dieu a tant aimé le monde qu'il a donné son Fils unique, afin que quiconque croit en lui ne périsse point, mais qu'il ait la vie éternelle.",
      'Jean 3:16'),
  _Verse(
      "Ne t'effraie point et ne t'épouvante point, car l'Éternel, ton Dieu, est avec toi dans tout ce que tu entreprendras.",
      'Josué 1:9'),
  _Verse(
      'Cherchez premièrement le royaume et la justice de Dieu ; et toutes ces choses vous seront données par-dessus.',
      'Matthieu 6:33'),
  _Verse('Persévérez dans la prière, veillez-y avec actions de grâces.',
      'Colossiens 4:2'),
  _Verse(
      "L'Éternel est près de tous ceux qui l'invoquent, de tous ceux qui l'invoquent avec sincérité.",
      'Psaume 145:18'),
];

const List<String> _weekdays = [
  'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche',
];
const List<String> _months = [
  'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août',
  'septembre', 'octobre', 'novembre', 'décembre',
];

/// Carte "Verset du jour" : un verset différent chaque jour, tiré d'une
/// liste locale (aucune connexion requise). Deux actions : copier le
/// verset, ou le partager sur WhatsApp.
class DailyVerseCard extends StatelessWidget {
  const DailyVerseCard({super.key});

  _Verse _todayVerse(DateTime now) {
    final days = now.difference(DateTime(2026, 1, 1)).inDays;
    return _verses[days % _verses.length];
  }

  String _shareText(_Verse v) =>
      '« ${v.text} »\n— ${v.reference}\n\ne-gospel.com';

  Future<void> _copy(BuildContext context, _Verse v) async {
    await Clipboard.setData(ClipboardData(text: _shareText(v)));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Verset copié'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> _shareWhatsApp(BuildContext context, _Verse v) async {
    final text = Uri.encodeComponent(_shareText(v));
    try {
      await WebNavigationService.openInExternalBrowser(
          'https://wa.me/?text=$text');
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Impossible d'ouvrir WhatsApp"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final verse = _todayVerse(now);
    final date =
        '${_weekdays[now.weekday - 1]} ${now.day} ${_months[now.month - 1]}';

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppConfig.colorVerseBg,
        borderRadius: BorderRadius.circular(AppConfig.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: AppConfig.colorOrange,
                  borderRadius: BorderRadius.circular(AppConfig.radiusMedium),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book_rounded,
                        size: 14, color: AppConfig.colorWhite),
                    SizedBox(width: 6),
                    Text(
                      'VERSET DU JOUR',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: AppConfig.colorWhite,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppConfig.colorTextMuted,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            verse.text,
            style: const TextStyle(
              fontSize: 18,
              height: 1.42,
              fontWeight: FontWeight.w600,
              color: AppConfig.colorBlack,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      verse.reference,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppConfig.colorTextMuted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _IconAction(
                          icon: Icons.content_copy_rounded,
                          tooltip: 'Copier le verset',
                          onTap: () => _copy(context, verse),
                        ),
                        const SizedBox(width: 8),
                        _IconAction(
                          icon: Icons.share_outlined,
                          tooltip: 'Partager sur WhatsApp',
                          onTap: () => _shareWhatsApp(context, verse),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Petite Bible illustrée, qui dépasse légèrement du coin
              Transform.translate(
                offset: const Offset(20, 20),
                child: Image.asset(
                  'assets/images/verse_bible.png',
                  width: 116,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconAction({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConfig.radiusSmall),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppConfig.colorWhite,
            borderRadius: BorderRadius.circular(AppConfig.radiusSmall),
          ),
          child: Icon(icon, size: 18, color: AppConfig.colorBlack),
        ),
      ),
    );
  }
}
