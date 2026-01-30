import 'package:flutter/material.dart';

class BackgroundWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Paint for the Top Wave (Lighter)
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF6C5DD3).withOpacity(0.2), // Purple tint
          const Color(0xFF6C5DD3).withOpacity(0.0), // Fades out
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    // Start slightly down the left side
    path.moveTo(0, size.height * 0.25);

    // Curve 1: Go up towards the middle
    path.quadraticBezierTo(
      size.width * 0.25, // Control Point X
      size.height * 0.20, // Control Point Y
      size.width * 0.50,   // End Point X
      size.height * 0.25, // End Point Y
    );

    // Curve 2: Swoop down towards the right
    path.quadraticBezierTo(
      size.width * 0.75, // Control Point X
      size.height * 0.30, // Control Point Y
      size.width,         // End Point X
      size.height * 0.20, // End Point Y
    );

    // Close the path at the top
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    // 2. Paint for a subtle bottom accent (Optional depth)
    final paint2 = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height);
    path2.quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.85,
        size.width,
        size.height
    );
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}