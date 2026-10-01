import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymplyweb/screens/screen_five.dart';
import 'package:gymplyweb/screens/screen_four.dart';
import 'package:gymplyweb/screens/screen_one.dart';
import 'package:gymplyweb/screens/screen_three.dart';
import 'package:gymplyweb/screens/screen_two.dart';
import 'package:material_ui/material_ui.dart';

class MainScroller extends StatefulWidget {
  const new({super.key});

  @override
  State<MainScroller> createState() => _MainScrollerState();
}

class _MainScrollerState extends State<MainScroller> {
  final PageController _controller = PageController();
  bool _isAnimating = false;
  static const int _pageCount = 5;
  int _maxPageReached = 0;

  static const List<String> _screenNames = <String>[
    'screen_1_landing',
    'screen_2_showcase',
    'screen_3_features',
    'screen_4_screenshots',
    'screen_5_reviews',
  ];

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
    if (index < 0 || index >= _screenNames.length) return;

    final String screenName = _screenNames[index];
    final bool isNewDeepest = index > _maxPageReached;
    if (isNewDeepest) {
      _maxPageReached = index;
    }

    // 1. Official Firebase Analytics Screen View
    unawaited(
      FirebaseAnalytics.instance.logScreenView(
        screenName: screenName,
        screenClass: 'MainScroller',
      ),
    );

    // 2. Custom Funnel Event for Conversion Analysis
    unawaited(
      FirebaseAnalytics.instance.logEvent(
        name: 'page_view_custom',
        parameters: <String, Object>{
          'screen_name': screenName,
          'page_number': index + 1,
          'total_pages': _pageCount,
          'max_page_reached': _maxPageReached + 1,
          'is_new_deepest_page': isNewDeepest ? 1 : 0,
          'is_final_page': index == _pageCount - 1 ? 1 : 0,
        },
      ),
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
        .animateToPage(page, duration: 800.ms, curve: Curves.easeInOutCubic)
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
            unawaited(_scrollToPage((_controller.page! + 1).round()));
          } else if (details.primaryVelocity! > 100 && _controller.page! > 0) {
            // Swipe omlaag -> Vorige pagina
            unawaited(_scrollToPage((_controller.page! - 1).round()));
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
              ScreenFive(),
            ],
          ),
        ),
      ),
    );
  }
}
