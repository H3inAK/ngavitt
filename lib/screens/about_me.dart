import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:covid19app/widgets/drawers/app_drawer.dart';
import 'package:flutter/material.dart';

class AboutAuthor extends StatefulWidget {
  const AboutAuthor({Key key}) : super(key: key);

  @override
  _AboutAuthorState createState() => _AboutAuthorState();
}

class _AboutAuthorState extends State<AboutAuthor>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("About Author"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ShakeTransition(
                curve: Curves.elasticOut,
                offset: -400,
                duration: const Duration(milliseconds: 800),
                axis: Axis.vertical,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(
                    'assets/images/me.jpg',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ShakeTransition(
              curve: Curves.bounceOut,
              axis: Axis.horizontal,
              duration: const Duration(milliseconds: 800),
              offset: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hein Arkar",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            ShakeTransition(
              curve: Curves.bounceOut,
              axis: Axis.horizontal,
              duration: const Duration(milliseconds: 1200),
              offset: 100,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  '''My name is Hein Arkar\n
                  I am junior flutter software developer\n
                  I am from Myanmar(Burma)\n
                  This is version 2.0.0+4 and I'm having my best focus on it to develop\n
                  you can reach me via below github link''',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 30),
            ShakeTransition.repeatTransition(
              animationController: _animationController,
              child: SelectableText(
                "https://github.com/Hein-Arkar",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double offset;
  final Axis axis;

  const ShakeTransition({
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.elasticOut,
    this.offset = 140,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  static Widget repeatTransition({
    @required Widget child,
    @required AnimationController animationController,
    Duration duration = const Duration(milliseconds: 250),
    double offset = 100,
    Axis axis = Axis.horizontal,
  }) {
    Timer(
      Duration(milliseconds: 800),
      () => animationController.stop(),
    );

    return AnimatedBuilder(
      animation: animationController,
      child: child,
      builder: (ctx, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(
                  animationController.value * offset,
                  0.0,
                )
              : Offset(
                  0.0,
                  animationController.value * offset,
                ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 1.0,
        end: 0.0,
      ),
      curve: curve,
      child: child,
      duration: duration,
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(offset * value, 0.0)
              : Offset(0.0, offset * value),
          child: child,
        );
      },
    );
  }
}
