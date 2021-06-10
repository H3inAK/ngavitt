import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/drawers/app_drawer.dart';
import '../widgets/cards/preventation_card.dart';

class PreventationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "PREVENTIONS",
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        elevation: 0.2,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 16,
              ),
              scrollDirection: Axis.horizontal,
              children: [
                PreventitonCard(
                  svgSrc: "assets/icons/hand_wash.svg",
                  title: "Wash Hands",
                ),
                SizedBox(width: 20),
                PreventitonCard(
                  svgSrc: "assets/icons/use_mask.svg",
                  title: "Use Masks",
                ),
                SizedBox(width: 20),
                PreventitonCard(
                  svgSrc: "assets/icons/Clean_Disinfect.svg",
                  title: "Clean Disinfect",
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          buildHelpCard(context),
        ],
      ),
    );
  }

  Container buildHelpCard(BuildContext context) {
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
                    text: "Dial 999 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
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
