import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymplyweb/widgets/scroll_hint.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;
          final bool isMobile = screenWidth < 800;

          // Dynamically scale font sizes based on screen height to ensure fit
          final double titleFontSize = (screenHeight * (isMobile ? 0.04 : 0.05))
              .clamp(isMobile ? 22.0 : 24.0, 48.0);
          final double descFontSize =
              (screenHeight * (isMobile ? 0.018 : 0.025)).clamp(
                isMobile ? 12.0 : 14.0,
                22.0,
              );
          final double verticalPadding = screenHeight * 0.05;

          return Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: isMobile ? 20 : 40,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: isMobile ? 1 : 2,
                            mainAxisSpacing: isMobile ? 12 : 30,
                            crossAxisSpacing: 60,
                            childAspectRatio: isMobile ? 4.5 : 3.0,
                            children: <Widget>[
                              _FeatureBox(
                                title: '100% PRIVATE',
                                description:
                                    'No cloud. No accounts. No tracking.\n'
                                    'Your data stays on your device.',
                                delay: 0,
                                titleSize: titleFontSize,
                                descSize: descFontSize,
                              ),
                              _FeatureBox(
                                title: 'FREE FOREVER',
                                description:
                                    'No subscriptions. No ads. No paywalls.\n'
                                    'No nonsense.',
                                delay: 200,
                                titleSize: titleFontSize,
                                descSize: descFontSize,
                              ),
                              _FeatureBox(
                                title: '4000+ EXERCISES',
                                description:
                                    'Massive database with clear visuals and\n'
                                    'instructions for every musclegroup.',
                                delay: 400,
                                titleSize: titleFontSize,
                                descSize: descFontSize,
                              ),
                              _FeatureBox(
                                title: 'STRONG INSIGHTS',
                                description:
                                    'Clear stats and history to help you\n'
                                    'progress with confidence.',
                                delay: 600,
                                titleSize: titleFontSize,
                                descSize: descFontSize,
                              ),
                              _FeatureBox(
                                title: 'OFFLINE FIRST',
                                description:
                                    'Train anywhere. Log everything.\n'
                                    'Even without internet.',
                                delay: 800,
                                titleSize: titleFontSize,
                                descSize: descFontSize,
                              ),
                              _FeatureBox(
                                title: 'NOSTR READY',
                                description:
                                    'Share workouts via the Nostr protocol.\n'
                                    'Fully optional, fully private.',
                                delay: 1000,
                                titleSize: titleFontSize,
                                descSize: descFontSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: ScrollHint(),
              ),
            ],
          );
        },
    );
  }
}

class _FeatureBox extends StatelessWidget {
  const _FeatureBox({
    required this.title,
    required this.description,
    required this.delay,
    required this.titleSize,
    required this.descSize,
  });
  final String title;
  final String description;
  final int delay;
  final double titleSize;
  final double descSize;

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFFCB075),
                  fontFamily: 'Bebas Neue',
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFDEDEDE),
                fontFamily: 'Teko',
                fontSize: descSize,
                height: 1.2,
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: delay.ms, duration: 500.ms)
        .slideY(
          begin: 0.1,
          end: 0,
          curve: Curves.easeOutQuad,
        );
  }
}
