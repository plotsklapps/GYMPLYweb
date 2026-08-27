import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymplyweb/screens/screen_four.dart';
import 'package:gymplyweb/screens/screen_one.dart';
import 'package:gymplyweb/screens/screen_three.dart';
import 'package:gymplyweb/screens/screen_two.dart';

class MainScroller extends StatefulWidget {
  const MainScroller({super.key});

  @override
  State<MainScroller> createState() => _MainScrollerState();
}

class _MainScrollerState extends State<MainScroller> {
  final PageController _controller = PageController();
  bool _isAnimating = false;
  static const int _pageCount = 4;

  @override
  void initState() {
    super.initState();
    _logPageView(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _logPageView(int index) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': 'screen_${index + 1}',
        'firebase_screen_class': 'MainScroller',
      },
    );
  }

  Future<void> _handlePointerSignal(PointerSignalEvent event) async {
    if (event is PointerScrollEvent && !_isAnimating) {
      if (event.scrollDelta.dy > 10 && _controller.page! < _pageCount - 1) {
        await _scrollToPage((_controller.page! + 1).round());
      } else if (event.scrollDelta.dy < -10 && _controller.page! > 0) {
        await _scrollToPage((_controller.page! - 1).round());
      }
    }
  }

  Future<void> _scrollToPage(int page) async {
    setState(() => _isAnimating = true);
    await _controller
        .animateToPage(
          page,
          duration: 800.ms,
          curve: Curves.easeInOutCubic,
        )
        .then((_) {
          if (mounted) {
            setState(() => _isAnimating = false);
            _logPageView(page);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragEnd: (DragEndDetails details) {
          if (_isAnimating) return;

          // Swipe gevoeligheid instellen
          if (details.primaryVelocity! < -100 &&
              _controller.page! < _pageCount - 1) {
            // Swipe omhoog -> Volgende pagina
            _scrollToPage((_controller.page! + 1).round());
          } else if (details.primaryVelocity! > 100 && _controller.page! > 0) {
            // Swipe omlaag -> Vorige pagina
            _scrollToPage((_controller.page! - 1).round());
          }
        },
        child: Listener(
          onPointerSignal: _handlePointerSignal,
          child: PageView(
            controller: _controller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: const <Widget>[
              ScreenOne(),
              ScreenTwo(),
              ScreenThree(),
              ScreenFour(),
            ],
          ),
        ),
      ),
    );
  }
}
