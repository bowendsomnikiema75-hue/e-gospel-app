import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../config/app_config.dart';

/// Illustrations vectorielles de la bannière d'accueil, dessinées en code :
/// aucun fichier image à charger (donc aucune erreur "Unable to load
/// asset", et aucun poids ajouté à l'APK). Trois scènes, une par thème de
/// la bannière : enseignements (Bible + croix), musique, prière (lumière).
class HeroIllustration extends StatelessWidget {
  final int index;

  const HeroIllustration({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final CustomPainter painter;
    switch (index) {
      case 0:
        painter = const _TeachingScenePainter();
        break;
      case 1:
        painter = const _MusicScenePainter();
        break;
      default:
        painter = const _PrayerScenePainter();
    }
    return RepaintBoundary(
      child: CustomPaint(painter: painter, size: Size.infinite),
    );
  }
}

const Color _orange = AppConfig.colorOrange;

void _glow(Canvas canvas, Offset c, double r, double alpha) {
  final paint = Paint()
    ..shader = RadialGradient(
      colors: [_orange.withOpacity(alpha), _orange.withOpacity(0)],
    ).createShader(Rect.fromCircle(center: c, radius: r));
  canvas.drawCircle(c, r, paint);
}

void _rings(Canvas canvas, Offset c, List<double> radii) {
  for (var i = 0; i < radii.length; i++) {
    canvas.drawCircle(
      c,
      radii[i],
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = _orange.withOpacity(0.5 - i * 0.18),
    );
  }
}

void _sparkles(Canvas canvas, Size s, List<Offset> fractions) {
  final paint = Paint()..color = Colors.white.withOpacity(0.7);
  for (final f in fractions) {
    canvas.drawCircle(Offset(s.width * f.dx, s.height * f.dy), 1.8, paint);
  }
}

// ---------------------------------------------------------------------
// Scène 1 : Bible ouverte, croix et rayons de lumière
// ---------------------------------------------------------------------
class _TeachingScenePainter extends CustomPainter {
  const _TeachingScenePainter();

  Path _page(double cx, double by, double half, double sign, double dy) {
    final p = Path();
    p.moveTo(cx, by + dy);
    p.cubicTo(cx + sign * half * 0.18, by - 12 + dy, cx + sign * half * 0.7,
        by - 16 + dy, cx + sign * half, by - 4 + dy);
    p.lineTo(cx + sign * half, by + 38 + dy);
    p.cubicTo(cx + sign * half * 0.7, by + 28 + dy, cx + sign * half * 0.18,
        by + 26 + dy, cx, by + 40 + dy);
    p.close();
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.62;
    final cy = h * 0.44;
    final c = Offset(cx, cy);

    _glow(canvas, c, w * 0.9, 0.35);
    _rings(canvas, c, [w * 0.5, w * 0.72]);

    // Rayons en éventail vers le haut.
    final ray = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 11; i++) {
      final a = -math.pi * 0.95 + i * (math.pi * 0.9 / 10);
      final d = Offset(math.cos(a), math.sin(a));
      canvas.drawLine(c + d * (w * 0.3), c + d * (w * 0.62), ray);
    }

    // Croix.
    final cross = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(cx - 6, cy - 78, cx + 6, cy + 62),
        const Radius.circular(3),
      ),
      cross,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(cx - 34, cy - 50, cx + 34, cy - 38),
        const Radius.circular(3),
      ),
      cross,
    );

    // Bible ouverte : couverture orange, pages claires.
    final by = cy + 80;
    final half = w * 0.4;
    final cover = Paint()..color = const Color(0xFFD96B00);
    final pages = Paint()..color = const Color(0xFFF5F2EE);
    for (final sign in [-1.0, 1.0]) {
      canvas.drawPath(_page(cx, by, half + 5, sign, 7), cover);
    }
    for (final sign in [-1.0, 1.0]) {
      canvas.drawPath(_page(cx, by, half, sign, 0), pages);
    }
    final line = Paint()
      ..color = const Color(0xFFC9C4BD)
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    for (final sign in [-1.0, 1.0]) {
      for (var i = 0; i < 3; i++) {
        final y = by + 8 + i * 7.0;
        canvas.drawLine(
          Offset(cx + sign * 12, y),
          Offset(cx + sign * (half - 14), y - 3),
          line,
        );
      }
    }
    canvas.drawLine(
      Offset(cx, by),
      Offset(cx, by + 40),
      Paint()
        ..color = const Color(0xFFB5AFA7)
        ..strokeWidth = 1.5,
    );

    _sparkles(canvas, size, const [
      Offset(0.2, 0.14),
      Offset(0.85, 0.2),
      Offset(0.35, 0.3),
      Offset(0.92, 0.55),
    ]);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// Scène 2 : musique (croches, ondes sonores, barres d'égaliseur)
