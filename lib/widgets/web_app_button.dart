import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class WebAppButton extends StatefulWidget {
  /// Creates a button to launch GYMPLY Web / PWA.
  // ignore: unnecessary_type_name_in_constructor
  const WebAppButton({required this.sourceScreen, super.key});

  final String sourceScreen;

  @override
  State<WebAppButton> createState() => _WebAppButtonState();
}

class _WebAppButtonState extends State<WebAppButton> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          unawaited(
            FirebaseAnalytics.instance.logEvent(
              name: 'web_app_click',
              parameters: <String, Object>{
                'source_screen': widget.sourceScreen,
              },
            ),
          );
          unawaited(_launchUrl('https://gymply.app'));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFCB075).withAlpha(40)
                : const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFCB075), width: 2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(120),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.laptop_mac_rounded,
                color: Color(0xFFFCB075),
                size: 26,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'TRY GYMPLY ON WEB',
                    style: TextStyle(
                      color: Color(0xFFFCB075),
                      fontFamily: 'Bebas Neue',
                      fontSize: 19,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Instant PWA in browser • No install required',
                    style: TextStyle(
                      color: Color(0xFFDEDEDE),
                      fontFamily: 'Teko',
                      fontSize: 15,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
