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
      MaterialPageRoute(
        builder: (ctx) => ContinentCountriesList(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}
