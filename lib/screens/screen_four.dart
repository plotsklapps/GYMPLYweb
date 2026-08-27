import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymplyweb/widgets/store_badge.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenFour extends StatefulWidget {
  const ScreenFour({super.key});

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  final CarouselController _carouselController = CarouselController();
  Timer? _timer;
  int _currentIndex = 0;
  static const int _screenshotCount = 6;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) async {
      if (!mounted) return;
      _currentIndex = (_currentIndex + 1) % _screenshotCount;
      await _carouselController.animateToItem(
        _currentIndex,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutQuart,
      );
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> screenshots = List<String>.generate(
      _screenshotCount,
      (int index) => 'assets/images/screenshots/screenshot-${index + 1}.png',
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isMobile = constraints.maxWidth < 800;

          return Column(
            children: <Widget>[
              const SizedBox(height: 40),
              const Text(
                'EXPERIENCE GYMPLY',
                style: TextStyle(
                  color: Color(0xFFFCB075),
                  fontFamily: 'Bebas Neue',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Modern Material 3 CarouselView
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CarouselView.weighted(
                    controller: _carouselController,
                    itemSnapping: true,
                    flexWeights: isMobile
                        ? const <int>[1]
                        : const <int>[1, 5, 1],
                    children: screenshots.map((String asset) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withAlpha(150),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Image.asset(
                            asset,
                            fit: BoxFit.contain,
                            color: Colors.black.withAlpha(15),
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Download Buttons
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
            ],
          );
        },
      ),
    );
  }
}
