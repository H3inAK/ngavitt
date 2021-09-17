import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:covid19app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/drawers/app_drawer.dart';
import '../widgets/cards/preventation_card.dart';

class PreventionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLang =
        Provider.of<LanguageProvider>(context, listen: false).appLanguage;

    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (ctx) {
              return IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/menu.svg",
                  color: Theme.of(context).accentColor,
                  width: 20,
                ),
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
              );
            },
          ),
          title: Text(
            appLang['preventions'],
            style: GoogleFonts.aclonica(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.2,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 16,
                ),
                scrollDirection: Axis.horizontal,
                children: [
                  PreventitonCard(
                    svgSrc: "assets/icons/hand_wash.svg",
                    title: appLang['preventionsWays']['washHands'],
                  ),
                  SizedBox(width: 20),
                  PreventitonCard(
                    svgSrc: "assets/icons/use_mask.svg",
                    title: appLang['preventionsWays']['wearMasks'],
                  ),
                  SizedBox(width: 20),
                  PreventitonCard(
                    svgSrc: "assets/icons/Clean_Disinfect.svg",
                    title: appLang['preventionsWays']['cleaning'],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildHelpCard(context, appLang),
          ],
        ),
      ),
    );
  }

  Container buildHelpCard(BuildContext context, Map appLang) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: appLang['preventionsWays']['dail'],
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: appLang['preventionsWays']['symptoms'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }
}
