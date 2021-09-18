import 'package:covid19app/providers/counrties_provider.dart';
import 'package:covid19app/providers/language_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/counrty_status.dart';
import '../../helpers/custom_routes.dart';
import '../../screens/country_covid_status_details.dart';

class CountryItem extends StatelessWidget {
  final Key key;
  final CountryStatus countryStatus;
  final int counter;
  final bool isAninmate;

  CountryItem({
    this.key,
    this.countryStatus,
    this.counter,
    this.isAninmate = false,
  });

  @override
  Widget build(BuildContext context) {
    SortingType sortingType = Provider.of<CountriesProvider>(context).sortType;
    final appLang =
        Provider.of<LanguageProvider>(context, listen: false).appLanguage;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.bounceOut,
      builder: (context, value, child) {
        return isAninmate
            ? Transform.scale(
                scale: value.clamp(0.86, 1.0),
                child: child,
              )
            : child;
      },
      child: Card(
        elevation: 8,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              SimplePageRoute(
                builder: (ctx) => CountryCovidStatusDetails(
                  countryStatus: countryStatus,
                ),
                duration: const Duration(milliseconds: 600),
              ),
            );
            // Navigator.of(context).pushNamed(
            //   CountryDetailsScreen.routeName,
            //   arguments: countryStatus.countryName,
            // );
          },
          leading: Hero(
            tag: countryStatus.countryName ??
                ValueKey(countryStatus.countryFlag),
            // child: CircleAvatar(
            //   backgroundImage: NetworkImage(
            //     countryStatus.countryFlag,
            //   ),
            // ),
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(1.0, 4.0),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: AssetImage('assets/images/map.png'),
                  image: NetworkImage(
                    countryStatus.countryFlag,
                  ),
                ),
              ),
            ),
          ),
          title: counter == null
              ? Text(
                  countryStatus.countryName +
                      "(" +
                      (countryStatus.countryCode ?? "No Code") +
                      ")",
                  overflow: TextOverflow.ellipsis,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        countryStatus.countryName +
                            "(" +
                            (countryStatus.countryCode ?? "No Code") +
                            ")",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Chip(
                      label: Text(
                        (counter + 1).toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
          subtitle: sortingType == SortingType.active
              ? Text(appLang['activecases'] +
                  " - " +
                  countryStatus.active.toString())
              : Text(appLang['totalcases'] +
                  " - " +
                  countryStatus.cases.toString()),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
