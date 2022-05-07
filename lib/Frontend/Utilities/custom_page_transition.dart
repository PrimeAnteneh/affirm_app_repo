import 'package:flutter/material.dart';

class LeftFadePageTransition extends PageRouteBuilder {
  final Widget child;
  LeftFadePageTransition({required this.child})
      : super(
          transitionDuration: const Duration(
            milliseconds: 300,
          ),
          reverseTransitionDuration: const Duration(
            milliseconds: 200,
          ),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.5, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0.1,
            end: 1,
          ).animate(animation),
          child: child,
        ),
      );
}

class ScaleFadePageTransition extends PageRouteBuilder {
  final Widget child;
  ScaleFadePageTransition({required this.child})
      : super(
          transitionDuration: const Duration(
            milliseconds: 200,
          ),
          reverseTransitionDuration: const Duration(
            milliseconds: 200,
          ),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      ScaleTransition(
        scale: Tween<double>(
          begin: 0.1,
          end: 1,
        ).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0.1,
            end: 1,
          ).animate(animation),
          child: child,
        ),
      );
}

class CircleRevealClipper extends CustomClipper<Path> {
  final Offset? center;
  final double? radius;

  CircleRevealClipper({this.center, this.radius});

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(radius: radius!, center: center!),
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
