import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:covid19app/constants/constants.dart';
import 'package:covid19app/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../helpers/custom_routes.dart';
import '../../screens/home_screen.dart';
import '../../screens/preventation_screen.dart';
import '../../pages/pie_chart_global.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 90,
                        height: 90,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/icons/virus.svg",
                          width: double.infinity,
                          height: double.infinity,
                          color: kPrimaryColor,
                        ),
                      ),
                      Text(
                        "NGAVITT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                buildNavItems(
                  Icons.home,
                  "See All Status",
                  () => Navigator.of(context).pushReplacement(
                    CustomRoute(
                      builder: (ctx) => HomeScreen(),
                    ),
                  ),
                ),
                const Divider(thickness: 0.5),
                buildNavItems(
                  Icons.info,
                  "Preventations",
                  () => Navigator.of(context).pushReplacement(
                    CustomRoute(
                      builder: (ctx) => PreventationScreen(),
                    ),
                  ),
                ),
                const Divider(thickness: 0.5),
                buildNavItems(
                  Icons.insert_chart,
                  "Global PieChart",
                  () => Navigator.of(context).pushReplacement(
                    CustomRoute(
                      builder: (ctx) => PieChartPage(),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: ThemeSwitcher(
                builder: (context) {
                  return IconButton(
                    onPressed: () async {
                      print("pressed!");
                      var themeName = ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? 'dark'
                          : 'light';
                      var service = await ThemeService.instance
                        ..save(themeName);
                      var theme = service.getByName(themeName);

                      ThemeSwitcher.of(context).changeTheme(
                        theme: theme,
                        reverseAnimation: themeName == 'light' ? true : false,
                      );
                    },
                    icon:
                        ThemeProvider.of(context).brightness == Brightness.dark
                            ? Icon(Icons.wb_sunny, size: 25)
                            : Icon(Icons.brightness_3, size: 25),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildNavItems(IconData iconData, String title, Function tapHandler) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      onTap: tapHandler,
      leading: Icon(
        iconData,
        color: Colors.purple[400],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black87,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
