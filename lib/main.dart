import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gymplyweb/firebase_options.dart';
import 'package:gymplyweb/widgets/main_scroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GymplyWeb());
}

class GymplyWeb extends StatelessWidget {
  const GymplyWeb({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFFCB075);
    const Color textColor = Color(0xFFDEDEDE);
    const Color backgroundColor = Color(0xFF000000);

    return MaterialApp(
      title: 'GYMPLY',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentColor,
          primary: accentColor,
          onPrimary: backgroundColor,
          surface: backgroundColor,
          onSurface: textColor,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: accentColor, fontFamily: 'Bebas Neue'),
          displayMedium: TextStyle(
            color: accentColor,
            fontFamily: 'Bebas Neue',
          ),
          displaySmall: TextStyle(color: accentColor, fontFamily: 'Bebas Neue'),
          headlineLarge: TextStyle(
            color: accentColor,
            fontFamily: 'Bebas Neue',
          ),
          headlineMedium: TextStyle(
            color: accentColor,
            fontFamily: 'Bebas Neue',
          ),
          headlineSmall: TextStyle(
            color: accentColor,
            fontFamily: 'Bebas Neue',
          ),
          bodyLarge: TextStyle(color: textColor, fontFamily: 'Teko'),
          bodyMedium: TextStyle(color: textColor, fontFamily: 'Teko'),
          bodySmall: TextStyle(color: textColor, fontFamily: 'Teko'),
        ),
        useMaterial3: true,
      ),
      home: const MainScroller(),
    );
  }
}
