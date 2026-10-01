import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymplyweb/widgets/store_badge.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenFive extends StatelessWidget {
  const new({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double screenWidth = constraints.maxWidth;
        final bool isMobile = screenWidth < 900;

        return Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 20 : 40,
                horizontal: isMobile ? 16 : 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                        'REVIEWS',
                        style: TextStyle(
                          color: Color(0xFFFCB075),
                          fontFamily: 'Bebas Neue',
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 4),
                  const Text(
                    '5-STAR FEEDBACK FROM GYMPLY USERS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFDEDEDE),
                      fontFamily: 'Bebas Neue',
                      fontSize: 24,
                      letterSpacing: 1.5,
                    ),
                  ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
                  SizedBox(height: isMobile ? 16 : 30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: isMobile
                        ? const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _ReviewCard(
                                reviewerName: 'Rishav Dev Sharma',
                                reviewerInitial: 'R',
                                reviewText:
                                    'I really like the app and the offline '
                                    'functionality. I would appreciate a way '
                                    'to save workouts instead of adding them '
                                    'every time. Also, an option to toggle '
                                    'between pounds and kilograms would be '
                                    'great; I currently have to use the '
                                    'handy calculator every time I enter my '
                                    'weight.',
                                devResponse:
                                    'Hi! Thanks for the great feedback, '
                                    'appreciate it a lot! To reuse your '
                                    'workouts: Copy any workout from your '
                                    'calendar, with or without the '
                                    'weights/reps/duration data. About '
                                    'the weights: '
                                    'This toggle has been added in the '
                                    '0.0.7+76 version! Thank you for your '
                                    'valuable feedback!',
                                delay: 200,
                              ),
                              SizedBox(height: 12),
                              _ReviewCard(
                                reviewerName: 'Harith Haroon',
                                reviewerInitial: 'H',
                                reviewText:
                                    'What I like most is how well the '
                                    'workouts are organized and '
                                    'categorized. All data stays on my '
                                    'device, it is easy and intuitive to '
                                    'use.',
                                devResponse:
                                    'Thank you so much for your great '
                                    'review! Good to hear the '
                                    'privacy-friendly approach of GYMPLY '
                                    'works well for you. '
                                    "I'll keep "
                                    'improving GYMPLY, enjoy your workouts!',
                                delay: 400,
                              ),
                              SizedBox(height: 12),
                              _ReviewCard(
                                reviewerName: 'Kim van Wijk',
                                reviewerInitial: 'K',
                                reviewText:
                                    'Great app, everything works as you '
                                    'would expect. Good to know that '
                                    'privacy is well secured. Recommended '
                                    'for tracking your workouts. Also nice '
                                    'to get inspiration for other '
                                    'exercises!',
                                devResponse:
                                    'Thank you for your great review! '
                                    'Good to hear that everything works and '
                                    'that the privacy-friendly approach is '
                                    'appreciated. Good luck with your '
                                    'workouts!',
                                delay: 600,
                              ),
                            ],
                          )
                        : const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: _ReviewCard(
                                  reviewerName: 'Rishav Dev Sharma',
                                  reviewerInitial: 'R',
                                  reviewText:
                                      'I really like the app and the offline '
                                      'functionality. I would appreciate a '
                                      'way to save workouts instead of adding '
                                      'them every time. Also, an option to '
                                      'toggle between pounds and kilograms '
                                      'would be great; I currently have to '
                                      'use the handy calculator every time '
                                      'I enter my weight.',
                                  devResponse:
                                      'Hi! Thanks for the great feedback, '
                                      'appreciate it a lot! To reuse your '
                                      'workouts: Copy any workout from your '
                                      'calendar, with or without the '
                                      'weights/reps/duration data. About '
                                      'the weights: This toggle has been '
                                      'added in the 0.0.7+76 version! Thank '
                                      'you for your valuable feedback!',
                                  delay: 200,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: _ReviewCard(
                                  reviewerName: 'Harith Haroon',
                                  reviewerInitial: 'H',
                                  reviewText:
                                      'What I like most is how well the '
                                      'workouts are organized and '
                                      'categorized. All data stays on my '
                                      'device, it is easy and intuitive to '
                                      'use.',
                                  devResponse:
                                      'Thank you so much for your great '
                                      'review! Good to hear the '
                                      'privacy-friendly approach of GYMPLY '
                                      'works well for you. '
                                      "I'll keep "
                                      'improving GYMPLY, enjoy your workouts!',
                                  delay: 400,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: _ReviewCard(
                                  reviewerName: 'Kim van Wijk',
                                  reviewerInitial: 'K',
                                  reviewText:
                                      'Great app, everything works as you '
                                      'would expect. Good to know that '
                                      'privacy is well secured. Recommended '
                                      'for tracking your workouts. Also '
                                      'nice to get inspiration for other '
                                      'exercises!',
                                  devResponse:
                                      'Thank you for your great review! '
                                      'Good to hear that everything works '
                                      'and that the privacy-friendly '
                                      'approach is appreciated. Good luck '
                                      'with your workouts!',
                                  delay: 600,
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: isMobile ? 20 : 36),
                  // Store Badges
                  Row(
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
                  ).animate().fadeIn(delay: 800.ms, duration: 400.ms),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const new({
    required this.reviewerName,
    required this.reviewerInitial,
    required this.reviewText,
    required this.delay,
    this.devResponse,
  });

  final String reviewerName;
  final String reviewerInitial;
  final String reviewText;
  final String? devResponse;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFCB075).withAlpha(77),
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(153),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Reviewer Header
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFFFCB075),
                    child: Text(
                      reviewerInitial,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Bebas Neue',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          reviewerName,
                          style: const TextStyle(
                            color: Color(0xFFFCB075),
                            fontFamily: 'Bebas Neue',
                            fontSize: 19,
                            letterSpacing: 1.1,
                          ),
                        ),
                        _StarRating(delay: delay),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                reviewText,
                style: const TextStyle(
                  color: Color(0xFFDEDEDE),
                  fontFamily: 'Teko',
                  fontSize: 19,
                  height: 1.2,
                ),
              ),
              if (devResponse != null) ...<Widget>[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(120),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFCB075).withAlpha(51),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipOval(
                            child: Image.asset(
                              'assets/images/gymplylogo.png',
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'DEVELOPER RESPONSE',
                            style: TextStyle(
                              color: Color(0xFFFCB075),
                              fontFamily: 'Bebas Neue',
                              fontSize: 16,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        devResponse!,
                        style: const TextStyle(
                          color: Color(0xFFDEDEDE),
                          fontFamily: 'Teko',
                          fontSize: 17,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(delay: delay.ms, duration: 500.ms)
        .slideY(begin: 0.15, end: 0, curve: Curves.easeOutQuad);
  }
}

class _StarRating extends StatelessWidget {
  const new({required this.delay});

  final int delay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(5, (int index) {
        final Duration starDelay = (delay + (index * 100)).ms;
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child:
              const Icon(Icons.star_rounded, color: Color(0xFFFCB075), size: 20)
                  .animate()
                  .scale(
                    delay: starDelay,
                    duration: 400.ms,
                    curve: Curves.easeOutBack,
                    begin: Offset.zero,
                    end: const Offset(1, 1),
                  )
                  .fadeIn(delay: starDelay, duration: 300.ms),
        );
      }),
    );
  }
}
