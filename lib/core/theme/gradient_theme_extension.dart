import 'package:flutter/material.dart';

@immutable
class GradientThemeExtension extends ThemeExtension<GradientThemeExtension> {
  final LinearGradient backgroundGradient;

  const GradientThemeExtension({required this.backgroundGradient});

  @override
  GradientThemeExtension copyWith({LinearGradient? backgroundGradient}) {
    return GradientThemeExtension(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  ThemeExtension<GradientThemeExtension> lerp(
      ThemeExtension<GradientThemeExtension>? other, double t) {
    if (other is! GradientThemeExtension) return this;
    return GradientThemeExtension(
      backgroundGradient: LinearGradient.lerp(
        backgroundGradient,
        other.backgroundGradient,
        t,
      )!,
    );
  }
}
