import 'package:covid19app/constants/data.dart';
import 'package:covid19app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../constants/constants.dart';
import '../continents/continent_item.dart';

class Continents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLang =
        Provider.of<LanguageProvider>(context, listen: false).appLanguage;
    var deviceSize = MediaQuery.of(context).size;

    var displayedContinents = [
      Category(
        id: 'c1',
        title: appLang['asia'],
        color: Colors.yellowAccent,
      ),
      Category(
        id: 'c2',
        title: appLang['africa'],
        color: Colors.greenAccent,
      ),
      Category(
        id: 'c3',
        title: appLang['europe'],
        color: Colors.redAccent,
      ),
      Category(
        id: 'c4',
        title: appLang['northamerica'],
        color: Colors.orangeAccent,
      ),
      Category(
        id: 'c5',
        title: appLang['southamerica'],
        color: Colors.purpleAccent,
      ),
      Category(
        id: 'c6',
        title: appLang['australia'],
        color: Color(0xFF53627C),
      ),
    ];

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: deviceSize.height >= 700 ? 340 : 240,
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
                      fit: BoxFit.fill,
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
              crossAxisCount: deviceSize.width >= 750 ? 3 : 2,
              childAspectRatio: deviceSize.height >= 600 ? 3.3 / 2 : 3.5 / 2,
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
