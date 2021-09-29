import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimplePageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin {
  final WidgetBuilder builder;
  final Duration duration;
  final bool stateMaintain;

  SimplePageRoute({
    @required this.builder,
    @required this.duration,
    this.stateMaintain,
  });

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  Duration get transitionDuration => duration;

  @override
  bool get maintainState => stateMaintain ?? true;
}

class CustomPageTransactionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SizeTransition(
      sizeFactor: animation,
      child: child,
    );
  }
}

class AppDrawerMenutItemRoute<T> extends MaterialPageRoute<T> {
  AppDrawerMenutItemRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.bounceInOut,
      ),
      child: child,
    );
  }
}

class PopupScalePageRoute extends PageRouteBuilder {
  final Widget child;
  final Duration duration;

  PopupScalePageRoute({
    this.duration,
    this.child,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimatioin) => child,
          transitionDuration: duration ?? const Duration(milliseconds: 500),
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

class FadedPageRoute extends PageRouteBuilder {
  final Widget child;
  final Duration duration;

  FadedPageRoute({
    this.duration,
    this.child,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimatioin) => child,
          transitionDuration: duration ?? const Duration(milliseconds: 500),
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
