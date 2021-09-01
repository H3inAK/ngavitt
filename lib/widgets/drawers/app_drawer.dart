import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;

import '../../themes/theme_service.dart';
import '../../helpers/custom_routes.dart';
import '../../screens/home_screen.dart';
import '../../screens/preventation_screen.dart';
import '../../pages/pie_chart_global.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final lightIcon = Icon(Icons.wb_sunny);
  final darkIcon = Icon(Icons.mode_night_sharp);
  var isIconAnimated = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildDrawerHeader(),
                  buildDrawerItem(
                    Icons.home_filled,
                    "See All Status",
                    () => Navigator.of(context).pushReplacement(
                      // FadedPageRoute(
                      //   child: HomeScreen(),
                      // ),
                      CustomRoute(
                        builder: (ctx) => HomeScreen(),
                      ),
                    ),
                  ),
                  buildDrawerItem(
                    Icons.masks_sharp,
                    "Preventions",
                    () => Navigator.of(context).pushReplacement(
                      CustomRoute(
                        builder: (ctx) => PreventationScreen(),
                      ),
                    ),
                  ),
                  buildDrawerItem(
                    Icons.insert_chart_rounded,
                    "Global PieChart",
                    () => Navigator.of(context).pushReplacement(
                      // PopupScalePageRoute(
                      //   child: PieChartPage(),
                      // ),
                      CustomRoute(
                        builder: (ctx) => PieChartPage(),
                      ),
                    ),
                  ),
                ],
              ),
              buildAnimatedThemeSwithcherIconButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedThemeSwithcherIconButton() {
    var themeBrightness = ThemeProvider.of(context).brightness;
    var themeName = themeBrightness == Brightness.light ? 'dark' : 'light';

    return Positioned(
      top: kIsWeb ? 16 : 0,
      right: kIsWeb ? 20 : 10,
      child: ThemeSwitcher(
        builder: (context) {
          /// animation doesn't work
          /// fit it later on
          return GestureDetector(
            onTap: () async {
              setState(() {
                themeName =
                    themeBrightness == Brightness.light ? 'dark' : 'light';
              });
              var service = await ThemeService.instance
                ..save(themeName);
              var theme = service.getByName(themeName);

              ThemeSwitcher.of(context).changeTheme(
                theme: theme,
                reverseAnimation: themeName == 'light' ? true : false,
              );
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              switchOutCurve: Curves.elasticIn,
              switchInCurve: Curves.elasticOut,
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.vertical,
                  child: child,
                );
              },
              // layoutBuilder: (currentChild, previousChildren) {
              //   return Column(
              //     children: [
              //       ...previousChildren,
              //       currentChild,
              //     ],
              //   );
              // },
              child: themeName == 'dark' ? darkIcon : lightIcon,
            ),
          );
        },
      ),
    );
  }

  Widget buildDrawerHeader() {
    return Container(
      child: DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInCubic,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 90,
                height: 90,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/virus.svg",
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).accentColor,
                ),
              ),
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: (pi * 2) * value,
                  child: child,
                );
              },
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 740),
              curve: Curves.bounceInOut,
              child: Text(
                "NGAVITT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Theme.of(context).accentColor,
                ),
              ),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, (1 - value) * -60),
                  child: Transform.scale(
                    scale: value,
                    child: child,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildDrawerItem(
      IconData iconData, String title, Function tapHandler) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      onTap: tapHandler,
      leading: Icon(
        iconData,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        title,
      ),
    );
  }
}
