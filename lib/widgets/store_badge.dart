import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreBadge extends StatefulWidget {
  const new({
    required this.asset,
    this.onTap,
    this.isWorkInProgress = false,
    this.isGitHub = false,
    this.sourceScreen = 'unknown',
    super.key,
  });

  final String asset;
  final VoidCallback? onTap;
  final bool isWorkInProgress;
  final bool isGitHub;
  final String sourceScreen;

  @override
  State<StoreBadge> createState() => _StoreBadgeState();
}

class _StoreBadgeState extends State<StoreBadge> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showWipDialog(BuildContext context) {
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
    );
  }

  void _showGitHubDialog(BuildContext context) {
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
          title: Row(
            children: <Widget>[
              Image.asset('assets/images/githublogo.png', height: 28),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'GYMPLY is 100% open source, free forever, and ad-free. '
                'What would you like to do?',
                style: TextStyle(
                  color: Color(0xFFDEDEDE),
                  fontFamily: 'Teko',
                  fontSize: 19,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 18),
              _DialogOptionButton(
                icon: Icons.download_rounded,
                title: 'DOWNLOAD DIRECT APK',
                subtitle: 'Get the latest Android release (.apk)',
                onTap: () {
                  Navigator.of(context).pop();
                  unawaited(
                    FirebaseAnalytics.instance.logEvent(
                      name: 'github_dialog_action',
                      parameters: <String, Object>{
                        'action': 'download_apk',
                        'source_screen': widget.sourceScreen,
                      },
                    ),
                  );
                  unawaited(
                    _launchUrl(
                      'https://github.com/plotsklapps/GYMPLY/releases/'
                      'latest/download/gymply.apk',
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _DialogOptionButton(
                icon: Icons.code_rounded,
                title: 'VISIT GITHUB REPOSITORY',
                subtitle: 'View full source code, docs & contribute',
                onTap: () {
                  Navigator.of(context).pop();
                  unawaited(
                    FirebaseAnalytics.instance.logEvent(
                      name: 'github_dialog_action',
                      parameters: <String, Object>{
                        'action': 'view_source',
                        'source_screen': widget.sourceScreen,
                      },
                    ),
                  );
                  unawaited(
                    _launchUrl('https://github.com/plotsklapps/GYMPLY'),
                  );
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'CLOSE',
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
          Opacity(
            opacity: 0.85,
            child: Image.asset(widget.asset, height: 45, fit: BoxFit.contain),
          ),
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

    final bool isGitHubBadge =
        widget.isGitHub || widget.asset.contains('github');

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.isWorkInProgress) {
            unawaited(
              FirebaseAnalytics.instance.logEvent(
                name: 'badge_click_wip',
                parameters: <String, Object>{
                  'badge_type': 'app_store_ios',
                  'source_screen': widget.sourceScreen,
                },
              ),
            );
            _showWipDialog(context);
          } else if (isGitHubBadge) {
            unawaited(
              FirebaseAnalytics.instance.logEvent(
                name: 'badge_click',
                parameters: <String, Object>{
                  'badge_type': 'github',
                  'source_screen': widget.sourceScreen,
                },
              ),
            );
            _showGitHubDialog(context);
          } else if (widget.onTap != null) {
            final String badgeType = widget.asset.contains('google')
                ? 'play_store'
                : 'app_store';

            unawaited(
              FirebaseAnalytics.instance.logEvent(
                name: 'badge_click',
                parameters: <String, Object>{
                  'badge_type': badgeType,
                  'source_screen': widget.sourceScreen,
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

class _DialogOptionButton extends StatefulWidget {
  const new({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  State<_DialogOptionButton> createState() => _DialogOptionButtonState();
}

class _DialogOptionButtonState extends State<_DialogOptionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFCB075).withAlpha(30)
                : Colors.black.withAlpha(120),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFCB075)
                  : const Color(0xFFFCB075).withAlpha(77),
              width: 1.5,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(widget.icon, color: const Color(0xFFFCB075), size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color(0xFFFCB075),
                        fontFamily: 'Bebas Neue',
                        fontSize: 18,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: Color(0xFFDEDEDE),
                        fontFamily: 'Teko',
                        fontSize: 15,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: const Color(0xFFFCB075).withAlpha(180),
                size: 22,
              ),
            ],
          ),
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
