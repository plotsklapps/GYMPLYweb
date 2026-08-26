import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class StoreBadge extends StatefulWidget {
  const StoreBadge({
    required this.asset,
    required this.onTap,
    super.key,
  });
  final String asset;
  final VoidCallback onTap;

  @override
  State<StoreBadge> createState() => _StoreBadgeState();
}

class _StoreBadgeState extends State<StoreBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // Log badge click
          FirebaseAnalytics.instance.logEvent(
            name: 'badge_click',
            parameters: {
              'badge_type': widget.asset.contains('google')
                  ? 'play_store'
                  : 'github',
            },
          );
          widget.onTap();
        },
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Image.asset(
            widget.asset,
            height: 45,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
