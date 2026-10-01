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

  void _showWipDialog(BuildContext context) {
    unawaited(
      FirebaseAnalytics.instance.logEvent(
        name: 'wip_badge_click',
        parameters: <String, Object>{'badge_type': 'app_store'},
      ),
    );

    unawaited(
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: const Color(0xFFFCB075).withAlpha(128),
                width: 1.5,
              ),
            ),
            title: const Row(
              children: <Widget>[
                Icon(Icons.apple, color: Color(0xFFFCB075), size: 28),
                SizedBox(width: 10),
                Text(
                  'iOS VERSION COMING SOON',
                  style: TextStyle(
                    color: Color(0xFFFCB075),
                    fontFamily: 'Bebas Neue',
                    fontSize: 22,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            content: const Text(
              'The GYMPLY iOS app is currently in active development. '
              'Stay tuned for updates!',
              style: TextStyle(
                color: Color(0xFFDEDEDE),
                fontFamily: 'Teko',
                fontSize: 19,
                height: 1.2,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'GOT IT',
                  style: TextStyle(
                    color: Color(0xFFFCB075),
                    fontFamily: 'Bebas Neue',
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget badgeContent;

    if (widget.isWorkInProgress) {
      badgeContent = Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          // Apple logo badge clearly visible behind
          Opacity(
            opacity: 0.85,
            child: Image.asset(widget.asset, height: 45, fit: BoxFit.contain),
          ),
          // Sleek & small construction tape banner
          Transform.rotate(
            angle: -0.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: CustomPaint(
                painter: const HazardStripesPainter(),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  color: Colors.black,
                  child: const Text(
                    'WORK IN PROGRESS',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontFamily: 'Bebas Neue',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      badgeContent = Image.asset(widget.asset, height: 45, fit: BoxFit.contain);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.isWorkInProgress) {
            _showWipDialog(context);
          } else if (widget.onTap != null) {
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
          scale: _isHovered ? 1.05 : 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: badgeContent,
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
    const double stripeWidth = 4;
    final Path path = Path();
    for (
      double x = 0 - size.height;
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
