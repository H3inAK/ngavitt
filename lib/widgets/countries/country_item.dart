import 'package:covid19app/providers/counrties_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/counrty_status.dart';
import '../../helpers/custom_routes.dart';
import '../../screens/country_covid_status_details.dart';

class CountryItem extends StatelessWidget {
  final CountryStatus countryStatus;
  final int counter;

  CountryItem(this.countryStatus, [this.counter]);

  @override
  Widget build(BuildContext context) {
    SortingType sortingType = Provider.of<CountriesProvider>(context).sortType;

    return Card(
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
          tag: countryStatus.countryName ?? ValueKey(countryStatus.countryFlag),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              countryStatus.countryFlag,
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
            ? Text("active cases - " + countryStatus.active.toString())
            : Text("total cases - " + countryStatus.cases.toString()),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
