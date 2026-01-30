import 'package:flutter/material.dart';

import 'background_wave_painter.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool extendBody;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.extendBody = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2B2E40), // Lighter top
            Color(0xFF1F1D2B), // Darker bottom
          ],
        ),
      ),
      child: Stack(
        children: [
          // 1. The Wave Pattern (Behind everything)
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundWavePainter(),
            ),
          ),

          // 2. The Actual Scaffold content
          Scaffold(
            backgroundColor: Colors.transparent, // Important!
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            extendBody: extendBody,
            body: body,
          ),
        ],
      ),
    );
  }
}