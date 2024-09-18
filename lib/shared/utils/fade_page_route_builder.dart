import 'package:flutter/material.dart';

class FadePageRouteBuilder<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  @override
  final RouteSettings settings;
  final Curve transitionCurve;

  FadePageRouteBuilder({
    required this.builder,
    required this.settings,
    this.transitionCurve = Curves.ease,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<double>(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: transitionCurve));

      final fadeAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    settings: settings,
  );
}
