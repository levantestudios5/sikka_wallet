import 'package:flutter/material.dart';
import 'dart:math';

class RankBadge extends StatelessWidget {
  final String rank;
  final List<Color> gradientColor;

  const RankBadge({super.key, required this.rank, required this.gradientColor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(60, 60), // Adjust size
      painter: StarburstPainter(gradientColor),
      child: Center(
        child: Stack(
          children: [
            // Number Shadow
            Positioned(
              top: 22,
              left: 30,
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
            // Number
            Text(
              rank.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StarburstPainter extends CustomPainter {
  final List<Color> gradientColor;
  StarburstPainter(this.gradientColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: gradientColor,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Path path = _createStarburstPath(size.width, size.height);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint); // White border
  }

  Path _createStarburstPath(double width, double height) {
    const int points = 36;
    const double outerRadius = 24;
    const double innerRadius = 18;
    final Path path = Path();
    final double angle = (2 * pi) / points;

    for (int i = 0; i < points; i++) {
      final double r = i.isEven ? outerRadius : innerRadius;
      final double x = width / 2 + r * cos(i * angle);
      final double y = height / 2 + r * sin(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