// ---------------------------------------------------------------------
class _MusicScenePainter extends CustomPainter {
  const _MusicScenePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.62;
    final cy = h * 0.42;
    final c = Offset(cx, cy);

    _glow(canvas, c, w * 0.9, 0.3);
    _rings(canvas, c, [w * 0.5, w * 0.72]);

    final note = Paint()..color = _orange;
    final head1 = Offset(cx - 30, cy + 40);
    final head2 = Offset(cx + 30, cy + 24);
    const stemW = 5.0;
    final x1 = head1.dx + 15;
    final x2 = head2.dx + 15;
    final top1 = cy - 50;
    final top2 = cy - 66;

    for (final head in [head1, head2]) {
      canvas.save();
      canvas.translate(head.dx, head.dy);
      canvas.rotate(-0.35);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 34, height: 24),
        note,
      );
      canvas.restore();
    }
    canvas.drawRect(
        Rect.fromLTRB(x1 - stemW / 2, top1, x1 + stemW / 2, head1.dy), note);
    canvas.drawRect(
        Rect.fromLTRB(x2 - stemW / 2, top2, x2 + stemW / 2, head2.dy), note);

    final beam = Path()
      ..moveTo(x1 - stemW / 2, top1)
      ..lineTo(x2 + stemW / 2, top2)
      ..lineTo(x2 + stemW / 2, top2 + 13)
      ..lineTo(x1 - stemW / 2, top1 + 13)
      ..close();
    canvas.drawPath(beam, note);

    // Barres d'égaliseur sous les notes.
    const heights = [16.0, 32.0, 48.0, 28.0, 42.0, 22.0, 12.0];
    final y0 = cy + 118;
    for (var i = 0; i < heights.length; i++) {
      final x = cx - 60 + i * 20.0;
      final paint = Paint()
        ..color = (i.isEven ? _orange : Colors.white).withOpacity(0.55);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, y0), width: 6, height: heights[i]),
          const Radius.circular(3),
        ),
        paint,
      );
    }

    _sparkles(canvas, size, const [
      Offset(0.22, 0.16),
      Offset(0.88, 0.18),
      Offset(0.3, 0.34),
      Offset(0.94, 0.5),
    ]);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// Scène 3 : prière / lumière (soleil levant derrière une croix sur colline)
// ---------------------------------------------------------------------
class _PrayerScenePainter extends CustomPainter {
  const _PrayerScenePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.62;
    final hillY = h * 0.66;
    final sun = Offset(cx, hillY - 6);

    _glow(canvas, sun, w * 0.95, 0.32);

    // Rayons du soleil.
    final ray = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 11; i++) {
      final a = -math.pi * 0.97 + i * (math.pi * 0.94 / 10);
      final d = Offset(math.cos(a), math.sin(a));
      canvas.drawLine(sun + d * 80, sun + d * (i.isEven ? 122 : 106), ray);
    }

    // Soleil.
    canvas.drawCircle(sun, 62, Paint()..color = _orange);

    // Colline.
    final hill = Path()
      ..moveTo(-10, hillY + 50)
      ..cubicTo(w * 0.25, hillY + 50, cx - 40, hillY - 10, cx, hillY - 10)
      ..cubicTo(cx + 40, hillY - 10, w * 0.85, hillY + 40, w + 10, hillY + 40)
      ..lineTo(w + 10, h + 10)
      ..lineTo(-10, h + 10)
      ..close();
    canvas.drawPath(hill, Paint()..color = const Color(0xFF262626));

    // Croix au sommet.
    final cross = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(cx - 4.5, hillY - 100, cx + 4.5, hillY - 8),
        const Radius.circular(2.5),
      ),
      cross,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(cx - 23, hillY - 78, cx + 23, hillY - 69),
        const Radius.circular(2.5),
      ),
      cross,
    );

    _sparkles(canvas, size, const [
      Offset(0.2, 0.12),
      Offset(0.9, 0.16),
      Offset(0.38, 0.26),
      Offset(0.95, 0.42),
    ]);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
