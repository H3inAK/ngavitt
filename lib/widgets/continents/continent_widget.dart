import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../continents/continent_item.dart';

class Continents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var displayedContinents = COTINENTS;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: deviceSize.height >= 700 ? 280 : 240,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 750),
            tween: Tween(begin: 1.0, end: 0.0),
            child: Card(
              elevation: 14,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/map.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0.0, value * -100),
                child: child,
              );
            },
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: deviceSize.height >= 700 ? 3.3 / 2 : 3.5 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (ctx, i) {
              return ContinentItem(
                title: displayedContinents[i].title,
                color: displayedContinents[i].color,
              );
            },
            itemCount: displayedContinents.length,
          ),
        ),
      ],
    );
  }
}
