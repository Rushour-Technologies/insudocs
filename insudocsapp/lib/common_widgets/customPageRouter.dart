import 'package:flutter/cupertino.dart';

class CustomPageRouter extends PageRouteBuilder {
  /// A custom router for the given [child] widget. Contains custom animation.
  final Widget child;

  CustomPageRouter({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) =>
              child, // Takes parameters of pageBuilder constructor and returns a pageBuilder child
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        // Applies a tween transition to pageBuilder child and returns it.
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
