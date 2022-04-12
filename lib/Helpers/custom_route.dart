import 'package:flutter/material.dart';

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({
    required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Widget buildTransitions(
    BuildContext context,

    ///a value that changes over time
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    //don't animate on first route
    if (settings.name == '/') {
      return child;
    }
    return FadeTransition(
      child: child,
      opacity: animation,
    );
  }
}

class SlideRoute<T> extends MaterialPageRoute<T> {
  SlideRoute({
    required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Widget buildTransitions(
    BuildContext context,

    ///a value that changes over time
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    //don't animate on first route
    if (settings.name == '/') {
      return child;
    }
    return SlideTransition(
      position: Tween<Offset>(
        //from left bottom
        begin: const Offset(-1, 1),
        //to screen
        end: const Offset(0, 0),
      ).animate(animation),
      child: child,
    );
  }
}
