import 'package:flutter/material.dart';
import 'package:gymplyweb/widgets/scroll_hint.dart';
import 'package:gymplyweb/widgets/store_badge.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // 1. Top Banner
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/gymplylogo.png', height: 30),
              const SizedBox(width: 12),
              const Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'OPEN SOURCE - 100% FREE - 0% ADS - '
                    'LOCAL ONLY - NO ACCOUNT',
                    style: TextStyle(
                      color: Color(0xFFDEDEDE),
                      fontFamily: 'Teko',
                      fontSize: 22,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Humongous Title - Force-scales to fill all width
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FittedBox(
              child: Text(
                'GYMPLY',
                style: TextStyle(
                  color: Color(0xFFFCB075),
                  fontFamily: 'Bebas Neue',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 3. Store Badges - Symmetrically sized
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StoreBadge(
                asset: 'assets/images/githublogo.png',
                onTap: () => _launchUrl(
                  'https://github.com/plotsklapps/GYMPLY/releases/latest/'
                  'download/gymply.apk',
                ),
              ),
              const SizedBox(width: 40),
              StoreBadge(
                asset: 'assets/images/googlelogo.png',
                onTap: () => _launchUrl(
                  'https://play.google.com/store/apps/details?id=dev.plotsklapps.gymply',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),

        // 4. Scroll Hint
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: ScrollHint(),
        ),
      ],
    );
  }
}
