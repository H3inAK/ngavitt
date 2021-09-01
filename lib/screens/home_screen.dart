import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:covid19app/helpers/custom_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/search_screen.dart';
import '../screens/all_countries.dart';
import '../widgets/drawers/app_drawer.dart';
import '../widgets/global/global_case_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var appBar = AppBar(
      elevation: 0.0,
      leading: Builder(
        builder: (ctx) {
          return IconButton(
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              width: 20,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
          );
        },
      ),
      title: Text(
        "NGAVITT",
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            width: 21,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            // Navigator.of(context).pushNamed(SearchScreen.routeName);
            Navigator.of(context).push(
              FadedPageRoute(
                child: SearchScreen(),
                duration: const Duration(milliseconds: 20),
              ),
            );
          },
        ),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          drawer: AppDrawer(),
          appBar: appBar,
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, top: 18, right: 10, bottom: 20),
                  width: double.infinity,
                  color: Color(0xFF53627C).withOpacity(0.02),
                  child: GlobalCaseCard(),
                ),
              ),
              buildBottomAnimatedActionBar(deviceSize, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomAnimatedActionBar(Size deviceSize, BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: const Duration(milliseconds: 1600),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).accentColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: OutlinedButton(
          onPressed: () => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (ctx) => AllCountriesScreen(),
            ),
          ),
          style: OutlinedButton.styleFrom(
            primary: Theme.of(context).accentColor,
            padding: EdgeInsets.all(16),
            side: BorderSide.none,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "See All Countries",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(width: 25),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: deviceSize.height >= 700 ? 100 : 90,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).accentColor,
                blurRadius: 4.0,
                offset: Offset(0.0, 0.4),
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Transform.scale(
            scale: 1 - value,
            child: child,
          ),
        );
      },
    );
  }
}
