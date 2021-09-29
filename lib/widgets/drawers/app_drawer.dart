import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_service.dart';
import '../../helpers/custom_routes.dart';
import '../../providers/app_drawer_provider.dart';
import '../../providers/language_provider.dart';
import '../../screens/home_screen.dart';
import '../../screens/prevention_screen.dart';
import '../../screens/contact_me.dart';
import '../../pages/applanguage_setting.dart';
import '../../pages/pie_chart_global.dart';

class AppDrawer extends StatefulWidget {
  final Function(int) onSelected;

  AppDrawer({this.onSelected});

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
    final appLang =
        Provider.of<LanguageProvider>(context, listen: false).appLanguage;
    var appDrawerProvider =
        Provider.of<AppDrawerProvider>(context, listen: false);

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildDrawerHeader(appLang),
                  buildDrawerItem(
                    currentMenuItem: appDrawerProvider.currentMenuItem,
                    item: 0,
                    iconData: Icons.home_filled,
                    title: appLang['seeallstatus'],
                    onClicked: () {
                      appDrawerProvider.setMenuItem = 0;
                      Navigator.of(context).pushReplacement(
                        AppDrawerMenutItemRoute(
                          builder: (ctx) => HomeScreen(),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    currentMenuItem: appDrawerProvider.currentMenuItem,
                    item: 1,
                    iconData: Icons.masks_sharp,
                    title: appLang['preventions'],
                    onClicked: () {
                      appDrawerProvider.setMenuItem = 1;
                      Navigator.of(context).pushReplacement(
                        AppDrawerMenutItemRoute(
                          builder: (ctx) => PreventionScreen(),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    currentMenuItem: appDrawerProvider.currentMenuItem,
                    item: 2,
                    iconData: Icons.bar_chart,
                    title: appLang['globalpiechart'],
                    onClicked: () {
                      appDrawerProvider.setMenuItem = 2;
                      Navigator.of(context).pushReplacement(
                        AppDrawerMenutItemRoute(
                          builder: (ctx) => PieChartPage(),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    currentMenuItem: appDrawerProvider.currentMenuItem,
                    item: 3,
                    iconData: Icons.person_pin_sharp,
                    title: appLang['contactme'],
                    onClicked: () {
                      appDrawerProvider.setMenuItem = 3;
                      Navigator.of(context).pushReplacement(
                        AppDrawerMenutItemRoute(
                          builder: (ctx) => AboutAuthor(),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    currentMenuItem: appDrawerProvider.currentMenuItem,
                    item: 4,
                    iconData: Icons.language,
                    title: appLang['changelanguage'],
                    onClicked: () {
                      appDrawerProvider.setMenuItem = 4;
                      Navigator.of(context).pushReplacement(
                        AppDrawerMenutItemRoute(
                          builder: (ctx) => LanguageSetting(),
                        ),
                      );
                    },
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
      top: kIsWeb ? 16 : 6,
      right: kIsWeb ? 20 : 13,
      child: ThemeSwitcher(
        builder: (context) {
          return GestureDetector(
            onTap: () async {
              var service = await ThemeService.instance
                ..save(themeName);
              var theme = service.getByName(themeName);

              ThemeSwitcher.of(context).changeTheme(
                theme: theme,
                reverseAnimation: themeName == 'light' ? true : false,
              );
              setState(() {
                themeName =
                    themeBrightness == Brightness.light ? 'dark' : 'light';
              });
            },
            // child: TweenAnimationBuilder<double>(
            //   tween: Tween(begin: 1.0, end: 0.0),
            //   duration: const Duration(milliseconds: 1000),
            //   builder: (ctx, value, child) {
            //     print(value);
            //     return themeName == 'dark'
            //         ? Transform.translate(
            //             offset: Offset(0.0, -100 * value),
            //             child: Transform.rotate(
            //               angle: (2 * pi) * (1 - value),
            //               child: darkIcon,
            //             ),
            //           )
            //         : Transform.rotate(
            //             angle: (2 * pi) * (1 - value),
            //             child: Transform.scale(
            //               scale: (1 - value),
            //               child: lightIcon,
            //             ),
            //           );
            //   },
            // ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              switchOutCurve: Curves.elasticIn,
              switchInCurve: Curves.elasticOut,
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  key: UniqueKey(),
                  sizeFactor: animation,
                  axis: Axis.vertical,
                  child: child,
                );
              },
              layoutBuilder: (currentChild, previousChildren) {
                return Column(
                  children: [
                    ...previousChildren,
                    currentChild,
                  ],
                );
              },
              child: themeName == 'dark' ? darkIcon : lightIcon,
            ),
          );
        },
      ),
    );
  }

  Widget buildDrawerHeader(Map appLang) {
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

  Widget buildDrawerItem({
    IconData iconData,
    String title,
    Function onClicked,
    int item,
    int currentMenuItem,
  }) {
    return ListTileTheme(
      minLeadingWidth: 20,
      selectedColor: Theme.of(context).accentColor,
      selectedTileColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white30
          : Colors.black26,
      child: ListTile(
        selected: item == currentMenuItem,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        onTap: onClicked,
        leading: Icon(
          iconData,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          title,
        ),
      ),
    );
  }
}
