import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';
import '../screens/search_screen.dart';
import '../screens/all_countries.dart';
import '../widgets/drawers/app_drawer.dart';
import '../widgets/global/global_case_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: Builder(
        builder: (ctx) {
          return IconButton(
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              color: kPrimaryColor,
              width: 20,
            ),
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
          );
        },
      ),
      title: Text("NGAVITT", style: TextStyle(color: kPrimaryColor)),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            color: kPrimaryColor,
            width: 21,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
        ),
      ],
    );

    return Scaffold(
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
          Container(
            width: double.infinity,
            height: deviceSize.height >= 700 ? 100 : 90,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  color: kPrimaryColor,
                  offset: Offset(0.0, 0.4),
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AllCountriesScreen.routeName);
              },
              splashColor: kPrimaryColor.withOpacity(0.6),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("See All Countries"),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
