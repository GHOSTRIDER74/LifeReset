// lib/onboarding/onboarding_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';
import 'screens/name_screen.dart';
import 'screens/ratings_screen.dart';
import 'screens/anti_identity_screen.dart';
import 'screens/plan_preview_screen.dart';
import 'screens/vow_screen.dart';
import 'screens/first_win_screen.dart';

// Placeholder home — replace in Phase 6
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

Future<GoRouter> buildRouter() async {
  final prefs = await SharedPreferences.getInstance();

  return GoRouter(
    initialLocation: '/onboarding/splash',
    redirect: (context, state) {
      final done = prefs.getBool('onboarding_complete') ?? false;
      final onOnboarding = state.fullPath?.startsWith('/onboarding') ?? false;

      if (!done && !onOnboarding) return '/onboarding/splash';
      if (done && onOnboarding) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding/name',
        builder: (context, state) => const NameScreen(),
      ),
      GoRoute(
        path: '/onboarding/ratings',
        builder: (context, state) => const RatingsScreen(),
      ),
      GoRoute(
        path: '/onboarding/anti-identity',
        builder: (context, state) => const AntiIdentityScreen(),
      ),
      GoRoute(
        path: '/onboarding/plan-preview',
        builder: (context, state) => const PlanPreviewScreen(),
      ),
      GoRoute(
        path: '/onboarding/vow',
        builder: (context, state) => const VowScreen(),
      ),
      GoRoute(
        path: '/onboarding/first-win',
        builder: (context, state) => const FirstWinScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}