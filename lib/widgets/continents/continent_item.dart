import 'package:covid19app/helpers/custom_routes.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../screens/continent_countries_list.dart';

class ContinentItem extends StatelessWidget {
  final String title;
  final Color color;
  final String image;

  ContinentItem({this.title, this.color, this.image});

  void _selectContinent(BuildContext context) {
    Navigator.of(context).push(
      PopupScalePageRoute(
        child: ContinentCountriesList(title),
        duration: const Duration(milliseconds: 360),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 1.0, end: 0.0),
      child: InkWell(
        splashColor: kPrimaryColor,
        borderRadius: BorderRadius.circular(6),
        onTap: () => _selectContinent(context),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: image == null
                ? null
                : DecorationImage(
                    image: AssetImage("assets/images" + image.toString()),
                  ),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.6),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, value * 40),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: (1 - value).clamp(0.4, 1.0),
            child: child,
          ),
        );
      },
    );
  }
}
