// lib/onboarding/onboarding_state.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─────────────────────────────────────────
// The data model — everything collected during onboarding
// ─────────────────────────────────────────

class OnboardingData {
  final String name;
  final Map<String, int> ratings;
  final String antiIdentity;

  const OnboardingData({
    this.name = '',
    this.ratings = const {
      'Body': 3,
      'Mind': 3,
      'Rest': 3,
      'Fuel': 3,
      'Connection': 3,
      'Purpose': 3,
    },
    this.antiIdentity = '',
  });

  // copyWith lets us update one field without touching the rest
  OnboardingData copyWith({
    String? name,
    Map<String, int>? ratings,
    String? antiIdentity,
  }) {
    return OnboardingData(
      name: name ?? this.name,
      ratings: ratings ?? this.ratings,
      antiIdentity: antiIdentity ?? this.antiIdentity,
    );
  }
}

// ─────────────────────────────────────────
// The notifier — methods screens call to update state
// ─────────────────────────────────────────

class OnboardingNotifier extends StateNotifier<OnboardingData> {
  OnboardingNotifier() : super(const OnboardingData());

  void setName(String name) {
    state = state.copyWith(name: name.trim());
  }

  void setRating(String area, int rating) {
    // Ratings map is const by default, so we make a mutable copy first
    final updated = Map<String, int>.from(state.ratings);
    updated[area] = rating;
    state = state.copyWith(ratings: updated);
  }

  void setAntiIdentity(String text) {
    state = state.copyWith(antiIdentity: text.trim());
  }

  void reset() {
    state = const OnboardingData();
  }
}

// ─────────────────────────────────────────
// The provider — how screens access the notifier
// ─────────────────────────────────────────

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingData>(
  (ref) => OnboardingNotifier(),
);