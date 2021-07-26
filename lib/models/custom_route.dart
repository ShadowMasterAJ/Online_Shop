import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings routeSettings})
      : super(builder: builder, settings: routeSettings);
}

class CustomPageTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> pageRoute,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (pageRoute.settings.name == '/') {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
