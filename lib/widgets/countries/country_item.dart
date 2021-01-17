import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/counrty_status.dart';
import '../../screens/country_detailed.dart';

class CountryItem extends StatelessWidget {
  final CountryStatus countryStatus;
  final int counter;

  CountryItem(this.countryStatus, [this.counter]);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
        onTap: () {
          // Navigator.of(context).push(
          //   CupertinoPageRoute(
          //     builder: (ctx) => CountryDetailsScreen(countryStatus.countryName),
          //   ),
          // );
          Navigator.of(context).pushNamed(
            CountryDetailsScreen.routeName,
            arguments: countryStatus.countryName,
          );
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            countryStatus.countryFlag,
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
        subtitle: Text("active cases - " + countryStatus.active.toString()),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
