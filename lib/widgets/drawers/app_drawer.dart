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
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: ListView(
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
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "NGAVITT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Theme.of(context).accentColor,
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
