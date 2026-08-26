import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScrollHint extends StatelessWidget {
  const ScrollHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'SCROLL DOWN FOR MORE',
          style: TextStyle(
            color: Color(0xFFDEDEDE),
            fontFamily: 'Teko',
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFFFCB075),
              size: 32,
            )
            .animate(
              onPlay: (AnimationController controller) => controller.repeat(),
            )
            .moveY(
              begin: -5,
              end: 5,
              duration: 1000.ms,
              curve: Curves.easeInOut,
            )
            .fadeIn(duration: 1000.ms),
      ],
    );
  }
}
