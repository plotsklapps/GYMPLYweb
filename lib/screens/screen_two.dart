import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymplyweb/widgets/scroll_hint.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  static const List<String> _exercises = <String>[
    'barbell-bench-press',
    'barbell-deadlift',
    'barbell-squat',
    'cable-crossover',
    'dumbbell-crunch',
    'dumbbell-fly',
    'dumbbell-press',
    'ezbar-curl',
    'leg-extension',
    'leg-curl',
    'leg-raise',
    'triceps-pushdown',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: SingleChildScrollView(
            // Disable internal scroll to allow PageView to handle snapping
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                        'MINIMALIST',
                        style: TextStyle(
                          color: Color(0xFFFCB075),
                          fontFamily: 'Bebas Neue',
                          fontSize: 80,
                          height: 0.9,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.2, end: 0),
                  const Text(
                    'OFFLINE WORKOUT TRACKER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFDEDEDE),
                      fontFamily: 'Bebas Neue',
                      fontSize: 32,
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                  const SizedBox(height: 80),

                  // Dynamic Overlapping Exercise Cards
                  SizedBox(
                    height: 450,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ....generate(_exercises.length, (
                          int index,
                        ) {
                          final String exercise = _exercises[index];
                          final math.Random random = math.Random(index);
                          final double angle =
                              (random.nextDouble() * 0.4) - 0.2;
                          final double offsetX =
                              (random.nextDouble() * 200) - 100;
                          final double offsetY =
                              (random.nextDouble() * 120) - 60;

                          return _WorkoutCard(
                            title: exercise.replaceAll('-', ' ').toUpperCase(),
                            asset: 'assets/images/exercises/$exercise.webp',
                            angle: angle,
                            offset: Offset(offsetX, offsetY),
                            delay: (300 + (index * 100)).ms,
                          );
                        }),
                        // Final "4000+ Exercises" Card
                        _InfoCard(
                          text: '4000+\nEXERCISES',
                          angle: 0.05,
                          offset: const Offset(20, 20),
                          delay: (300 + (_exercises.length * 100)).ms,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space for ScrollHint
                ],
              ),
            ),
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
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({
    required this.title,
    required this.asset,
    required this.angle,
    required this.offset,
    required this.delay,
  });
  final String title;
  final String asset;
  final double angle;
  final Offset offset;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
          offset: offset,
          child: Transform.rotate(
            angle: angle,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 280,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFCB075).withAlpha(102),
                      width: 2,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withAlpha(153),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      asset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFFCB075),
                    fontFamily: 'Teko',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: delay, duration: 500.ms)
        .scale(
          begin: const Offset(0.7, 0.7),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.text,
    required this.angle,
    required this.offset,
    required this.delay,
  });
  final String text;
  final double angle;
  final Offset offset;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
          offset: offset,
          child: Transform.rotate(
            angle: angle,
            child: Container(
              width: 280,
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFCB075),
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withAlpha(153),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Bebas Neue',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: delay, duration: 600.ms)
        .scale(
          begin: const Offset(0.6, 0.6),
          end: const Offset(1, 1),
          curve: Curves.elasticOut,
        );
  }
}
