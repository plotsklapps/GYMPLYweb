import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class StoreBadge extends StatefulWidget {
  const new({
    required this.asset,
    this.onTap,
    this.isWorkInProgress = false,
    super.key,
  });

  final String asset;
  final VoidCallback? onTap;
  final bool isWorkInProgress;

  @override
  State<StoreBadge> createState() => _StoreBadgeState();
}

class _StoreBadgeState extends State<StoreBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isWorkInProgress) {
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          // Dimmed badge image
          Opacity(
            opacity: 0.6,
            child: Image.asset(widget.asset, height: 45, fit: BoxFit.contain),
          ),
          // Yellow / Black street construction hazard tape banner
          Transform.rotate(
            angle: -0.12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CustomPaint(
                painter: const HazardStripesPainter(),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 1,
                  ),
                  color: Colors.black,
                  child: const Text(
                    'WORK IN PROGRESS',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontFamily: 'Bebas Neue',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            unawaited(
              FirebaseAnalytics.instance.logEvent(
                name: 'badge_click',
                parameters: <String, Object>{
                  'badge_type': widget.asset.contains('google')
                      ? 'play_store'
                      : widget.asset.contains('apple')
                      ? 'app_store'
                      : 'github',
                },
              ),
            );
            widget.onTap!();
          }
        },
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Image.asset(widget.asset, height: 45, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class HazardStripesPainter extends CustomPainter {
  const new();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint yellowPaint = Paint()..color = const Color(0xFFFFC107);
    final Paint blackPaint = Paint()..color = Colors.black;

    // Fill background yellow
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), yellowPaint);

    // Draw black diagonal stripes
    const double stripeWidth = 6;
    final Path path = Path();
    for (
      double x = -size.height;
      x < size.width + size.height;
      x += stripeWidth * 2
    ) {
      path
        ..reset()
        ..moveTo(x, 0)
        ..lineTo(x + stripeWidth, 0)
        ..lineTo(x + stripeWidth - size.height, size.height)
        ..lineTo(x - size.height, size.height)
        ..close();
      canvas.drawPath(path, blackPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
